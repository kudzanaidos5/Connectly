import 'package:flutter/material.dart';

class AppColors {
  // Passenger UI Colors (Purple Gradient)
  static const Color passengerPrimaryStart = Color(0xFF667eea);
  static const Color passengerPrimaryEnd = Color(0xFF764ba2);
  static LinearGradient get passengerGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [passengerPrimaryStart, passengerPrimaryEnd],
  );

  // Driver UI Colors (Pink/Red Gradient)
  static const Color driverPrimaryStart = Color(0xFFf093fb);
  static const Color driverPrimaryEnd = Color(0xFFf5576c);
  static LinearGradient get driverGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [driverPrimaryStart, driverPrimaryEnd],
  );

  // Common Colors
  static const Color success = Color(0xFF27ae60);
  static const Color error = Color(0xFFe74c3c);
  static const Color warning = Color(0xFFf39c12);
  static const Color background = Color(0xFFf8f9fa);
  static const Color textDark = Color(0xFF333333);
  static const Color textMedium = Color(0xFF666666);
  static const Color textLight = Color(0xFF999999);
  static const Color white = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFe0e0e0);

  // Get gradient based on user role
  static LinearGradient getGradient(bool isDriver) {
    return isDriver ? driverGradient : passengerGradient;
  }

  static Color getPrimaryColor(bool isDriver) {
    return isDriver ? driverPrimaryEnd : passengerPrimaryEnd;
  }
}
