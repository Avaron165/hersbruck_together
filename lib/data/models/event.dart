class Event {
  final String id;
  final String title;
  final DateTime startsAt;
  final DateTime? endsAt;
  final String location;
  final String category;
  final String? imageUrl;
  final double? latitude;
  final double? longitude;

  const Event({
    required this.id,
    required this.title,
    required this.startsAt,
    this.endsAt,
    required this.location,
    required this.category,
    this.imageUrl,
    this.latitude,
    this.longitude,
  });

  bool get hasCoordinates => latitude != null && longitude != null;
}
