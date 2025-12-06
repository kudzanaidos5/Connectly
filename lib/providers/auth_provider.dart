import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _currentModeIsDriver = false; // Current UI mode (can be switched)

  User? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isDriver =>
      _user?.role == UserRole.driver || _user?.role == UserRole.both;
  bool get isPassenger =>
      _user?.role == UserRole.passenger || _user?.role == UserRole.both;

  // Current UI mode (can be switched independently of role)
  bool get currentModeIsDriver => _currentModeIsDriver;

  // Check if user can access driver mode
  bool get canAccessDriverMode => isDriver;
  // Check if user can access passenger mode
  bool get canAccessPassengerMode => isPassenger;

  AuthProvider() {
    _user = _authService.currentUser;
    _loadModePreference();
  }

  Future<void> _loadModePreference() async {
    if (_user != null) {
      final prefs = await SharedPreferences.getInstance();
      final savedMode = prefs.getBool('ui_mode_driver_${_user!.id}');
      if (savedMode != null) {
        _currentModeIsDriver = savedMode;
        notifyListeners();
      } else {
        // Default to driver mode if user has both roles, otherwise match their role
        if (_user!.role == UserRole.both) {
          _currentModeIsDriver = true;
        } else if (_user!.role == UserRole.driver) {
          _currentModeIsDriver = true;
        } else {
          _currentModeIsDriver = false;
        }
      }
    }
  }

  Future<void> switchToDriverMode() async {
    if (!canAccessDriverMode) return;
    _currentModeIsDriver = true;
    if (_user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('ui_mode_driver_${_user!.id}', true);
    }
    notifyListeners();
  }

  Future<void> switchToPassengerMode() async {
    if (!canAccessPassengerMode) return;
    _currentModeIsDriver = false;
    if (_user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('ui_mode_driver_${_user!.id}', false);
    }
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    final success = await _authService.login(email, password);
    if (success) {
      _user = _authService.currentUser;
      await _loadModePreference();
      notifyListeners();
    }
    return success;
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  }) async {
    final success = await _authService.register(
      name: name,
      email: email,
      phone: phone,
      password: password,
      role: role,
    );
    if (success) {
      _user = _authService.currentUser;
      await _loadModePreference();
      notifyListeners();
    }
    return success;
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }
}
