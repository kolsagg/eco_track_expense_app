import 'package:flutter/material.dart';
import '../../../../core/constants/color_constants.dart';

class ChartContainer extends StatelessWidget {
  const ChartContainer({super.key});

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
                const Text(
                  'Harcama Analizi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: ColorConstants.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: ColorConstants.primary.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.pie_chart_outline,
                        size: 16,
                        color: ColorConstants.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Pasta Grafik',
                        style: TextStyle(
                          color: ColorConstants.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            AspectRatio(
              aspectRatio: 1.5,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstants.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Grafik Gelecek',
                    style: TextStyle(
                      color: ColorConstants.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildLegendItem('Yiyecek & İçecek', 0.3),
                _buildLegendItem('Ulaşım', 0.2),
                _buildLegendItem('Alışveriş', 0.15),
                _buildLegendItem('Faturalar', 0.15),
                _buildLegendItem('Eğlence', 0.1),
                _buildLegendItem('Diğer', 0.1),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, double percentage) {
    final color = ColorConstants.categoryColors[label] ?? ColorConstants.primary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '$label (${(percentage * 100).toInt()}%)',
          style: TextStyle(
            color: ColorConstants.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
} 