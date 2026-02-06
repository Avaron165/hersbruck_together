import 'dart:math' as math;

/// Point of Interest (Sehenswürdigkeit) model
class Poi {
  final String id;
  final String name;
  final String category;
  final String descriptionShort;
  final String descriptionLong;
  final double latitude;
  final double longitude;
  final String imageUrl;
  final int popularity; // 1-100, higher = more popular
  final String? openingHours;
  final String? websiteUrl;

  const Poi({
    required this.id,
    required this.name,
    required this.category,
    required this.descriptionShort,
    required this.descriptionLong,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.popularity,
    this.openingHours,
    this.websiteUrl,
  });

  /// Calculate distance to another point using Haversine formula
  double distanceTo(double lat, double lon) {
    const double earthRadius = 6371; // km

    final dLat = _toRadians(lat - latitude);
    final dLon = _toRadians(lon - longitude);

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(latitude)) *
            math.cos(_toRadians(lat)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }

  static double _toRadians(double degrees) {
    return degrees * math.pi / 180;
  }
}

/// Mock user location in Hersbruck center (Marktplatz area)
class MockUserLocation {
  static const double latitude = 49.5085;
  static const double longitude = 11.4285;
}

/// Sorting options for POI list
enum PoiSortOption {
  popular,
  nearby,
  alphabetical,
}
