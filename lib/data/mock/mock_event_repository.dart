import 'package:hersbruck_together/data/models/event.dart';
import 'package:hersbruck_together/data/repositories/event_repository.dart';

class MockEventRepository implements EventRepository {
  @override
  Future<List<Event>> listUpcoming() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return [
      Event(
        id: '1',
        title: 'Hersbrucker Weinfest',
        startsAt: today.add(const Duration(hours: 18)),
        endsAt: today.add(const Duration(hours: 23)),
        location: 'Schlossplatz Hersbruck',
        category: 'Feste',
        imageUrl: 'https://picsum.photos/seed/weinfest/300/200',
      ),
      Event(
        id: '2',
        title: 'Geführter Altstadt Rundgang',
        startsAt: today.add(const Duration(hours: 17)),
        endsAt: today.add(const Duration(hours: 18, minutes: 30)),
        location: 'Nürnberger Tor',
        category: 'Kultur',
        imageUrl: 'https://picsum.photos/seed/altstadt/300/200',
      ),
      Event(
        id: '3',
        title: 'Live-Band im Kulturbahnhof',
        startsAt: today.add(const Duration(hours: 20, minutes: 30)),
        location: 'Kulturbahnhof Hersbruck',
        category: 'Kultur',
        imageUrl: 'https://picsum.photos/seed/liveband/300/200',
      ),
      Event(
        id: '4',
        title: 'Puppentheater für Kinder',
        startsAt: today.add(const Duration(days: 1, hours: 11)),
        location: 'Hersbrucker Theatercafé',
        category: 'Familie',
        imageUrl: 'https://picsum.photos/seed/theater/300/200',
      ),
      Event(
        id: '5',
        title: 'Frühschoppen im Biergarten',
        startsAt: today.add(const Duration(days: 2, hours: 10, minutes: 30)),
        location: 'Krone Biergarten',
        category: 'Feste',
        imageUrl: 'https://picsum.photos/seed/biergarten/300/200',
      ),
      Event(
        id: '6',
        title: 'Kinderfest am Marktplatz',
        startsAt: today.add(const Duration(days: 3, hours: 14)),
        endsAt: today.add(const Duration(days: 3, hours: 18)),
        location: 'Marktplatz',
        category: 'Familie',
        imageUrl: 'https://picsum.photos/seed/kinderfest/300/200',
      ),
      Event(
        id: '7',
        title: 'Yoga im Park',
        startsAt: today.add(const Duration(days: 4, hours: 9)),
        location: 'Stadtpark',
        category: 'Freizeit',
        imageUrl: 'https://picsum.photos/seed/yogapark/300/200',
      ),
      Event(
        id: '8',
        title: 'Kunstausstellung: Lokale Künstler',
        startsAt: today.add(const Duration(days: 5, hours: 15)),
        endsAt: today.add(const Duration(days: 5, hours: 20)),
        location: 'Stadtgalerie',
        category: 'Kultur',
        imageUrl: 'https://picsum.photos/seed/kunstgalerie/300/200',
      ),
    ];
  }
}
