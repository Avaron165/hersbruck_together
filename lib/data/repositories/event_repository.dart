import 'package:hersbruck_together/data/models/event.dart';

abstract class EventRepository {
  Future<List<Event>> listUpcoming();
}
