import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../models/user.dart';
import '../screens/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  final UserRole role;
  final Widget home;

  const AuthWrapper({
    super.key,
    required this.role,
    required this.home,
  });

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();

    if (auth.isLoading && !auth.isLoggedIn) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!auth.isLoggedIn) {
      return LoginScreen(role: role);
    }

    return home;
  }
}
