import 'package:flutter/material.dart';
import '../common/app_strings.dart';
import '../common/app_theme.dart';

/// Card cu statistici despre destinații
class StatisticsCard extends StatelessWidget {
  final int totalDestinations;
  final int visitedDestinations;
  final int remainingDestinations;

  const StatisticsCard({
    super.key,
    required this.totalDestinations,
    required this.visitedDestinations,
    required this.remainingDestinations,
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
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: AppTheme.buttonShadow(AppTheme.primaryDark),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingSmall),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: const Icon(
                  Icons.bar_chart_rounded,
                  color: Colors.white,
                  size: AppTheme.iconSizeLarge,
                ),
              ),
              const SizedBox(width: AppTheme.spacingMedium),
              const Text(
                AppStrings.homeStatisticsTitle,
                style: TextStyle(
                  fontSize: AppTheme.fontSizeXLarge,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                icon: Icons.public,
                label: AppStrings.homeStatisticsTotal,
                value: totalDestinations.toString(),
                color: Colors.white,
              ),
              _StatItem(
                icon: Icons.check_circle,
                label: AppStrings.homeStatisticsVisited,
                value: visitedDestinations.toString(),
                color: AppTheme.accent,
              ),
              _StatItem(
                icon: Icons.pending_outlined,
                label: AppStrings.homeStatisticsRemaining,
                value: remainingDestinations.toString(),
                color: AppTheme.secondaryLight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Item individual pentru statistici
class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingMedium),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
          child: Icon(
            icon,
            color: color,
            size: AppTheme.iconSizeLarge,
          ),
        ),
        const SizedBox(height: AppTheme.spacingSmall),
        Text(
          value,
          style: const TextStyle(
            fontSize: AppTheme.fontSizeXXLarge,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: AppTheme.fontSizeSmall,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
