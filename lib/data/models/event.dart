class Event {
  final String id;
  final String title;
  final DateTime startsAt;
  final String location;
  final String category;

  const Event({
    required this.id,
    required this.title,
    required this.startsAt,
    required this.location,
    required this.category,
  });
}
