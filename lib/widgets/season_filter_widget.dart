import 'package:flutter/material.dart';
import '../common/app_strings.dart';
import '../common/app_theme.dart';

/// Widget pentru filtrarea după sezoane
class SeasonFilterWidget extends StatelessWidget {
  final Set<String> selectedSeasons;
  final Function(String) onSeasonToggle;
  final VoidCallback onClearFilters;

  const SeasonFilterWidget({
    super.key,
    required this.selectedSeasons,
    required this.onSeasonToggle,
    required this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingLarge,
        vertical: AppTheme.spacingMedium,
      ),
      padding: const EdgeInsets.all(AppTheme.spacingLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.wb_sunny_outlined,
                    color: AppTheme.accent,
                    size: AppTheme.iconSizeMedium,
                  ),
                  const SizedBox(width: AppTheme.spacingSmall),
                  Text(
                    'Filtrare după sezon',
                    style: TextStyle(
                      fontSize: AppTheme.fontSizeRegular,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
              if (selectedSeasons.isNotEmpty)
                TextButton(
                  onPressed: onClearFilters,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMedium,
                      vertical: AppTheme.spacingSmall,
                    ),
                  ),
                  child: Text(
                    'Resetează',
                    style: TextStyle(
                      color: AppTheme.accent,
                      fontSize: AppTheme.fontSizeSmall,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMedium),
          Wrap(
            spacing: AppTheme.spacingSmall,
            runSpacing: AppTheme.spacingSmall,
            children: [
              _buildSeasonChip(
                AppStrings.seasonSpring,
                Icons.eco,
                const Color(0xFF81C784),
              ),
              _buildSeasonChip(
                AppStrings.seasonSummer,
                Icons.wb_sunny,
                const Color(0xFFFFB74D),
              ),
              _buildSeasonChip(
                AppStrings.seasonAutumn,
                Icons.park,
                const Color(0xFFFF8A65),
              ),
              _buildSeasonChip(
                AppStrings.seasonWinter,
                Icons.ac_unit,
                const Color(0xFF64B5F6),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonChip(String season, IconData icon, Color color) {
    final isSelected = selectedSeasons.contains(season);

    return GestureDetector(
      onTap: () => onSeasonToggle(season),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMedium,
          vertical: AppTheme.spacingSmall,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusRound),
          border: Border.all(
            color: isSelected ? color : AppTheme.borderLight,
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: AppTheme.elevationMedium,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppTheme.iconSizeSmall,
              color: isSelected ? Colors.white : color,
            ),
            const SizedBox(width: AppTheme.spacingSmall),
            Text(
              season,
              style: TextStyle(
                fontSize: AppTheme.fontSizeSmall,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppTheme.textPrimary,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: AppTheme.spacingSmall),
              Icon(
                Icons.check_circle,
                size: AppTheme.iconSizeSmall,
                color: Colors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
