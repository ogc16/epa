import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/services/auth_service.dart';
import 'core/theme/app_theme.dart';
import 'core/models/user.dart';
import 'core/widgets/auth_wrapper.dart';
import 'vendor/screens/vendor_screens.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const VendorApp());
}

class VendorApp extends StatefulWidget {
  const VendorApp({super.key});

  @override
  State<VendorApp> createState() => _VendorAppState();
}

class _VendorAppState extends State<VendorApp> {
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
        title: 'EPA - Vendor',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const AuthWrapper(
          role: UserRole.vendor,
          home: VendorDashboardScreen(),
        ),
      ),
    );
  }
}
