import 'package:hersbruck_together/data/models/event.dart';
import 'package:hersbruck_together/data/repositories/event_repository.dart';

class MockEventRepository implements EventRepository {
  @override
  Future<List<Event>> listUpcoming() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final now = DateTime.now();
    return [
      Event(
        id: '1',
        title: 'Stadtführung Altstadt',
        startsAt: now.add(const Duration(hours: 3)),
        location: 'Marktplatz',
        category: 'Kultur',
      ),
      Event(
        id: '2',
        title: 'Jugendturnier FC Hersbruck',
        startsAt: now.add(const Duration(days: 1, hours: 2)),
        location: 'Sportzentrum',
        category: 'Sport',
      ),
      Event(
        id: '3',
        title: 'Familienflohmarkt am Rathaus',
        startsAt: now.add(const Duration(hours: 5)),
        location: 'Rathausplatz',
        category: 'Familie',
      ),
      Event(
        id: '4',
        title: 'Konzert: Hersbrucker Blasmusik',
        startsAt: now.add(const Duration(days: 2, hours: 4)),
        location: 'Festsaal',
        category: 'Musik',
      ),
      Event(
        id: '5',
        title: 'Bauernmarkt mit regionalen Spezialitäten',
        startsAt: now.add(const Duration(days: 3, hours: 1)),
        location: 'Marktplatz',
        category: 'Essen',
      ),
      Event(
        id: '6',
        title: 'Wanderung durch das Pegnitztal',
        startsAt: now.add(const Duration(days: 1, hours: 6)),
        location: 'Wanderparkplatz Ost',
        category: 'Natur',
      ),
      Event(
        id: '7',
        title: 'Kunstausstellung: Lokale Künstler',
        startsAt: now.add(const Duration(hours: 2)),
        location: 'Stadtgalerie',
        category: 'Kultur',
      ),
      Event(
        id: '8',
        title: 'Yoga im Park für Anfänger',
        startsAt: now.add(const Duration(days: 2, hours: 8)),
        location: 'Stadtpark',
        category: 'Sport',
      ),
    ];
  }
}
