import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isDriver;
  final int? messageBadgeCount;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.isDriver,
    this.messageBadgeCount,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = isDriver
        ? [
            _NavItem(icon: Icons.home, label: 'Home'),
            _NavItem(icon: Icons.confirmation_number, label: 'My Trips'),
            _NavItem(icon: Icons.message, label: 'Messages'),
            _NavItem(icon: Icons.account_balance_wallet, label: 'Earnings'),
            _NavItem(icon: Icons.person, label: 'Profile'),
          ]
        : [
            _NavItem(icon: Icons.home, label: 'Home'),
            _NavItem(icon: Icons.confirmation_number, label: 'My Rides'),
            _NavItem(icon: Icons.message, label: 'Messages'),
            _NavItem(icon: Icons.person, label: 'Profile'),
          ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isActive = currentIndex == index;
              final showBadge =
                  index == 2 &&
                  messageBadgeCount != null &&
                  messageBadgeCount! > 0;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            item.icon,
                            size: 24,
                            color: isActive
                                ? AppColors.getPrimaryColor(isDriver)
                                : AppColors.textLight,
                          ),
                          if (showBadge)
                            Positioned(
                              right: -8,
                              top: -5,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: AppColors.error,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 12,
                                  minHeight: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 11,
                          color: isActive
                              ? AppColors.getPrimaryColor(isDriver)
                              : AppColors.textLight,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;

  _NavItem({required this.icon, required this.label});
}
