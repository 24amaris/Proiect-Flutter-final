import 'package:flutter/material.dart';
import '../common/app_strings.dart';
import '../common/app_theme.dart';

/// Widget afișat când lista de destinații este goală
class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onAddPressed;

  const EmptyStateWidget({
    super.key,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingXLarge),
            decoration: BoxDecoration(
              gradient: AppTheme.accentGradient,
              shape: BoxShape.circle,
              boxShadow: AppTheme.buttonShadow(AppTheme.accent),
            ),
            child: const Icon(
              Icons.travel_explore,
              size: AppTheme.iconSizeHero,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppTheme.spacingXLarge),
          const Text(
            AppStrings.homeEmptyTitle,
            style: TextStyle(
              fontSize: AppTheme.fontSizeXXLarge,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryDark,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMedium),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              AppStrings.homeEmptyMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppTheme.fontSizeRegular,
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingXXLarge),
          Container(
            decoration: BoxDecoration(
              gradient: AppTheme.accentGradient,
              borderRadius: BorderRadius.circular(AppTheme.radiusRound),
              boxShadow: AppTheme.buttonShadow(AppTheme.accent),
            ),
            child: ElevatedButton.icon(
              onPressed: onAddPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingXXLarge,
                  vertical: AppTheme.spacingLarge,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusRound),
                ),
              ),
              icon: const Icon(Icons.add_location_alt, color: Colors.white),
              label: const Text(
                AppStrings.homeEmptyButton,
                style: TextStyle(
                  fontSize: AppTheme.fontSizeRegular,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
