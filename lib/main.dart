import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/trip_provider.dart';
import 'utils/app_theme.dart';
import 'screens/auth/login_screen.dart';
import 'screens/passenger/passenger_home_screen.dart';
import 'screens/driver/driver_home_screen.dart';

void main() {
  runApp(const ConnectlyApp());
}

class ConnectlyApp extends StatelessWidget {
  const ConnectlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TripProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          final isDriverMode = authProvider.currentModeIsDriver;

          return MaterialApp(
            title: 'Connectly',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.getTheme(isDriver: isDriverMode),
            home: _buildHome(authProvider, isDriverMode),
          );
        },
      ),
    );
  }

  Widget _buildHome(AuthProvider authProvider, bool isDriver) {
    if (!authProvider.isAuthenticated) {
      return const LoginScreen();
    }

    return isDriver ? const DriverHomeScreen() : const PassengerHomeScreen();
  }
}
