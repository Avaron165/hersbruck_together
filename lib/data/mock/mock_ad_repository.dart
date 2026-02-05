import 'package:hersbruck_together/data/models/ad.dart';

class MockAdRepository {
  Ad? getSponsoredAd() {
    return const Ad(
      id: 'sponsor_1',
      title: 'Fränkische Köstlichkeiten',
      subtitle: 'Regionale Spezialitäten direkt vom Erzeuger',
      imageUrl: 'https://picsum.photos/seed/sponsor_food/300/200',
      sponsorName: 'Genussregion Hersbruck',
      ctaLabel: 'Mehr erfahren',
    );
  }
}
