import '../models/event.dart';
import '../repositories/event_repository.dart';

class MockEventRepository implements EventRepository {
  @override
  Future<List<Event>> listUpcoming() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return [
      Event(
        id: '1',
        title: 'Stadtführung Altstadt',
        startsAt: DateTime.now().add(const Duration(hours: 3)),
        location: 'Marktplatz',
        category: 'Kultur',
      ),
      Event(
        id: '2',
        title: 'Jugendturnier FC Hersbruck',
        startsAt: DateTime.now().add(const Duration(days: 1, hours: 2)),
        location: 'Sportzentrum',
        category: 'Sport',
      ),
    ];
  }
}
