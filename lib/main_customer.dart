import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/services/auth_service.dart';
import 'core/theme/app_theme.dart';
import 'core/models/user.dart';
import 'core/widgets/auth_wrapper.dart';
import 'customer/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const CustomerApp());
}

class CustomerApp extends StatefulWidget {
  const CustomerApp({super.key});

  @override
  State<CustomerApp> createState() => _CustomerAppState();
}

class _CustomerAppState extends State<CustomerApp> {
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.init();
  }

  @override
  void dispose() {
    _authService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _authService,
      child: MaterialApp(
        title: 'EPA - Customer',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const AuthWrapper(
          role: UserRole.customer,
          home: CustomerHomeScreen(),
        ),
      ),
    );
  }
}
