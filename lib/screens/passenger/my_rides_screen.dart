import 'package:flutter/material.dart';
import '../../widgets/gradient_header.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../utils/app_colors.dart';

class MyRidesScreen extends StatelessWidget {
  final Function(int) onNavTap;

  const MyRidesScreen({super.key, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            title: 'My Rides',
            subtitle: 'Track your trips',
            isDriver: false,
          ),
          Expanded(
            child: Column(
              children: [
                _buildTabs(),
                Expanded(child: _buildEmptyState()),
              ],
            ),
          ),
          BottomNavBar(currentIndex: 1, onTap: onNavTap, isDriver: false),
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
          Expanded(child: _buildTab('Upcoming', true)),
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
                  color: Colors.black.withOpacity(0.1),
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
          color: isActive
              ? AppColors.passengerPrimaryEnd
              : AppColors.textMedium,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.confirmation_number,
            size: 60,
            color: AppColors.textLight,
          ),
          const SizedBox(height: 15),
          Text(
            'No Upcoming Rides',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'You haven\'t booked any rides yet.\nSearch for available rides to get started!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: AppColors.textMedium),
          ),
        ],
      ),
    );
  }
}
