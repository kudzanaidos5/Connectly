import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../utils/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../passenger/passenger_home_screen.dart';

class DriverProfileScreen extends StatelessWidget {
  final Function(int) onNavTap;

  const DriverProfileScreen({super.key, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(gradient: AppColors.driverGradient),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    child: const Text(
                      'TM',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Tinashe Moyo',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '⭐ 4.8 • Verified Driver',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [_buildStats(), _buildMenuItems(context)],
              ),
            ),
          ),
          BottomNavBar(
            currentIndex: 4,
            onTap: onNavTap,
            isDriver: true,
            messageBadgeCount: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: AppColors.background,
      child: Row(
        children: [
          Expanded(child: _buildStatItem('124', 'Total Trips')),
          Expanded(child: _buildStatItem('4.8', 'Rating')),
          Expanded(child: _buildStatItem('98%', 'Acceptance')),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.driverPrimaryEnd,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.textMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final menuItems = [
      _MenuItem(Icons.person, 'Edit Profile', 'Update personal information'),
      _MenuItem(
        Icons.directions_car,
        'Vehicle Details',
        'Toyota Corolla • ABC 1234',
      ),
      _MenuItem(
        Icons.description,
        'Documents',
        'License, registration & insurance',
      ),
      _MenuItem(Icons.payment, 'Payment Methods', 'EcoCash • OneMoney'),
      _MenuItem(Icons.star, 'Ratings & Reviews', 'View passenger feedback'),
      _MenuItem(Icons.settings, 'Settings', 'Notifications & preferences'),
      _MenuItem(Icons.help, 'Help Center', 'FAQs and support'),
      _MenuItem(Icons.logout, 'Logout', 'Sign out of your account'),
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (authProvider.canAccessPassengerMode) _buildModeSwitcher(context),
          ...menuItems.map((item) => _buildMenuItem(context, item)),
        ],
      ),
    );
  }

  Widget _buildModeSwitcher(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          color: AppColors.driverPrimaryEnd.withOpacity(0.1),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.passengerPrimaryEnd.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.swap_horiz,
                size: 20,
                color: AppColors.passengerPrimaryEnd,
              ),
            ),
            title: const Text(
              'Switch to Passenger Mode',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.passengerPrimaryEnd,
              ),
            ),
            subtitle: const Text(
              'Search and book rides',
              style: TextStyle(fontSize: 11, color: AppColors.textMedium),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.passengerPrimaryEnd,
            ),
            onTap: () async {
              await authProvider.switchToPassengerMode();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const PassengerHomeScreen(),
                  ),
                  (route) => false,
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(BuildContext context, _MenuItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(item.icon, size: 20),
        ),
        title: Text(
          item.title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          item.subtitle,
          style: const TextStyle(fontSize: 11, color: AppColors.textMedium),
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textLight),
        onTap: () {
          if (item.title == 'Logout') {
            // TODO: Handle logout
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Logged out!')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${item.title} coming soon!')),
            );
          }
        },
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;

  _MenuItem(this.icon, this.title, this.subtitle);
}
