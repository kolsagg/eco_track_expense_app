import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/color_constants.dart';

class ExpenseListItem extends StatefulWidget {
  const ExpenseListItem({super.key});

  @override
  State<ExpenseListItem> createState() => _ExpenseListItemState();
}

class _ExpenseListItemState extends State<ExpenseListItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          initiallyExpanded: _isExpanded,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ColorConstants.categoryColors['Yiyecek & İçecek']!.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.restaurant,
                  color: ColorConstants.categoryColors['Yiyecek & İçecek'],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Öğle Yemeği',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Yiyecek & İçecek',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorConstants.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${AppConstants.defaultCurrency}150.00',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '14:30',
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorConstants.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  const Divider(),
                  const SizedBox(height: 8),
                  _buildDetailRow('Tarih', '17 Mart 2024'),
                  const SizedBox(height: 8),
                  _buildDetailRow('Ödeme Yöntemi', 'Kredi Kartı'),
                  const SizedBox(height: 8),
                  _buildDetailRow('Konum', 'Restoran XYZ'),
                  const SizedBox(height: 8),
                  _buildDetailRow('Not', 'İş yemeği'),
                  if (_hasReceipt) ...[
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Implement receipt view
                      },
                      icon: const Icon(Icons.receipt_long_outlined),
                      label: const Text('Makbuzu Görüntüle'),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: ColorConstants.textSecondary,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // TODO: Replace with actual receipt check
  bool get _hasReceipt => true;
} 