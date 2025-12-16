import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../utils/app_colors.dart';
import '../../providers/auth_provider.dart';
import '../driver/driver_home_screen.dart';

class ProfileScreen extends StatelessWidget {
  final Function(int) onNavTap;

  const ProfileScreen({super.key, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: onNavTap,
        isDriver: false,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(gradient: AppColors.passengerGradient),
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                    child: const Text(
                      'SK',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Sarah Kachingwe',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '⭐ 4.9 • Passenger',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
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
          Expanded(child: _buildStatItem('47', 'Total Rides')),
          Expanded(child: _buildStatItem('\$235', 'Money Saved')),
          Expanded(child: _buildStatItem('98%', 'On-Time Rate')),
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
              color: AppColors.passengerPrimaryEnd,
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
      _MenuItem(
        Icons.person,
        'Edit Profile',
        'Update your personal information',
      ),
      _MenuItem(Icons.payment, 'Payment Methods', 'Manage EcoCash & OneMoney'),
      _MenuItem(Icons.history, 'Ride History', 'View all past trips'),
      _MenuItem(Icons.settings, 'Settings', 'Notifications, privacy & more'),
      _MenuItem(Icons.help, 'Help Center', 'FAQs and support'),
      _MenuItem(Icons.logout, 'Logout', 'Sign out of your account'),
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (authProvider.canAccessDriverMode) _buildModeSwitcher(context),
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
          color: AppColors.passengerPrimaryStart.withValues(alpha: 0.1),
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.driverPrimaryEnd.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.swap_horiz,
                size: 20,
                color: AppColors.driverPrimaryEnd,
              ),
            ),
            title: const Text(
              'Switch to Driver Mode',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.driverPrimaryEnd,
              ),
            ),
            subtitle: const Text(
              'Manage trips and earnings',
              style: TextStyle(fontSize: 11, color: AppColors.textMedium),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.driverPrimaryEnd,
            ),
            onTap: () async {
              await authProvider.switchToDriverMode();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const DriverHomeScreen()),
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
