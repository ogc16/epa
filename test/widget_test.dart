import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:epa/core/services/auth_service.dart';
import 'package:epa/core/screens/login_screen.dart';
import 'package:epa/core/models/user.dart';

void main() {
  testWidgets('Login screen renders with customer role',
      (WidgetTester tester) async {
    final auth = AuthService();
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: auth,
        child: const MaterialApp(
          home: LoginScreen(role: UserRole.customer),
        ),
      ),
    );

    expect(find.text('Welcome Customer'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text("Don't have an account? Sign Up"), findsOneWidget);
  });
}
