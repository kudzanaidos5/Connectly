import 'package:flutter/material.dart';
import '../../widgets/gradient_header.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../utils/app_colors.dart';

class MyTripsScreen extends StatelessWidget {
  final Function(int) onNavTap;

  const MyTripsScreen({super.key, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1,
        onTap: onNavTap,
        isDriver: true,
        messageBadgeCount: 3,
      ),
      body: Column(
        children: [
          GradientHeader(
            title: 'My Trips',
            subtitle: 'All your trip history',
            isDriver: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => onNavTap(0),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                _buildTabs(),
                Expanded(child: _buildEmptyState()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTab('Active', true)),
          Expanded(child: _buildTab('Completed', false)),
          Expanded(child: _buildTab('Cancelled', false)),
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isActive ? AppColors.driverPrimaryEnd : AppColors.textMedium,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'No trips yet. Create your first trip!',
        style: TextStyle(color: AppColors.textMedium),
      ),
    );
  }
}
