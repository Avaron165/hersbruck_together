import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/features/explore/models/poi.dart';
import 'package:hersbruck_together/features/map/map_config.dart';
import 'package:latlong2/latlong.dart';

/// Map view for Points of Interest with custom markers
class PoiMap extends StatefulWidget {
  final List<Poi> pois;
  final LatLng? initialCenter;
  final String? focusPoiId;
  final Function(Poi poi) onPoiTap;

  const PoiMap({
    super.key,
    required this.pois,
    required this.onPoiTap,
    this.initialCenter,
    this.focusPoiId,
  });

  @override
  State<PoiMap> createState() => _PoiMapState();
}

class _PoiMapState extends State<PoiMap> {
  late final MapController _mapController;
  Poi? _selectedPoi;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    // Focus on specific POI if provided
    if (widget.focusPoiId != null) {
      final focusPoi = widget.pois.where((p) => p.id == widget.focusPoiId).firstOrNull;
      if (focusPoi != null) {
        _selectedPoi = focusPoi;
      }
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _centerOnHersbruck() {
    _mapController.move(
      LatLng(MapConfig.initialLatitude, MapConfig.initialLongitude),
      MapConfig.initialZoom,
    );
    setState(() {
      _selectedPoi = null;
    });
  }

  void _onMarkerTap(Poi poi) {
    setState(() {
      _selectedPoi = poi;
    });
    // Center map on the selected POI
    _mapController.move(
      LatLng(poi.latitude, poi.longitude),
      15.5,
    );
  }

  @override
  Widget build(BuildContext context) {
    final center = widget.initialCenter ??
        LatLng(MapConfig.initialLatitude, MapConfig.initialLongitude);

    return Stack(
      children: [
        // Map
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: center,
            initialZoom: MapConfig.initialZoom,
            minZoom: MapConfig.minZoom,
            maxZoom: MapConfig.maxZoom,
            onTap: (_, __) {
              setState(() {
                _selectedPoi = null;
              });
            },
          ),
          children: [
            // Tile layer
            TileLayer(
              urlTemplate: MapConfig.tileUrl,
              userAgentPackageName: 'de.hersbruck.together',
            ),
            // Markers
            MarkerLayer(
              markers: widget.pois.map((poi) => _buildMarker(poi)).toList(),
            ),
          ],
        ),
        // Recenter button
        Positioned(
          bottom: _selectedPoi != null ? 170 : 100,
          right: 16,
          child: _buildRecenterButton(),
        ),
        // Preview card when marker is selected
        if (_selectedPoi != null)
          Positioned(
            bottom: 90,
            left: 16,
            right: 16,
            child: _PoiPreviewCard(
              poi: _selectedPoi!,
              onTap: () => widget.onPoiTap(_selectedPoi!),
              onClose: () {
                setState(() {
                  _selectedPoi = null;
                });
              },
            ),
          ),
      ],
    );
  }

  Marker _buildMarker(Poi poi) {
    final isSelected = _selectedPoi?.id == poi.id;

    return Marker(
      point: LatLng(poi.latitude, poi.longitude),
      width: isSelected ? 48 : 40,
      height: isSelected ? 56 : 48,
      child: GestureDetector(
        onTap: () => _onMarkerTap(poi),
        child: _PoiMarker(
          poi: poi,
          isSelected: isSelected,
        ),
      ),
    );
  }

  Widget _buildRecenterButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _centerOnHersbruck,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF1a1a1e).withValues(alpha: 0.9),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            Icons.my_location,
            size: 20,
            color: goldAccent.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }
}

/// Custom marker for POI
class _PoiMarker extends StatelessWidget {
  final Poi poi;
  final bool isSelected;

  const _PoiMarker({
    required this.poi,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isSelected ? 1.2 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? goldAccent
                  : const Color(0xFF1a1a1e).withValues(alpha: 0.95),
              border: Border.all(
                color: isSelected
                    ? goldAccent
                    : goldAccent.withValues(alpha: 0.6),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? goldAccent.withValues(alpha: 0.4)
                      : Colors.black.withValues(alpha: 0.4),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(
              _getCategoryIcon(),
              size: 18,
              color: isSelected ? Colors.black : goldAccent,
            ),
          ),
          // Pin point
          Container(
            width: 2,
            height: 8,
            decoration: BoxDecoration(
              color: isSelected
                  ? goldAccent
                  : goldAccent.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon() {
    switch (poi.category) {
      case 'Museum':
        return Icons.museum;
      case 'Altstadt':
        return Icons.location_city;
      case 'Aussicht':
        return Icons.landscape;
      case 'Kirche':
        return Icons.church;
      case 'Natur':
        return Icons.park;
      default:
        return Icons.place;
    }
  }
}

/// Preview card shown when a marker is tapped
class _PoiPreviewCard extends StatelessWidget {
  final Poi poi;
  final VoidCallback onTap;
  final VoidCallback onClose;

  const _PoiPreviewCard({
    required this.poi,
    required this.onTap,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFF1a1a1e).withValues(alpha: 0.95),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    poi.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 60,
                      height: 60,
                      color: Colors.white.withValues(alpha: 0.1),
                      child: Icon(
                        Icons.image,
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: goldAccent.withValues(alpha: 0.15),
                            ),
                            child: Text(
                              poi.category,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: goldAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        poi.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        poi.descriptionShort,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Actions
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: onClose,
                      child: Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.white.withValues(alpha: 0.4),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Icon(
                      Icons.arrow_forward,
                      size: 18,
                      color: goldAccent.withValues(alpha: 0.6),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
