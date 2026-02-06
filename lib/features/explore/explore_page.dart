import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/features/explore/mock/mock_pois.dart';
import 'package:hersbruck_together/features/explore/models/poi.dart';
import 'package:hersbruck_together/features/explore/poi_detail_page.dart';
import 'package:hersbruck_together/features/explore/widgets/poi_card.dart';
import 'package:hersbruck_together/features/explore/widgets/poi_map.dart';
import 'package:hersbruck_together/features/explore/widgets/sort_row.dart';
import 'package:hersbruck_together/ui/widgets/elegant_background.dart';
import 'package:latlong2/latlong.dart';

enum ExploreViewMode { list, map }

/// Explore page showing Sehenswürdigkeiten (Points of Interest)
/// with List and Map view modes
class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final _poiRepository = MockPoiRepository();

  ExploreViewMode _viewMode = ExploreViewMode.list;
  PoiSortOption _sortOption = PoiSortOption.popular;
  List<Poi>? _pois;
  bool _isLoading = true;

  // For focusing on a specific POI when returning from detail page
  String? _focusPoiId;

  @override
  void initState() {
    super.initState();
    _loadPois();
  }

  Future<void> _loadPois() async {
    final pois = await _poiRepository.listAll();
    if (mounted) {
      setState(() {
        _pois = pois;
        _isLoading = false;
      });
    }
  }

  List<Poi> _getSortedPois() {
    if (_pois == null) return [];

    final sorted = List<Poi>.from(_pois!);

    switch (_sortOption) {
      case PoiSortOption.popular:
        sorted.sort((a, b) => b.popularity.compareTo(a.popularity));
        break;
      case PoiSortOption.nearby:
        sorted.sort((a, b) {
          final distA = a.distanceTo(
            MockUserLocation.latitude,
            MockUserLocation.longitude,
          );
          final distB = b.distanceTo(
            MockUserLocation.latitude,
            MockUserLocation.longitude,
          );
          return distA.compareTo(distB);
        });
        break;
      case PoiSortOption.alphabetical:
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
    }

    return sorted;
  }

  double? _getDistance(Poi poi) {
    if (_sortOption != PoiSortOption.nearby) return null;
    return poi.distanceTo(
      MockUserLocation.latitude,
      MockUserLocation.longitude,
    );
  }

  Future<void> _openPoiDetail(Poi poi) async {
    final result = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute<Map<String, dynamic>>(
        builder: (context) => PoiDetailPage(poi: poi),
      ),
    );

    // Check if we should show the POI on the map
    if (result != null && result['showOnMap'] == true) {
      setState(() {
        _viewMode = ExploreViewMode.map;
        _focusPoiId = poi.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _viewMode == ExploreViewMode.map
        ? _buildMapView()
        : _buildListView();
  }

  Widget _buildListView() {
    return ElegantBackground(
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: CustomScrollView(
              slivers: [
                // Header with toggle
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: _buildHeader(),
                  ),
                ),
                // Sort row
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                    child: SortRow(
                      selectedOption: _sortOption,
                      onOptionSelected: (option) {
                        setState(() {
                          _sortOption = option;
                        });
                      },
                    ),
                  ),
                ),
                // POI list
                if (_isLoading)
                  SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: goldAccent.withValues(alpha: 0.7),
                        strokeWidth: 2,
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final pois = _getSortedPois();
                          final poi = pois[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: PoiCard(
                              poi: poi,
                              distance: _getDistance(poi),
                              onTap: () => _openPoiDetail(poi),
                            ),
                          );
                        },
                        childCount: _getSortedPois().length,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMapView() {
    // Clear focus after initial render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_focusPoiId != null) {
        setState(() {
          _focusPoiId = null;
        });
      }
    });

    return Stack(
      children: [
        // Map
        PoiMap(
          pois: _pois ?? [],
          focusPoiId: _focusPoiId,
          initialCenter: _focusPoiId != null
              ? LatLng(
                  _pois!.firstWhere((p) => p.id == _focusPoiId).latitude,
                  _pois!.firstWhere((p) => p.id == _focusPoiId).longitude,
                )
              : null,
          onPoiTap: _openPoiDetail,
        ),
        // Header overlay
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF0A0A0E),
                  const Color(0xFF0A0A0E).withValues(alpha: 0.8),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.6, 1.0],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: _buildHeader(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row with view toggle
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.explore_outlined,
                        size: 20,
                        color: goldAccent.withValues(alpha: 0.8),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Entdecken',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sehenswürdigkeiten in Hersbruck',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            // View mode toggle
            _buildViewToggle(),
          ],
        ),
      ],
    );
  }

  Widget _buildViewToggle() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ToggleButton(
            icon: Icons.view_list,
            label: 'Liste',
            isSelected: _viewMode == ExploreViewMode.list,
            onTap: () {
              setState(() {
                _viewMode = ExploreViewMode.list;
              });
            },
          ),
          _ToggleButton(
            icon: Icons.map_outlined,
            label: 'Karte',
            isSelected: _viewMode == ExploreViewMode.map,
            onTap: () {
              setState(() {
                _viewMode = ExploreViewMode.map;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected
                ? goldAccent.withValues(alpha: 0.15)
                : Colors.transparent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected
                    ? goldAccent
                    : Colors.white.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? goldAccent
                      : Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
