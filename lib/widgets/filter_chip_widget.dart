import 'package:flutter/material.dart';
import '../common/app_theme.dart';

/// Enum pentru tipurile de filtrare
enum FilterType { all, visited, notVisited }

/// Widget pentru chip-urile de filtrare
class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingLarge,
          vertical: AppTheme.spacingMedium,
        ),
        decoration: BoxDecoration(
          gradient: isSelected ? AppTheme.accentGradient : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusRound),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppTheme.borderLight,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? AppTheme.buttonShadow(AppTheme.accent)
              : [
                  BoxShadow(
                    color: AppTheme.shadowLight,
                    blurRadius: AppTheme.elevationSmall,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: AppTheme.fontSizeMedium,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppTheme.textPrimary,
          ),
        ),
      ),
    );
  }
}
