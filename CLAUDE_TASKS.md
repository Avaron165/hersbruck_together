# Hersbruck Together – UI Mockup Tasks

## Kontext
Dies ist ein Flutter-Projekt. Es gibt aktuell KEIN Backend.
Daten kommen über `EventRepository`, derzeit `MockEventRepository`.
Später soll eine echte Datenquelle (z.B. Supabase/REST) implementiert werden,
ohne UI-Änderungen – deshalb Repository-Pattern beibehalten.

## Arbeitsregeln
- Arbeite nur unter `lib/`
- Kein Refactor in Architektur ohne Not
- Neue UI-Komponenten unter `lib/ui/widgets/`
- Feature-spezifische Widgets unter `lib/features/<feature>/`

## Aufgabe (erste Iteration)
- Baue den Home-Screen als Mockup nach Designvorgabe:
  - Header, Suchfeld, Kategorien-Chips, Event-Karten
  - Stimmige Abstände, Material3, ruhiges Blau als Akzent
- Nutze weiterhin `MockEventRepository`, keine echten Calls.
- Achte auf Responsive Layout (Window-Größen).
