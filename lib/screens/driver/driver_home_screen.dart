import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../utils/app_colors.dart';
import 'create_trip_screen.dart';
import 'my_trips_screen.dart';
import 'earnings_screen.dart';
import 'profile_screen.dart';
import '../passenger/messages_screen.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (_currentIndex != 0) {
      return _buildOtherPages();
    }

    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        isDriver: true,
        messageBadgeCount: 3,
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildQuickStats(),
                  _buildCreateTripButton(),
                  _buildActiveTrips(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherPages() {
    switch (_currentIndex) {
      case 1:
        return MyTripsScreen(
          onNavTap: (index) => setState(() => _currentIndex = index),
        );
      case 2:
        return MessagesScreen(
          onNavTap: (index) => setState(() => _currentIndex = index),
          isDriver: true,
        );
      case 3:
        return EarningsScreen(
          onNavTap: (index) => setState(() => _currentIndex = index),
        );
      case 4:
        return DriverProfileScreen(
          onNavTap: (index) => setState(() => _currentIndex = index),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(gradient: AppColors.driverGradient),
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '🚗 Driver Mode',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'ACTIVE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildEarningItem('Today', '\$48.00'),
                  _buildEarningItem('This Week', '\$240.00'),
                  _buildEarningItem('This Month', '\$960.00'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.white70),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: AppColors.background,
      child: Row(
        children: [
          Expanded(child: _buildStatBox('🎫', '12', 'Trips Today')),
          const SizedBox(width: 10),
          Expanded(child: _buildStatBox('⭐', '4.8', 'Rating')),
          const SizedBox(width: 10),
          Expanded(child: _buildStatBox('👥', '3', 'Requests')),
        ],
      ),
    );
  }

  Widget _buildStatBox(String icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.textMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateTripButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateTripScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(gradient: AppColors.driverGradient),
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('➕', style: TextStyle(fontSize: 24)),
                SizedBox(width: 10),
                Text(
                  'Create New Trip',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveTrips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Active Trips',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () => setState(() => _currentIndex = 1),
                child: const Text(
                  'View All →',
                  style: TextStyle(color: AppColors.driverPrimaryEnd),
                ),
              ),
            ],
          ),
        ),
        // TODO: Add actual trip cards from provider
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'No active trips. Create a new trip to get started!',
            style: TextStyle(color: AppColors.textMedium),
          ),
        ),
      ],
    );
  }
}
