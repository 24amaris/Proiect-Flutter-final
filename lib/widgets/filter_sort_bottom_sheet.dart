import 'package:flutter/material.dart';
import '../common/app_strings.dart';
import '../common/app_theme.dart';

/// Enum pentru tipurile de sortare
enum SortType {
  name,
  country,
  budgetAsc,
  budgetDesc,
}

/// Bottom sheet pentru filtre și sortare
class FilterSortBottomSheet extends StatefulWidget {
  final FilterType currentFilter;
  final SortType currentSort;
  final Set<String> selectedSeasons;
  final Function(FilterType) onFilterChanged;
  final Function(SortType) onSortChanged;
  final Function(String) onSeasonToggle;
  final VoidCallback onClearSeasons;

  const FilterSortBottomSheet({
    super.key,
    required this.currentFilter,
    required this.currentSort,
    required this.selectedSeasons,
    required this.onFilterChanged,
    required this.onSortChanged,
    required this.onSeasonToggle,
    required this.onClearSeasons,
  });

  @override
  State<FilterSortBottomSheet> createState() => _FilterSortBottomSheetState();
}

class _FilterSortBottomSheetState extends State<FilterSortBottomSheet> {
  late FilterType _selectedFilter;
  late SortType _selectedSort;
  late Set<String> _selectedSeasons;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.currentFilter;
    _selectedSort = widget.currentSort;
    _selectedSeasons = Set.from(widget.selectedSeasons);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusXLarge),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingXLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingLarge),

                // Titlu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Filtre și Sortare',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryDark,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      color: AppTheme.primaryDark,
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacingXLarge),

                // Secțiune Filtre Status
                _buildSectionTitle('Status Vizitare'),
                const SizedBox(height: AppTheme.spacingMedium),
                Wrap(
                  spacing: AppTheme.spacingSmall,
                  runSpacing: AppTheme.spacingSmall,
                  children: [
                    _buildFilterChip(
                      'Toate',
                      FilterType.all,
                      Icons.list,
                    ),
                    _buildFilterChip(
                      'Vizitate',
                      FilterType.visited,
                      Icons.check_circle,
                    ),
                    _buildFilterChip(
                      'De vizitat',
                      FilterType.notVisited,
                      Icons.circle_outlined,
                    ),
                  ],
                ),

                const SizedBox(height: AppTheme.spacingXLarge),

                // Secțiune Sortare
                _buildSectionTitle('Sortare'),
                const SizedBox(height: AppTheme.spacingMedium),
                _buildSortOption(
                  'Nume (A-Z)',
                  SortType.name,
                  Icons.sort_by_alpha,
                ),
                _buildSortOption(
                  'Țară (A-Z)',
                  SortType.country,
                  Icons.public,
                ),
                _buildSortOption(
                  'Preț Crescător',
                  SortType.budgetAsc,
                  Icons.arrow_upward,
                ),
                _buildSortOption(
                  'Preț Descrescător',
                  SortType.budgetDesc,
                  Icons.arrow_downward,
                ),

                const SizedBox(height: AppTheme.spacingXLarge),

                // Secțiune Sezoane
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSectionTitle('Anotimp'),
                    if (_selectedSeasons.isNotEmpty)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedSeasons.clear();
                          });
                          widget.onClearSeasons();
                        },
                        child: const Text(
                          'Resetează',
                          style: TextStyle(
                            color: AppTheme.accent,
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

                const SizedBox(height: AppTheme.spacingXXLarge),

                // Buton Aplică
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppTheme.accentGradient,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    boxShadow: AppTheme.buttonShadow(AppTheme.accent),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppTheme.spacingLarge,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                      ),
                    ),
                    child: const Text(
                      'Aplică Filtrele',
                      style: TextStyle(
                        fontSize: AppTheme.fontSizeLarge,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.primaryDark,
      ),
    );
  }

  Widget _buildFilterChip(String label, FilterType type, IconData icon) {
    final isSelected = _selectedFilter == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = type;
        });
        widget.onFilterChanged(type);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMedium,
          vertical: AppTheme.spacingSmall,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryDark : Colors.grey[100],
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: isSelected ? AppTheme.primaryDark : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppTheme.iconSizeSmall,
              color: isSelected ? Colors.white : AppTheme.textPrimary,
            ),
            const SizedBox(width: AppTheme.spacingSmall),
            Text(
              label,
              style: TextStyle(
                fontSize: AppTheme.fontSizeSmall,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(String label, SortType type, IconData icon) {
    final isSelected = _selectedSort == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSort = type;
        });
        widget.onSortChanged(type);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.accent.withValues(alpha: 0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: isSelected ? AppTheme.accent : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingSmall),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.accent.withValues(alpha: 0.2)
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Icon(
                icon,
                size: AppTheme.iconSizeMedium,
                color: isSelected ? AppTheme.accent : AppTheme.textSecondary,
              ),
            ),
            const SizedBox(width: AppTheme.spacingMedium),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: AppTheme.fontSizeRegular,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? AppTheme.primaryDark : AppTheme.textPrimary,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppTheme.accent,
                size: AppTheme.iconSizeMedium,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeasonChip(String season, IconData icon, Color color) {
    final isSelected = _selectedSeasons.contains(season);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedSeasons.remove(season);
          } else {
            _selectedSeasons.add(season);
          }
        });
        widget.onSeasonToggle(season);
      },
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
            color: isSelected ? color : Colors.grey[300]!,
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
              const Icon(
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

/// Enum pentru tipurile de filtre
enum FilterType { all, visited, notVisited }
