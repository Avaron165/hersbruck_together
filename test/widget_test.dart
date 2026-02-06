import 'package:flutter_test/flutter_test.dart';
import 'package:hersbruck_together/app/app.dart';

void main() {
  testWidgets('App starts with StartPage', (WidgetTester tester) async {
    await tester.pumpWidget(const HersbruckTogetherApp());

    // First frame
    await tester.pump();

    // Let animations settle
    await tester.pumpAndSettle();

    // StartPage should show the app title
    expect(find.text('Hersbruck Together'), findsOneWidget);

    // StartPage should show the subtitle
    expect(find.text('Entdecken • Mitmachen • Unterstützen'), findsOneWidget);

    // StartPage should show all feature tiles
    expect(find.text('Events'), findsOneWidget);
    expect(find.text('Karte'), findsOneWidget);
    expect(find.text('News'), findsOneWidget);
    expect(find.text('Spenden'), findsOneWidget);
  });
}
