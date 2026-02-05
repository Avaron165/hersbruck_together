# Claude Tasks – Hersbruck Together (Flutter UI Mockup)

## Ziel
Baue ein hochwertiges UI-Mockup für „Hersbruck Together“ (ohne echte Datenanbindung).
Die App soll wie ein echtes Produkt wirken: sauber, modern, ruhig, viel Weißraum, Material 3.
Akzentfarbe: ruhiges Blau (Theme Seed ist bereits gesetzt).

## Wichtig: Architekturregeln (nicht verletzen)
- Keine neue App-Architektur erfinden, kein Riverpod/BLoC etc. einführen.
- Keine Ordnerstruktur umbauen.
- Arbeite nur unter `lib/` und ggf. `assets/` (falls du Icons brauchst, nutze Material Icons, keine externen Assets).
- Daten kommen weiterhin über `EventRepository` → aktuell `MockEventRepository`.
- Keine Netzwerk-/Backend-Calls, kein Supabase.
- Keine Dependencies hinzufügen (kein pubspec ändern), außer es ist absolut zwingend (sollte nicht nötig sein).

## Bestehende Struktur (beibehalten)
- UI: `lib/ui/widgets/`
- Feature Home: `lib/features/home/`
- Daten: `lib/data/models/`, `lib/data/repositories/`, `lib/data/mock/`

## Aufgabe: Home-Screen Mockup (erste Iteration)
Ersetze den aktuellen simplen ListView-Home-Screen durch ein echtes Mockup mit:

### A) Top-Bereich (Header)
- Großer Titel: „Hersbruck Together“
- Untertitel klein: „Was ist heute los?“ (oder ähnlich)
- Rechts ein rundes Icon (z.B. Person/Account) als Action (nur UI, ohne Funktion)
- Optional: kleiner Standortchip „Hersbruck“ (nur UI)

### B) Search
- Prominentes Suchfeld im Header-Bereich (rounded, mit Lupe-Icon)
- Placeholder: „Suche Veranstaltungen, Orte, Vereine…“
- Keine echte Suche, nur UI/State.

### C) Kategorien / Filter Chips
Horizontale Chips, z.B.:
- Alle, Kultur, Sport, Familie, Musik, Essen, Natur
- Auswahlzustand (selected/unselected)
- Bei Wechsel: Liste wird clientseitig aus den Mockdaten gefiltert (category match).
- Falls Kategorie „Alle“: keine Filterung.

### D) Event Cards (List)
Jede Karte zeigt:
- Kategorie-Badge/Chip (klein)
- Titel (max 2 Zeilen)
- Datum + Uhrzeit schön formatiert (z.B. „Heute • 17:30“ / „Sa, 10. Feb • 14:00“)
- Ort (Location)
- Optional: kleines Leading-Icon je nach Kategorie (Material Icons)
- Eine „Merken“/Bookmark IconButton rechts (toggle im UI-State, keine Persistenz)

### E) Bottom Navigation (Mock)
Eine BottomNavigationBar mit 4 Tabs:
- Heute
- Entdecken
- Karte
- Profil
Nur der Tab „Heute“ ist real. Die anderen zeigen simple Placeholder-Seiten („Kommt bald“).

### F) Responsive / Desktop
- Auf breiten Fenstern (Windows) soll der Content nicht über die ganze Breite laufen.
- Nutze z.B. `Center` + `ConstrainedBox(maxWidth: 900)` oder ein ähnliches Pattern.
- Kartenlayout bleibt Liste, aber mit angenehmen Abständen.

## Daten / Mock erweitern (nur falls nötig)
Du darfst `MockEventRepository` um ein paar zusätzliche Events erweitern (5–8 total),
mit gemischten Kategorien und Startzeiten (heute + nächste Tage),
damit UI und Filter sinnvoll wirken.

## UX/Design-Guidelines
- Material 3 Komponenten bevorzugen (`FilledButton`, `SearchBar` falls verfügbar, sonst TextField in Card/Container)
- Runde Ecken, sanfte Schatten, viel Padding (16/20)
- Keine knalligen Farben; Akzent blau, Rest neutral.
- Schriftgrößen: Titel groß, Untertitel klein, Cards gut lesbar.

## Technische Details / Code-Qualität
- `package:` imports (Lint ist aktiv).
- Keine unnötigen `_` parameter in Buildern (Lint).
- Widgets sauber aufteilen:
  - HomePage als Screen (State: selectedCategory, bookmarkedIds)
  - Wiederverwendbare Widgets unter `lib/ui/widgets/` oder `lib/features/home/widgets/`:
    - `category_chips.dart`
    - `event_card.dart`
    - `home_header.dart`
    - `placeholder_page.dart` (für Tabs)

## Akzeptanzkriterien
- `flutter analyze` ohne Errors
- `flutter test` grün
- `flutter run -d windows` zeigt ein stimmiges, modernes UI mit Tabs, Search, Chips, Cards
- Keine zusätzlichen Dependencies

## Liefere am Ende
- Code-Änderungen in den passenden Dateien
- Kurze Notiz in einem Kommentar ganz oben in `home_page.dart`: was du gebaut hast und welche Widgets wo liegen.
