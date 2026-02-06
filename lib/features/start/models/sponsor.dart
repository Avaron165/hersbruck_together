import 'package:flutter/material.dart';

enum SponsorTier {
  gold,
  partner,
  supporter,
}

class Sponsor {
  final String id;
  final String name;
  final String tagline;
  final SponsorTier tier;
  final String description;
  final IconData icon;
  final String? imageUrl;

  const Sponsor({
    required this.id,
    required this.name,
    required this.tagline,
    required this.tier,
    required this.description,
    required this.icon,
    this.imageUrl,
  });

  String get tierLabel {
    switch (tier) {
      case SponsorTier.gold:
        return 'Gold Partner';
      case SponsorTier.partner:
        return 'Partner';
      case SponsorTier.supporter:
        return 'Förderer';
    }
  }
}

/// Demo sponsors for the carousel
final List<Sponsor> demoSponsors = [
  const Sponsor(
    id: '1',
    name: 'Sparkasse Hersbruck',
    tagline: 'Unterstützt Kultur & Sport',
    tier: SponsorTier.gold,
    description:
        'Die Sparkasse Hersbruck engagiert sich seit vielen Jahren für das kulturelle und sportliche Leben in unserer Region. Als verlässlicher Partner fördern wir lokale Vereine und Initiativen.',
    icon: Icons.account_balance,
  ),
  const Sponsor(
    id: '2',
    name: 'Bäckerei Schmidt',
    tagline: 'Tradition seit 1923',
    tier: SponsorTier.partner,
    description:
        'Handwerkliche Backkunst aus Hersbruck. Wir backen mit Liebe und regionalen Zutaten für unsere Gemeinschaft.',
    icon: Icons.bakery_dining,
  ),
  const Sponsor(
    id: '3',
    name: 'Café am Markt',
    tagline: 'Ihr Treffpunkt in der Altstadt',
    tier: SponsorTier.partner,
    description:
        'Genießen Sie Kaffee und hausgemachte Kuchen mit Blick auf den historischen Marktplatz. Ein Ort der Begegnung.',
    icon: Icons.local_cafe,
  ),
  const Sponsor(
    id: '4',
    name: 'Autohaus Müller',
    tagline: 'Mobilität für die Region',
    tier: SponsorTier.gold,
    description:
        'Seit über 40 Jahren Ihr kompetenter Partner für Fahrzeuge aller Art. Service, Beratung und Zuverlässigkeit.',
    icon: Icons.directions_car,
  ),
  const Sponsor(
    id: '5',
    name: 'Physio Vital',
    tagline: 'Gesundheit & Wohlbefinden',
    tier: SponsorTier.supporter,
    description:
        'Physiotherapie und Wellness im Herzen von Hersbruck. Wir bringen Sie wieder in Bewegung.',
    icon: Icons.spa,
  ),
  const Sponsor(
    id: '6',
    name: 'Brauerei Fränkisch',
    tagline: 'Bierkultur aus der Heimat',
    tier: SponsorTier.partner,
    description:
        'Fränkische Brautradition trifft auf moderne Kreativität. Unsere Biere werden mit Liebe und nach altem Rezept gebraut.',
    icon: Icons.sports_bar,
  ),
];
