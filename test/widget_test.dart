import 'package:flutter_test/flutter_test.dart';
import 'package:hersbruck_together/app/app.dart';

void main() {
  testWidgets('App starts with Home tab showing Start Page', (WidgetTester tester) async {
    await tester.pumpWidget(const HersbruckTogetherApp());

    // First frame
    await tester.pump();

    // Let async operations complete (MockEventRepository delay)
    await tester.pump(const Duration(milliseconds: 200));

    // Let animations settle
    await tester.pumpAndSettle();

    // Start Page should show the app title
    expect(find.text('Hersbruck Together'), findsOneWidget);

    // Start Page should show the subtitle
    expect(find.text('Entdecken • Mitmachen • Unterstützen'), findsOneWidget);

    // Start Page should show navigation tiles
    expect(find.text('Events'), findsWidgets); // Tile and bottom nav
    expect(find.text('Karte'), findsWidgets);  // Tile and bottom nav
    expect(find.text('Spenden'), findsWidgets); // Tile and bottom nav

    // Bottom navigation should show Home tab
    expect(find.text('Home'), findsOneWidget);
  });
}
