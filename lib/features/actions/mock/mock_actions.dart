import 'package:hersbruck_together/features/actions/models/action_item.dart';

/// Mock repository for partner actions
class MockActionRepository {
  Future<List<ActionItem>> listAll() async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return mockActions;
  }

  ActionItem? getById(String id) {
    try {
      return mockActions.firstWhere((action) => action.id == id);
    } catch (_) {
      return null;
    }
  }
}

/// Mock action data
final List<ActionItem> mockActions = [
  ActionItem(
    id: 'action-1',
    partnerName: 'Café am Markt',
    title: '10% Rabatt auf Kaffee & Kuchen',
    shortDesc: 'Genießen Sie Kaffee und hausgemachten Kuchen mit Rabatt.',
    longDesc: '''Willkommen im Café am Markt! Mit dieser exklusiven Aktion für Hersbruck Together Nutzer erhalten Sie 10% Rabatt auf alle Kaffeegetränke und hausgemachten Kuchen.

So funktioniert's:
Zeigen Sie diesen Bildschirm einfach beim Bezahlen vor oder nennen Sie den Aktionscode. Der Rabatt wird direkt an der Kasse abgezogen.

Unser Café bietet:
• Frisch gerösteten Kaffee aus der Region
• Täglich frische, hausgemachte Kuchen
• Gemütliche Atmosphäre mit Blick auf den Marktplatz
• Freundliches Personal

Wir freuen uns auf Ihren Besuch!''',
    category: ActionCategory.food,
    type: ActionType.rabatt,
    validityText: 'Gültig bis 31.03.2026',
    validFrom: DateTime(2026, 1, 1),
    validTo: DateTime(2026, 3, 31),
    isNew: false,
    imageUrl: 'https://picsum.photos/seed/cafe-markt/600/400',
    redeemCode: 'CAFE10',
    redeemHint: 'Code an der Kasse nennen oder Bildschirm zeigen',
  ),
  ActionItem(
    id: 'action-2',
    partnerName: 'Physio Vital',
    title: 'Gratis Erstberatung',
    shortDesc: 'Kostenlose physiotherapeutische Erstberatung für Neukunden.',
    longDesc: '''Physio Vital bietet allen Hersbruck Together Nutzern eine kostenlose Erstberatung an.

Was Sie erwartet:
• 30-minütiges Beratungsgespräch
• Erste Analyse Ihrer Beschwerden
• Individuelle Empfehlungen
• Keine Verpflichtung

Unsere Leistungen:
Wir sind spezialisiert auf Rückenbeschwerden, Sportverletzungen, Rehabilitation nach Operationen und präventive Maßnahmen. Unser erfahrenes Team nimmt sich Zeit für Sie.

Vereinbaren Sie jetzt Ihren Termin telefonisch oder online und erwähnen Sie den Aktionscode.''',
    category: ActionCategory.wellness,
    type: ActionType.aktion,
    validityText: 'Nur diese Woche',
    validFrom: DateTime.now(),
    validTo: DateTime.now().add(const Duration(days: 7)),
    isNew: true,
    imageUrl: 'https://picsum.photos/seed/physio-vital/600/400',
    redeemCode: 'VITAL2026',
    redeemHint: 'Bei Terminvereinbarung Code angeben',
  ),
  ActionItem(
    id: 'action-3',
    partnerName: 'Bäckerei Schmidt',
    title: '2+1 Brötchen-Aktion',
    shortDesc: 'Beim Kauf von 2 Brötchen gibt es das 3. gratis dazu.',
    longDesc: '''Die Bäckerei Schmidt lädt ein zur beliebten 2+1 Brötchen-Aktion!

Aktion:
Kaufen Sie 2 Brötchen Ihrer Wahl und erhalten Sie ein weiteres Brötchen kostenlos dazu. Die Aktion gilt für alle Brötchensorten.

Unser Sortiment:
• Klassische Semmeln und Laugenwaren
• Vollkorn- und Dinkelbrötchen
• Spezialitäten wie Kürbiskernbrötchen
• Täglich frisch aus dem Ofen

Seit 1923 backen wir mit Liebe und Tradition. Überzeugen Sie sich selbst von unserer Qualität.''',
    category: ActionCategory.food,
    type: ActionType.aktion,
    validityText: 'Gültig bis 28.02.2026',
    validFrom: DateTime(2026, 2, 1),
    validTo: DateTime(2026, 2, 28),
    isNew: false,
    imageUrl: 'https://picsum.photos/seed/baeckerei/600/400',
    redeemHint: 'Einfach an der Theke erwähnen',
  ),
  ActionItem(
    id: 'action-4',
    partnerName: 'Hirtenmuseum',
    title: 'Freier Eintritt für Familien',
    shortDesc: 'Jeden ersten Sonntag im Monat: Familien zahlen keinen Eintritt.',
    longDesc: '''Das Deutsche Hirtenmuseum öffnet seine Türen für Familien!

Aktion:
Jeden ersten Sonntag im Monat haben Familien freien Eintritt. Erleben Sie gemeinsam die faszinierende Geschichte der Hirtenkultur.

Was Sie erwartet:
• Über 4.000 Exponate aus ganz Europa
• Interaktive Stationen für Kinder
• Sonderführungen für Familien um 14:00 Uhr
• Museumscafé mit Kinderkarte

Für Kinder:
Unsere kleinen Besucher können an speziellen Mitmach-Stationen selbst aktiv werden und die Welt der Hirten spielerisch entdecken.''',
    category: ActionCategory.kultur,
    type: ActionType.special,
    validityText: 'Jeden 1. Sonntag im Monat',
    isNew: true,
    imageUrl: 'https://picsum.photos/seed/museum/600/400',
    redeemHint: 'Einfach an der Kasse als Familie anmelden',
  ),
  ActionItem(
    id: 'action-5',
    partnerName: 'Sport Müller',
    title: '15% auf alle Laufschuhe',
    shortDesc: 'Exklusiver Rabatt auf das gesamte Laufschuh-Sortiment.',
    longDesc: '''Sport Müller bietet Hersbruck Together Nutzern 15% Rabatt auf alle Laufschuhe!

Unser Sortiment:
• Marken wie Nike, Adidas, Asics, Brooks
• Für Anfänger bis Profis
• Straßen- und Traillaufschuhe
• Individuelle Beratung inklusive

Service:
Lassen Sie sich von unseren geschulten Mitarbeitern beraten. Wir analysieren Ihren Laufstil und finden den perfekten Schuh für Sie.

Die Aktion ist nicht mit anderen Rabatten kombinierbar.''',
    category: ActionCategory.sport,
    type: ActionType.rabatt,
    validityText: 'Gültig bis 15.03.2026',
    validFrom: DateTime(2026, 2, 1),
    validTo: DateTime(2026, 3, 15),
    isNew: false,
    imageUrl: 'https://picsum.photos/seed/sport-schuhe/600/400',
    redeemCode: 'LAUF15',
    redeemHint: 'Code an der Kasse nennen',
  ),
  ActionItem(
    id: 'action-6',
    partnerName: 'Brauerei Fränkisch',
    title: 'Brauereibesichtigung zum Sonderpreis',
    shortDesc: 'Führung durch die Brauerei mit Verkostung für nur 8€ statt 12€.',
    longDesc: '''Entdecken Sie die Welt des fränkischen Bieres!

Angebot:
Die beliebte Brauereibesichtigung mit Verkostung zum reduzierten Preis von nur 8€ (statt regulär 12€).

Was Sie erwartet:
• 90-minütige Führung durch die historische Brauerei
• Einblick in den Brauprozess
• Verkostung von 4 verschiedenen Biersorten
• Kleines Präsent zum Mitnehmen

Termine:
Jeden Samstag um 14:00 und 16:00 Uhr. Anmeldung erforderlich.

Mindestalter 16 Jahre. Bitte gültigen Ausweis mitbringen.''',
    category: ActionCategory.freizeit,
    type: ActionType.rabatt,
    validityText: 'Gültig bis 30.04.2026',
    validFrom: DateTime(2026, 1, 1),
    validTo: DateTime(2026, 4, 30),
    isNew: false,
    imageUrl: 'https://picsum.photos/seed/brauerei/600/400',
    redeemCode: 'BRAU2026',
    redeemHint: 'Bei Online-Buchung Code eingeben',
  ),
  ActionItem(
    id: 'action-7',
    partnerName: 'Buchhandlung Lesezeit',
    title: 'Gratis Lesezeichen bei jedem Einkauf',
    shortDesc: 'Handgefertigtes Lesezeichen als Geschenk bei jedem Kauf.',
    longDesc: '''Die Buchhandlung Lesezeit freut sich, Ihnen ein kleines Geschenk zu machen!

Aktion:
Bei jedem Einkauf erhalten Hersbruck Together Nutzer ein handgefertigtes Lesezeichen aus unserer exklusiven Kollektion.

Unsere Buchhandlung:
• Große Auswahl an Belletristik und Sachbüchern
• Regionale Autoren und Titel
• Gemütliche Leseecke
• Kompetente Beratung

Events:
Regelmäßig finden Lesungen und Buchvorstellungen statt. Schauen Sie in unseren Veranstaltungskalender!''',
    category: ActionCategory.kultur,
    type: ActionType.aktion,
    validityText: 'Solange Vorrat reicht',
    isNew: true,
    imageUrl: 'https://picsum.photos/seed/buchhandlung/600/400',
    redeemHint: 'App an der Kasse zeigen',
  ),
  ActionItem(
    id: 'action-8',
    partnerName: 'Autohaus Müller',
    title: 'Kostenloser Wintercheck',
    shortDesc: 'Umfangreicher Fahrzeug-Wintercheck ohne Kosten.',
    longDesc: '''Machen Sie Ihr Fahrzeug winterfit – kostenlos!

Unser Wintercheck umfasst:
• Prüfung der Batterie
• Kontrolle der Beleuchtung
• Check der Scheibenwischer und Wischwasser
• Reifenprofil-Messung
• Frostschutz-Prüfung

Terminvereinbarung:
Rufen Sie uns an oder buchen Sie online. Die Aktion ist gültig für PKW aller Marken.

Autohaus Müller – Ihr kompetenter Partner seit über 40 Jahren.''',
    category: ActionCategory.freizeit,
    type: ActionType.special,
    validityText: 'Gültig bis 28.02.2026',
    validFrom: DateTime(2026, 1, 1),
    validTo: DateTime(2026, 2, 28),
    isNew: false,
    imageUrl: 'https://picsum.photos/seed/autohaus/600/400',
    redeemCode: 'WINTER26',
    redeemHint: 'Bei Terminbuchung Code angeben',
  ),
  ActionItem(
    id: 'action-9',
    partnerName: 'Yoga Studio Balance',
    title: 'Erste Stunde kostenlos',
    shortDesc: 'Schnuppern Sie kostenlos in eine Yoga-Stunde Ihrer Wahl.',
    longDesc: '''Entdecken Sie Yoga im Studio Balance!

Angebot:
Ihre erste Yoga-Stunde ist komplett kostenlos. Wählen Sie aus unserem vielfältigen Kursangebot.

Unsere Kurse:
• Hatha Yoga für Einsteiger
• Vinyasa Flow für Fortgeschrittene
• Yin Yoga zur Entspannung
• Yoga für Rückengesundheit

Keine Vorkenntnisse nötig:
Unsere erfahrenen Lehrer heißen Anfänger herzlich willkommen. Matten und Hilfsmittel sind vorhanden.

Anmeldung über unsere Website oder telefonisch.''',
    category: ActionCategory.wellness,
    type: ActionType.aktion,
    validityText: 'Für Neukunden',
    isNew: true,
    imageUrl: 'https://picsum.photos/seed/yoga-studio/600/400',
    redeemCode: 'YOGA1',
    redeemHint: 'Bei Anmeldung Code angeben',
  ),
  ActionItem(
    id: 'action-10',
    partnerName: 'Mode Boutique Eleganz',
    title: '20% auf die Frühjahrskollektion',
    shortDesc: 'Exklusiver Rabatt auf die neue Frühjahrsmode.',
    longDesc: '''Die neue Frühjahrskollektion ist da!

Aktion:
Erhalten Sie 20% Rabatt auf alle Artikel der neuen Frühjahrskollektion. Nur für Hersbruck Together Nutzer.

Unsere Marken:
• Ausgewählte Designer-Labels
• Hochwertige Basics
• Accessoires und Schmuck
• Nachhaltige Mode

Service:
Gerne beraten wir Sie persönlich und finden gemeinsam Ihren perfekten Look. Änderungsservice im Haus.

Die Aktion ist nicht mit anderen Rabatten kombinierbar.''',
    category: ActionCategory.shopping,
    type: ActionType.rabatt,
    validityText: 'Gültig bis 30.04.2026',
    validFrom: DateTime(2026, 3, 1),
    validTo: DateTime(2026, 4, 30),
    isNew: false,
    imageUrl: 'https://picsum.photos/seed/mode-boutique/600/400',
    redeemCode: 'SPRING20',
    redeemHint: 'Code an der Kasse nennen',
  ),
];
