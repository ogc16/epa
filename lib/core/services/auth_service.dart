import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'api_service.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

class AuthService extends ChangeNotifier {
  final ApiService _api = ApiService();
  User? _currentUser;
  String? _token;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  String? get token => _token;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _currentUser != null && _token != null;

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('auth_token');
      final userData = prefs.getString('user_data');
      if (_token != null) _api.setToken(_token);
      if (userData != null) {
        final map = _parseUserData(userData);
        _currentUser = User.fromMap(map);
      }
      unawaited(_googleSignIn.initialize());
    } catch (_) {
      _token = null;
      _currentUser = null;
    }
    notifyListeners();
  }

  static Map<String, dynamic> _parseUserData(String data) {
    return Map<String, dynamic>.from(jsonDecode(data));
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      final res = await _api.post('/auth/login', body: {
        'email': email,
        'password': password,
      });
      _token = res['token'] as String;
      _api.setToken(_token);
      _currentUser = User.fromMap(res['user'] as Map<String, dynamic>);
      await _persistAuth();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String phone,
      String password, UserRole role) async {
    _isLoading = true;
    notifyListeners();
    try {
      final res = await _api.post('/auth/register', body: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'role': role.name,
      });
      _token = res['token'] as String;
      _api.setToken(_token);
      _currentUser = User.fromMap(res['user'] as Map<String, dynamic>);
      await _persistAuth();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithGoogle(UserRole role) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _googleSignIn.initialize();
      final googleUser = await _googleSignIn.authenticate();
      final idToken = googleUser.authentication.idToken;
      if (idToken == null) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final res = await _api.post('/auth/google', body: {
        'idToken': idToken,
        'role': role.name,
      });
      _token = res['token'] as String;
      _api.setToken(_token);
      _currentUser = User.fromMap(res['user'] as Map<String, dynamic>);
      await _persistAuth();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _currentUser = null;
    _token = null;
    try {
      await _googleSignIn.signOut();
    } catch (_) {}
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data');
    notifyListeners();
  }

  Future<void> _persistAuth() async {
    final prefs = await SharedPreferences.getInstance();
    if (_token != null) await prefs.setString('auth_token', _token!);
    if (_currentUser != null) {
      await prefs.setString('user_data', jsonEncode(_currentUser!.toMap()));
    }
  }

  Future<String?> forgotPassword(String email) async {
    try {
      final res = await _api.post('/auth/forgot-password', body: {
        'email': email,
      });
      return res['message'] as String? ?? 'Password reset link sent to your email';
    } on ApiException catch (e) {
      return e.message;
    } catch (_) {
      return 'Something went wrong. Please try again.';
    }
  }

  Future<bool> updateProfile({String? name, String? phone, String? photoUrl, String? address}) async {
    if (_currentUser == null) return false;
    _currentUser = User(
      id: _currentUser!.id,
      email: _currentUser!.email,
      name: name ?? _currentUser!.name,
      phone: phone ?? _currentUser!.phone,
      photoUrl: photoUrl ?? _currentUser!.photoUrl,
      role: _currentUser!.role,
      address: address ?? _currentUser!.address,
      lat: _currentUser!.lat,
      lng: _currentUser!.lng,
      isAvailable: _currentUser!.isAvailable,
      createdAt: _currentUser!.createdAt,
    );
    await _persistAuth();
    notifyListeners();
    return true;
  }
}
