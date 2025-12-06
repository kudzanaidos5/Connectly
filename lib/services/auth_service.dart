import '../models/user.dart';

class AuthService {
  // Mock authentication - replace with actual implementation
  User? _currentUser;

  User? get currentUser => _currentUser;

  bool get isAuthenticated => _currentUser != null;

  Future<bool> login(String email, String password) async {
    // TODO: Implement actual authentication
    // For now, return mock user
    _currentUser = User(
      id: '1',
      name: 'Test User',
      email: email,
      phone: '+263771234567',
      role: UserRole.both,
      rating: 4.8,
      totalRides: 47,
      createdAt: DateTime.now(),
    );
    return true;
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  }) async {
    // TODO: Implement actual registration
    _currentUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      phone: phone,
      role: role,
      createdAt: DateTime.now(),
    );
    return true;
  }

  Future<void> logout() async {
    _currentUser = null;
  }

  bool isDriver() {
    return _currentUser?.role == UserRole.driver ||
        _currentUser?.role == UserRole.both;
  }

  bool isPassenger() {
    return _currentUser?.role == UserRole.passenger ||
        _currentUser?.role == UserRole.both;
  }
}
