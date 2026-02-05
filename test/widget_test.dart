import 'package:flutter_test/flutter_test.dart';
import 'package:hersbruck_together/app/app.dart';

void main() {
  testWidgets('App starts', (WidgetTester tester) async {
    await tester.pumpWidget(const HersbruckTogetherApp());

    // 1) erster Frame
    await tester.pump();

    // 2) Timer aus MockEventRepository (150ms) ablaufen lassen
    await tester.pump(const Duration(milliseconds: 200));

    // 3) dann noch ausrendern lassen
    await tester.pumpAndSettle();

    expect(find.text('Events'), findsOneWidget);
  });
}
