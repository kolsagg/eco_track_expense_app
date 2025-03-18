import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/color_constants.dart';

class ExpenseSummaryCard extends StatelessWidget {
  const ExpenseSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Toplam Harcama',
                      style: TextStyle(
                        color: ColorConstants.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${AppConstants.defaultCurrency}2,450.00',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: ColorConstants.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_downward,
                        size: 16,
                        color: ColorConstants.success,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '12%',
                        style: TextStyle(
                          color: ColorConstants.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildBudgetInfo(
                  label: 'Bütçe',
                  amount: '5,000.00',
                  icon: Icons.account_balance_wallet_outlined,
                ),
                Container(
                  height: 24,
                  width: 1,
                  color: ColorConstants.textSecondary.withOpacity(0.2),
                ),
                _buildBudgetInfo(
                  label: 'Kalan',
                  amount: '2,550.00',
                  icon: Icons.savings_outlined,
                  textColor: ColorConstants.success,
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: 0.49, // 2450 / 5000
              backgroundColor: ColorConstants.primary.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.primary),
              borderRadius: BorderRadius.circular(2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetInfo({
    required String label,
    required String amount,
    required IconData icon,
    Color? textColor,
  }) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: ColorConstants.textSecondary,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: ColorConstants.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${AppConstants.defaultCurrency}$amount',
                style: TextStyle(
                  color: textColor ?? ColorConstants.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 