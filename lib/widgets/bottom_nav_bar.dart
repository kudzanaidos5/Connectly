import 'package:flutter/material.dart';

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
    final destinations = isDriver
        ? const [
            _NavItem(
              icon: Icons.home_outlined,
              selectedIcon: Icons.home,
              label: 'Home',
            ),
            _NavItem(
              icon: Icons.confirmation_number_outlined,
              selectedIcon: Icons.confirmation_number,
              label: 'My Trips',
            ),
            _NavItem(
              icon: Icons.chat_bubble_outline,
              selectedIcon: Icons.chat_bubble,
              label: 'Messages',
            ),
            _NavItem(
              icon: Icons.account_balance_wallet_outlined,
              selectedIcon: Icons.account_balance_wallet,
              label: 'Earnings',
            ),
            _NavItem(
              icon: Icons.person_outline,
              selectedIcon: Icons.person,
              label: 'Profile',
            ),
          ]
        : const [
            _NavItem(
              icon: Icons.home_outlined,
              selectedIcon: Icons.home,
              label: 'Home',
            ),
            _NavItem(
              icon: Icons.confirmation_number_outlined,
              selectedIcon: Icons.confirmation_number,
              label: 'My Rides',
            ),
            _NavItem(
              icon: Icons.chat_bubble_outline,
              selectedIcon: Icons.chat_bubble,
              label: 'Messages',
            ),
            _NavItem(
              icon: Icons.person_outline,
              selectedIcon: Icons.person,
              label: 'Profile',
            ),
          ];

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: destinations.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isMessages = index == 2;
        final count = messageBadgeCount ?? 0;
        final showBadge = isMessages && count > 0;

        Widget maybeBadged(Icon icon) {
          if (!showBadge) return icon;
          return Badge(label: Text(count > 99 ? '99+' : '$count'), child: icon);
        }

        return NavigationDestination(
          icon: maybeBadged(Icon(item.icon)),
          selectedIcon: maybeBadged(Icon(item.selectedIcon)),
          label: item.label,
        );
      }).toList(),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}
