import 'package:hersbruck_together/features/explore/models/poi.dart';

/// Mock repository for Points of Interest
class MockPoiRepository {
  Future<List<Poi>> listAll() async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return mockPois;
  }

  Poi? getById(String id) {
    try {
      return mockPois.firstWhere((poi) => poi.id == id);
    } catch (_) {
      return null;
    }
  }
}

/// Mock POI data for Hersbruck
final List<Poi> mockPois = [
  const Poi(
    id: 'poi-1',
    name: 'Hirtenmuseum',
    category: 'Museum',
    descriptionShort:
        'Einzigartiges Museum zur Geschichte der fränkischen Hirtenkultur.',
    descriptionLong: '''Das Deutsche Hirtenmuseum in Hersbruck ist ein einzigartiges kulturhistorisches Museum, das sich der Dokumentation und Erforschung der Hirtenkultur widmet.

Geschichte:
Das Museum wurde 1933 gegründet und ist in einem historischen Fachwerkhaus aus dem 16. Jahrhundert untergebracht. Die Sammlung umfasst über 4.000 Exponate aus ganz Europa.

Warum sehenswert:
Hier erleben Sie eine faszinierende Zeitreise in die Welt der Hirten und Schäfer. Die Ausstellung zeigt traditionelle Werkzeuge, Kleidung, Musikinstrumente und Kunsthandwerk. Besonders beeindruckend sind die kunstvoll verzierten Hirtenstäbe und die Sammlung historischer Schalmein.

Das Museum bietet regelmäßig Sonderausstellungen und Veranstaltungen, die das Thema Hirtenkultur lebendig werden lassen.''',
    latitude: 49.5092,
    longitude: 11.4298,
    imageUrl: 'https://picsum.photos/seed/hirtenmuseum/600/400',
    popularity: 95,
    openingHours: 'Di-So 10:00-17:00',
    websiteUrl: 'https://hirtenmuseum.de',
  ),
  const Poi(
    id: 'poi-2',
    name: 'Wassertor',
    category: 'Altstadt',
    descriptionShort:
        'Historisches Stadttor aus dem Mittelalter mit malerischer Kulisse.',
    descriptionLong: '''Das Wassertor ist eines der besterhaltenen mittelalterlichen Stadttore Frankens und ein Wahrzeichen von Hersbruck.

Geschichte:
Erbaut im 14. Jahrhundert als Teil der Stadtbefestigung, diente das Wassertor als wichtiger Zugang zur Stadt vom Pegnitzufer her. Der Name leitet sich von seiner Lage am Wasser ab.

Warum sehenswert:
Das imposante Tor mit seinem charakteristischen Fachwerkaufbau bietet ein wunderbares Fotomotiv. Besonders reizvoll ist der Blick von der Pegnitzbrücke auf das Tor, das sich malerisch im Wasser spiegelt.

Die umliegende Altstadt lädt zum Flanieren ein, mit gemütlichen Cafés und historischen Gebäuden.''',
    latitude: 49.5078,
    longitude: 11.4265,
    imageUrl: 'https://picsum.photos/seed/wassertor/600/400',
    popularity: 92,
  ),
  const Poi(
    id: 'poi-3',
    name: 'Michelsberg',
    category: 'Aussicht',
    descriptionShort:
        'Aussichtspunkt mit Panoramablick über die Stadt und das Pegnitztal.',
    descriptionLong: '''Der Michelsberg erhebt sich östlich von Hersbruck und bietet einen der schönsten Ausblicke der Region.

Geschichte:
Der Berg war bereits in vorgeschichtlicher Zeit besiedelt. Die Michaelskapelle auf dem Gipfel stammt aus dem 12. Jahrhundert und ist ein beliebtes Ziel für Wanderer und Pilger.

Warum sehenswert:
Der Aufstieg wird mit einem atemberaubenden 360-Grad-Panorama belohnt. Bei klarer Sicht reicht der Blick bis zur Fränkischen Schweiz. Der Sonnenuntergang vom Michelsberg ist legendär.

Der gut markierte Wanderweg führt durch Buchenwälder und bietet mehrere Rastmöglichkeiten. Ideal für einen Halbtagesausflug mit der ganzen Familie.''',
    latitude: 49.5145,
    longitude: 11.4420,
    imageUrl: 'https://picsum.photos/seed/michelsberg/600/400',
    popularity: 88,
    openingHours: 'Ganzjährig zugänglich',
  ),
  const Poi(
    id: 'poi-4',
    name: 'Stadtpfarrkirche St. Maria',
    category: 'Kirche',
    descriptionShort:
        'Gotische Hallenkirche mit bedeutenden Kunstwerken und Orgel.',
    descriptionLong: '''Die evangelische Stadtpfarrkirche St. Maria ist das geistliche Zentrum von Hersbruck und ein Meisterwerk gotischer Baukunst.

Geschichte:
Die Kirche wurde im 15. Jahrhundert erbaut und im Laufe der Jahrhunderte mehrfach erweitert. Der markante Turm prägt die Silhouette der Altstadt.

Warum sehenswert:
Im Inneren beeindrucken der spätgotische Flügelaltar, die historische Orgel und die farbigen Glasfenster. Die Akustik macht die Kirche zu einem beliebten Ort für Konzerte.

Regelmäßig finden Kirchenführungen statt, die die bewegte Geschichte und die Kunstschätze erläutern. Der Aufstieg auf den Kirchturm ermöglicht einen einzigartigen Blick über die Dächer der Stadt.''',
    latitude: 49.5082,
    longitude: 11.4278,
    imageUrl: 'https://picsum.photos/seed/stmaria/600/400',
    popularity: 85,
    openingHours: 'Täglich 9:00-18:00',
  ),
  const Poi(
    id: 'poi-5',
    name: 'Happurger Stausee',
    category: 'Natur',
    descriptionShort:
        'Idyllischer Stausee zum Wandern, Radfahren und Entspannen.',
    descriptionLong: '''Der Happurger Stausee liegt eingebettet in die Hersbrucker Alb und ist ein beliebtes Naherholungsgebiet.

Geschichte:
Der See wurde 1956 als Pumpspeicherwerk angelegt und hat sich zu einem wichtigen Biotop und Freizeitziel entwickelt. Die umliegenden Wälder und Wiesen sind Teil des Naturparks Fränkische Schweiz.

Warum sehenswert:
Der 5 km lange Rundweg um den See ist ideal für Spaziergänger und Radfahrer. Im Sommer laden mehrere Badestellen zum Schwimmen ein. Angler schätzen den Fischreichtum.

Besonders schön ist der See im Herbst, wenn sich die bunten Wälder im Wasser spiegeln. Ein Naturerlebnis zu jeder Jahreszeit.''',
    latitude: 49.4890,
    longitude: 11.4680,
    imageUrl: 'https://picsum.photos/seed/happurgersee/600/400',
    popularity: 82,
    openingHours: 'Ganzjährig zugänglich',
  ),
  const Poi(
    id: 'poi-6',
    name: 'Historischer Marktplatz',
    category: 'Altstadt',
    descriptionShort:
        'Lebendiges Zentrum mit Fachwerkhäusern und Wochenmarkt.',
    descriptionLong: '''Der Marktplatz ist das pulsierende Herz von Hersbruck und ein Ort der Begegnung seit über 600 Jahren.

Geschichte:
Bereits im Mittelalter war der Marktplatz Zentrum des Handels. Die prächtigen Bürgerhäuser zeugen vom Wohlstand der Kaufleute und Handwerker.

Warum sehenswert:
Die sorgfältig restaurierten Fachwerkhäuser bilden eine einzigartige architektonische Kulisse. Jeden Mittwoch und Samstag findet hier ein traditioneller Wochenmarkt statt, auf dem regionale Produkte angeboten werden.

Die zahlreichen Cafés und Restaurants laden zum Verweilen ein. Im Sommer ist der Marktplatz Schauplatz von Festen und kulturellen Veranstaltungen.''',
    latitude: 49.5080,
    longitude: 11.4275,
    imageUrl: 'https://picsum.photos/seed/marktplatz/600/400',
    popularity: 90,
  ),
  const Poi(
    id: 'poi-7',
    name: 'Schloss Hersbruck',
    category: 'Museum',
    descriptionShort:
        'Renaissanceschloss mit Stadtmuseum und wechselnden Ausstellungen.',
    descriptionLong: '''Das Hersbrucker Schloss thront über der Altstadt und beherbergt heute das Stadtmuseum.

Geschichte:
Die Anlage geht auf eine mittelalterliche Burg zurück und wurde im 16. Jahrhundert zum Renaissanceschloss umgebaut. Die Pfälzer Kurfürsten nutzten es als Amtssitz.

Warum sehenswert:
Das Stadtmuseum präsentiert die wechselvolle Geschichte Hersbrucks von der Steinzeit bis zur Gegenwart. Besonders beeindruckend sind die archäologischen Funde und die Sammlung historischer Zunftzeichen.

Der Schlosshof mit seinem Renaissance-Brunnen ist ein beliebter Ort für Konzerte und Theateraufführungen im Sommer.''',
    latitude: 49.5095,
    longitude: 11.4290,
    imageUrl: 'https://picsum.photos/seed/schloss/600/400',
    popularity: 78,
    openingHours: 'Mi-So 14:00-17:00',
  ),
  const Poi(
    id: 'poi-8',
    name: 'Hohenstein',
    category: 'Aussicht',
    descriptionShort:
        'Markanter Felsgipfel mit Burgruine und spektakulärer Fernsicht.',
    descriptionLong: '''Der Hohenstein ist ein Wahrzeichen der Hersbrucker Schweiz und ein beliebtes Ausflugsziel für Wanderer und Kletterer.

Geschichte:
Auf dem Felsen thronte einst eine mittelalterliche Burg, von der noch Mauerreste erhalten sind. Der Aussichtsturm wurde 1901 erbaut.

Warum sehenswert:
Der Aufstieg über den felsigen Pfad ist ein kleines Abenteuer. Oben angekommen, belohnt ein grandioser Rundblick über die Hersbrucker Alb und das Pegnitztal.

Für Kletterer bietet der Hohenstein verschiedene Routen in unterschiedlichen Schwierigkeitsgraden. Das Gasthaus am Fuß des Felsens lädt zur Einkehr ein.''',
    latitude: 49.5280,
    longitude: 11.4580,
    imageUrl: 'https://picsum.photos/seed/hohenstein/600/400',
    popularity: 86,
    openingHours: 'Ganzjährig zugänglich',
  ),
  const Poi(
    id: 'poi-9',
    name: 'Pegnitzauen',
    category: 'Natur',
    descriptionShort:
        'Naturschutzgebiet mit artenreicher Flora und Fauna entlang der Pegnitz.',
    descriptionLong: '''Die Pegnitzauen erstrecken sich entlang des Flusses und sind ein wichtiges Rückzugsgebiet für seltene Tier- und Pflanzenarten.

Geschichte:
Die Auenlandschaft wurde 1995 unter Naturschutz gestellt. Renaturierungsmaßnahmen haben die ursprüngliche Flusslandschaft wiederhergestellt.

Warum sehenswert:
Der Auenpfad führt auf Stegen und Pfaden durch die faszinierende Wasserlandschaft. Mit etwas Glück beobachtet man Eisvögel, Biber und seltene Orchideen.

Besonders im Frühjahr, wenn die Auen überflutet sind, bietet sich ein einzigartiges Naturschauspiel. Informationstafeln erläutern die Bedeutung des Ökosystems.''',
    latitude: 49.5055,
    longitude: 11.4200,
    imageUrl: 'https://picsum.photos/seed/pegnitzauen/600/400',
    popularity: 75,
    openingHours: 'Ganzjährig zugänglich',
  ),
  const Poi(
    id: 'poi-10',
    name: 'Felsenkeller',
    category: 'Museum',
    descriptionShort:
        'Historische Bierkeller unter der Altstadt mit Führungen.',
    descriptionLong: '''Die Hersbrucker Felsenkeller sind ein einzigartiges Zeugnis der fränkischen Braukultur.

Geschichte:
Seit dem 16. Jahrhundert wurden unter der Altstadt Keller in den Sandstein gehauen, um Bier kühl zu lagern. Das Labyrinth erstreckt sich über mehrere Ebenen.

Warum sehenswert:
Bei Führungen taucht man ein in die kühle Unterwelt und erfährt Spannendes über die Braugeschichte. Die konstant kühle Temperatur von 8-10 Grad machte die Keller vor der Erfindung der Kühltechnik unverzichtbar.

Die stimmungsvolle Beleuchtung und die Geschichten des Kellermeisters machen den Besuch zu einem unvergesslichen Erlebnis.''',
    latitude: 49.5075,
    longitude: 11.4282,
    imageUrl: 'https://picsum.photos/seed/felsenkeller/600/400',
    popularity: 80,
    openingHours: 'Führungen: Sa 14:00, 16:00',
    websiteUrl: 'https://hersbruck.de/felsenkeller',
  ),
];
