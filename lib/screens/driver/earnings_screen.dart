import 'package:flutter/material.dart';
import '../../widgets/gradient_header.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../utils/app_colors.dart';

class EarningsScreen extends StatelessWidget {
  final Function(int) onNavTap;

  const EarningsScreen({super.key, required this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: 3,
        onTap: onNavTap,
        isDriver: true,
        messageBadgeCount: 3,
      ),
      body: Column(
        children: [
          GradientHeader(
            title: 'My Earnings',
            subtitle: 'Track your income',
            isDriver: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => onNavTap(0),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildEarningsSummary(context),
                  _buildTransactions(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsSummary(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Available Balance',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$960.00',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  // TODO: Handle payout
                },
                icon: const Icon(Icons.payments_outlined),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.success,
                ),
                label: const Text('Request payout'),
              ),
            ),
            const Divider(height: 30),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(context, 'This Week', '\$240.00'),
                ),
                Expanded(
                  child: _buildDetailItem(context, 'This Month', '\$960.00'),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: _buildDetailItem(context, 'Total Trips', '67')),
                Expanded(
                  child: _buildDetailItem(context, 'Avg/Trip', '\$14.33'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
      ],
    );
  }

  Widget _buildTransactions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Transactions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),
          _buildTransactionItem(
            'Harare → Chitungwiza',
            '\$16.00',
            'Today, 8:30 AM',
            '3 passengers',
          ),
          _buildTransactionItem(
            'Harare → Norton',
            '\$24.00',
            'Yesterday, 5:00 PM',
            '2 passengers',
          ),
          _buildTransactionItem(
            'Harare → Ruwa',
            '\$20.00',
            'Nov 28, 2:15 PM',
            '4 passengers',
          ),
          _buildTransactionItem(
            'Payout to EcoCash',
            '-\$500.00',
            'Nov 25, 10:00 AM',
            'Completed',
            isNegative: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(
    String route,
    String amount,
    String date,
    String info, {
    bool isNegative = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  route,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isNegative ? AppColors.error : AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMedium,
                  ),
                ),
                Text(
                  info,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
