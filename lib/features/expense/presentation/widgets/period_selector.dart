import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/color_constants.dart';

class PeriodSelector extends StatelessWidget {
  const PeriodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: ColorConstants.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ColorConstants.primary.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: AppConstants.timePeriods.map((period) {
          final isSelected = period == 'Aylık'; // TODO: Replace with actual state
          return GestureDetector(
            onTap: () {
              // TODO: Implement period selection
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? ColorConstants.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                period,
                style: TextStyle(
                  color: isSelected ? ColorConstants.textLight : ColorConstants.textPrimary,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
} 