/// Map configuration constants for Hersbruck Together app.
///
/// These constants can be adjusted for different environments or
/// when switching to a different map tile provider.
class MapConfig {
  MapConfig._();

  /// MapTiler dark raster tile URL (includes API key)
  /// Uses {z}/{x}/{y} placeholders for tile coordinates
  static const String tileUrl =
      'https://api.maptiler.com/maps/dataviz-dark/{z}/{x}/{y}.png?key=XPJaPqQZV6bxT6HBvwlQ';

  /// Initial map center: Hersbruck, Germany
  static const double initialLatitude = 49.5086;
  static const double initialLongitude = 11.4283;

  /// Initial zoom level (city-level view)
  static const double initialZoom = 14.0;

  /// Min/Max zoom constraints
  static const double minZoom = 10.0;
  static const double maxZoom = 18.0;
}
