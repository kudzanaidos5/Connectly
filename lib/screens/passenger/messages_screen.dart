import 'package:flutter/material.dart';
import '../../widgets/gradient_header.dart';
import '../../widgets/bottom_nav_bar.dart';

class MessagesScreen extends StatelessWidget {
  final Function(int) onNavTap;
  final bool isDriver;

  const MessagesScreen({
    super.key,
    required this.onNavTap,
    this.isDriver = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: onNavTap,
        isDriver: isDriver,
      ),
      body: Column(
        children: [
          GradientHeader(
            title: 'Messages',
            subtitle: isDriver ? 'Chat with passengers' : 'Chat with drivers',
            isDriver: isDriver,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildMessageItem(
                  context,
                  'TM',
                  'Tinashe Moyo',
                  'I\'ll be there in 5 minutes',
                  '10:30 AM',
                  true,
                ),
                _buildMessageItem(
                  context,
                  'RN',
                  'Rumbidzai Ncube',
                  'Thanks for riding with me!',
                  'Yesterday',
                  false,
                ),
                _buildMessageItem(
                  context,
                  'PM',
                  'Patrick Mpofu',
                  'See you tomorrow at the same time?',
                  '2 days ago',
                  false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(
    BuildContext context,
    String initials,
    String name,
    String preview,
    String time,
    bool hasUnread,
  ) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: scheme.primary,
          child: Text(
            initials,
            style: TextStyle(
              color: scheme.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              time,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
        subtitle: Text(
          preview,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
        trailing: hasUnread
            ? Icon(Icons.circle, size: 10, color: scheme.error)
            : null,
        onTap: () {
          // TODO: Navigate to chat screen
        },
      ),
    );
  }
}
