import 'package:flutter_test/flutter_test.dart';

import 'package:uilab2/main.dart';

void main() {
  testWidgets('Home se afiseaza si Start Now deschide detaliile',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Featured Plan'), findsOneWidget);
    expect(find.text('Workout Programs'), findsOneWidget);

    await tester.tap(find.text('Start Now').first);
    await tester.pumpAndSettle();

    expect(find.text('Mid City Gym Training'), findsOneWidget);
    expect(find.text('Reserve'), findsOneWidget);
  });

  testWidgets('Categoria Yoga filtreaza programele',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Yoga').first);
    await tester.pump();

    expect(find.text('Arm\nStrengthening'), findsNothing);
  });
}
