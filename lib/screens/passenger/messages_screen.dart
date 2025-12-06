import 'package:flutter/material.dart';
import '../../widgets/gradient_header.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../utils/app_colors.dart';

class MessagesScreen extends StatelessWidget {
  final Function(int) onNavTap;

  const MessagesScreen({super.key, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            title: 'Messages',
            subtitle: 'Chat with drivers',
            isDriver: false,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildMessageItem(
                  'TM',
                  'Tinashe Moyo',
                  'I\'ll be there in 5 minutes',
                  '10:30 AM',
                  true,
                ),
                _buildMessageItem(
                  'RN',
                  'Rumbidzai Ncube',
                  'Thanks for riding with me!',
                  'Yesterday',
                  false,
                ),
                _buildMessageItem(
                  'PM',
                  'Patrick Mpofu',
                  'See you tomorrow at the same time?',
                  '2 days ago',
                  false,
                ),
              ],
            ),
          ),
          BottomNavBar(currentIndex: 2, onTap: onNavTap, isDriver: false),
        ],
      ),
    );
  }

  Widget _buildMessageItem(
    String initials,
    String name,
    String preview,
    String time,
    bool hasUnread,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: AppColors.passengerPrimaryStart,
          child: Text(
            initials,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              time,
              style: const TextStyle(fontSize: 11, color: AppColors.textLight),
            ),
          ],
        ),
        subtitle: Text(
          preview,
          style: const TextStyle(fontSize: 13, color: AppColors.textMedium),
        ),
        trailing: hasUnread
            ? Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: () {
          // TODO: Navigate to chat screen
        },
      ),
    );
  }
}
