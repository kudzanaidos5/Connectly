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
                children: [_buildEarningsSummary(), _buildTransactions()],
              ),
            ),
          ),
          BottomNavBar(
            currentIndex: 3,
            onTap: onNavTap,
            isDriver: true,
            messageBadgeCount: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsSummary() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Available Balance',
            style: TextStyle(fontSize: 14, color: AppColors.textMedium),
          ),
          const SizedBox(height: 10),
          const Text(
            '\$960.00',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: AppColors.driverPrimaryEnd,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Handle payout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                '💳 Request Payout',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const Divider(height: 30),
          Row(
            children: [
              Expanded(child: _buildDetailItem('This Week', '\$240.00')),
              Expanded(child: _buildDetailItem('This Month', '\$960.00')),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _buildDetailItem('Total Trips', '67')),
              Expanded(child: _buildDetailItem('Avg/Trip', '\$14.33')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textMedium),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
