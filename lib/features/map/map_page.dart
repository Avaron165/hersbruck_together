import 'dart:math' show Point;

import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
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

  MapLibreMapController? _mapController;
  List<Event> _events = [];
  bool _isLoading = true;
  final Map<String, Event> _markerEventMap = {};

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(MapConfig.initialLatitude, MapConfig.initialLongitude),
    zoom: MapConfig.initialZoom,
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

  void _onMapCreated(MapLibreMapController controller) {
    _mapController = controller;
  }

  Future<void> _onStyleLoaded() async {
    await _addEventMarkers();
  }

  Future<void> _addEventMarkers() async {
    if (_mapController == null) return;

    for (final event in _events) {
      if (!event.hasCoordinates) continue;

      final symbolOptions = SymbolOptions(
        geometry: LatLng(event.latitude!, event.longitude!),
        iconImage: 'marker',
        iconSize: 0.12,
        iconColor: '#C9A46A',
        textField: event.title,
        textSize: 11,
        textColor: '#FFFFFF',
        textHaloColor: '#000000',
        textHaloWidth: 1.5,
        textOffset: const Offset(0, 1.8),
        textAnchor: 'top',
        textMaxWidth: 12,
      );

      final symbol = await _mapController!.addSymbol(symbolOptions);
      _markerEventMap[symbol.id] = event;
    }

    _mapController!.onSymbolTapped.add(_onMarkerTapped);
  }

  void _onMarkerTapped(Symbol symbol) {
    final event = _markerEventMap[symbol.id];
    if (event != null) {
      _openEventDetail(event);
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
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(_initialCameraPosition),
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _mapController?.onSymbolTapped.remove(_onMarkerTapped);
    super.dispose();
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
    return MapLibreMap(
      styleString: MapConfig.styleUrl,
      initialCameraPosition: _initialCameraPosition,
      onMapCreated: _onMapCreated,
      onStyleLoadedCallback: _onStyleLoaded,
      minMaxZoomPreference:
          const MinMaxZoomPreference(MapConfig.minZoom, MapConfig.maxZoom),
      trackCameraPosition: true,
      compassEnabled: false,
      attributionButtonMargins: Point<num>(-100, -100),
    );
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
