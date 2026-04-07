import 'package:flutter_test/flutter_test.dart';
import 'package:app_publishing/main.dart';

void main() {
  testWidgets('Main screen contains right headline',
      (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('App Publishing without Maintaining'), findsOneWidget);
  });
}
