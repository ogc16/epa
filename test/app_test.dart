import 'package:flutter_test/flutter_test.dart';

import 'package:epa/main_customer.dart';

void main() {
  testWidgets('Customer app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CustomerApp());
    expect(find.text('EPA - Customer'), findsNothing);
  });
}
