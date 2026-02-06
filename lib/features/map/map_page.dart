import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/data/mock/mock_event_repository.dart';
import 'package:hersbruck_together/data/models/event.dart';
import 'package:hersbruck_together/features/home/event_detail_page.dart';
import 'package:hersbruck_together/features/map/map_config.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _eventRepo = MockEventRepository();
  final _mapController = MapController();

  List<Event> _events = [];
  bool _isLoading = true;

  static final _initialCenter = LatLng(
    MapConfig.initialLatitude,
    MapConfig.initialLongitude,
  );

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final events = await _eventRepo.listUpcoming();
    if (mounted) {
      setState(() {
        _events = events.where((e) => e.hasCoordinates).toList();
        _isLoading = false;
      });
    }
  }

  void _openEventDetail(Event event) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => EventDetailPage(event: event),
      ),
    );
  }

  void _recenterMap() {
    _mapController.move(_initialCenter, MapConfig.initialZoom);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildMap(),
        _buildRecenterButton(),
        if (_isLoading) _buildLoadingOverlay(),
      ],
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _initialCenter,
        initialZoom: MapConfig.initialZoom,
        minZoom: MapConfig.minZoom,
        maxZoom: MapConfig.maxZoom,
        backgroundColor: const Color(0xFF1a1a1e),
      ),
      children: [
        TileLayer(
          urlTemplate: MapConfig.tileUrl,
          userAgentPackageName: 'com.hersbruck.together',
          tileProvider: NetworkTileProvider(),
        ),
        MarkerLayer(
          markers: _buildMarkers(),
        ),
      ],
    );
  }

  List<Marker> _buildMarkers() {
    return _events.map((event) {
      return Marker(
        point: LatLng(event.latitude!, event.longitude!),
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () => _openEventDetail(event),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1a1a1e).withValues(alpha: 0.9),
              shape: BoxShape.circle,
              border: Border.all(
                color: goldAccent.withValues(alpha: 0.8),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.event,
              color: goldAccent,
              size: 20,
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildRecenterButton() {
    return Positioned(
      bottom: 100,
      right: 16,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF1a1a1e).withValues(alpha: 0.9),
          border: Border.all(
            color: goldAccent.withValues(alpha: 0.3),
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
        child: IconButton(
          onPressed: _recenterMap,
          icon: Icon(
            Icons.my_location,
            color: goldAccent.withValues(alpha: 0.9),
            size: 22,
          ),
          tooltip: 'Karte zentrieren',
        ),
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: const Color(0xFF0d0d10).withValues(alpha: 0.7),
      child: Center(
        child: CircularProgressIndicator(
          color: goldAccent.withValues(alpha: 0.7),
          strokeWidth: 2,
        ),
      ),
    );
  }
}
