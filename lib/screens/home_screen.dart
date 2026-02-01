import 'package:flutter/material.dart';
import '../common/app_strings.dart';
import '../common/app_theme.dart';
import '../data/destination_data.dart';
import '../models/destination.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/destination_card.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/statistics_card.dart';
import '../widgets/filter_sort_bottom_sheet.dart';
import '../utils/dialog_helper.dart';
import 'destination_detail_screen.dart';
import 'add_destination_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FilterType _currentFilter = FilterType.all;
  SortType _sortType = SortType.name;
  Set<String> _selectedSeasons = {};

  /// Refresh-uiește lista
  void _refreshList() {
    setState(() {});
  }

  /// Marchează/demarchează o destinație ca vizitată
  void _toggleVisited(int index) {
    setState(() {
      destinations[index].visited = !destinations[index].visited;
    });
  }

  /// Șterge o destinație după confirmare
  Future<void> _deleteDestination(int index) async {
    final confirmed = await DialogHelper.showDeleteConfirmation(context);
    if (confirmed && mounted) {
      setState(() {
        destinations.removeAt(index);
      });
      if (mounted) {
        DialogHelper.showSnackBar(
          context,
          'Destinația a fost ștearsă cu succes',
        );
      }
    }
  }

  /// Navighează la ecranul de adăugare
  Future<void> _navigateToAddScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddDestinationScreen(),
      ),
    );
    if (result == true) {
      _refreshList();
    }
  }

  /// Deschide bottom sheet pentru filtre și sortare
  void _showFilterSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterSortBottomSheet(
        currentFilter: _currentFilter,
        currentSort: _sortType,
        selectedSeasons: _selectedSeasons,
        onFilterChanged: (filter) {
          setState(() {
            _currentFilter = filter;
          });
        },
        onSortChanged: (sort) {
          setState(() {
            _sortType = sort;
          });
        },
        onSeasonToggle: (season) {
          setState(() {
            if (_selectedSeasons.contains(season)) {
              _selectedSeasons.remove(season);
            } else {
              _selectedSeasons.add(season);
            }
          });
        },
        onClearSeasons: () {
          setState(() {
            _selectedSeasons.clear();
          });
        },
      ),
    );
  }

  /// Filtrează destinațiile bazat pe filtrul curent
  List<Destination> _getFilteredDestinations() {
    List<Destination> filtered = [];

    // Filtrare după visited
    switch (_currentFilter) {
      case FilterType.all:
        filtered = List.from(destinations);
        break;
      case FilterType.visited:
        filtered = destinations.where((d) => d.visited).toList();
        break;
      case FilterType.notVisited:
        filtered = destinations.where((d) => !d.visited).toList();
        break;
    }

    // Filtrare după sezoane
    if (_selectedSeasons.isNotEmpty) {
      filtered = filtered.where((destination) {
        return destination.seasons
            .any((season) => _selectedSeasons.contains(season));
      }).toList();
    }

    // Sortare
    switch (_sortType) {
      case SortType.name:
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortType.country:
        filtered.sort((a, b) => a.country.compareTo(b.country));
        break;
      case SortType.budgetAsc:
        filtered.sort((a, b) => a.budget.compareTo(b.budget));
        break;
      case SortType.budgetDesc:
        filtered.sort((a, b) => b.budget.compareTo(a.budget));
        break;
    }

    return filtered;
  }

  /// Calculează statisticile
  int get _totalDestinations => destinations.length;
  int get _visitedDestinations =>
      destinations.where((d) => d.visited).length;
  int get _remainingDestinations =>
      destinations.where((d) => !d.visited).length;

  /// Obține textul sortării curente
  String get _currentSortText {
    switch (_sortType) {
      case SortType.name:
        return 'Nume (A-Z)';
      case SortType.country:
        return 'Țară (A-Z)';
      case SortType.budgetAsc:
        return 'Preț Crescător';
      case SortType.budgetDesc:
        return 'Preț Descrescător';
    }
  }

  /// Obține numărul de filtre active
  int get _activeFiltersCount {
    int count = 0;
    if (_currentFilter != FilterType.all) count++;
    if (_selectedSeasons.isNotEmpty) count++;
    if (_sortType != SortType.name) count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final filteredDestinations = _getFilteredDestinations();

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: const CustomAppBar(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: destinations.isEmpty
              ? EmptyStateWidget(onAddPressed: _navigateToAddScreen)
              : Column(
                  children: [
                    // Statistici
                    StatisticsCard(
                      totalDestinations: _totalDestinations,
                      visitedDestinations: _visitedDestinations,
                      remainingDestinations: _remainingDestinations,
                    ),

                    // Buton pentru filtre și sortare
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingLarge,
                        vertical: AppTheme.spacingMedium,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _showFilterSortBottomSheet,
                          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                          child: Container(
                            padding: const EdgeInsets.all(AppTheme.spacingLarge),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                              border: Border.all(
                                color: _activeFiltersCount > 0
                                    ? AppTheme.accent
                                    : AppTheme.borderLight,
                                width: _activeFiltersCount > 0 ? 2 : 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.shadowLight,
                                  blurRadius: AppTheme.elevationSmall,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(AppTheme.spacingSmall),
                                  decoration: BoxDecoration(
                                    gradient: _activeFiltersCount > 0
                                        ? AppTheme.accentGradient
                                        : null,
                                    color: _activeFiltersCount > 0
                                        ? null
                                        : AppTheme.primaryDark.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                                  ),
                                  child: Icon(
                                    Icons.filter_list,
                                    color: _activeFiltersCount > 0
                                        ? Colors.white
                                        : AppTheme.primaryDark,
                                    size: AppTheme.iconSizeMedium,
                                  ),
                                ),
                                const SizedBox(width: AppTheme.spacingMedium),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Filtre și Sortare',
                                        style: TextStyle(
                                          fontSize: AppTheme.fontSizeRegular,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        _activeFiltersCount > 0
                                            ? '$_currentSortText • $_activeFiltersCount activ${_activeFiltersCount > 1 ? 'e' : ''}'
                                            : 'Apasă pentru a filtra',
                                        style: TextStyle(
                                          fontSize: AppTheme.fontSizeSmall,
                                          color: _activeFiltersCount > 0
                                              ? AppTheme.accent
                                              : AppTheme.textSecondary,
                                          fontWeight: _activeFiltersCount > 0
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: AppTheme.iconSizeSmall,
                                  color: AppTheme.textSecondary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Lista de destinații
                    Expanded(
                      child: filteredDestinations.isEmpty
                          ? _buildEmptyFilteredList()
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppTheme.spacingLarge,
                              ),
                              itemCount: filteredDestinations.length,
                              itemBuilder: (context, index) {
                                final destination = filteredDestinations[index];
                                final originalIndex =
                                    destinations.indexOf(destination);
                                return DestinationCard(
                                  destination: destination,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DestinationDetailScreen(
                                          destination: destination,
                                        ),
                                      ),
                                    );
                                  },
                                  onVisitedChanged: () =>
                                      _toggleVisited(originalIndex),
                                  onDelete: () =>
                                      _deleteDestination(originalIndex),
                                );
                              },
                            ),
                    ),
                  ],
                ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  /// Widget pentru lista filtrată goală
  Widget _buildEmptyFilteredList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.filter_list_off,
            size: AppTheme.iconSizeHero,
            color: AppTheme.textSecondary,
          ),
          const SizedBox(height: AppTheme.spacingLarge),
          Text(
            'Nicio destinație găsită',
            style: TextStyle(
              fontSize: AppTheme.fontSizeXLarge,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacingSmall),
          Text(
            'Încearcă să schimbi filtrul',
            style: TextStyle(
              fontSize: AppTheme.fontSizeMedium,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  /// Floating Action Button
  Widget _buildFloatingActionButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: AppTheme.buttonShadow(AppTheme.accent),
      ),
      child: FloatingActionButton.extended(
        onPressed: _navigateToAddScreen,
        backgroundColor: AppTheme.accent,
        icon: const Icon(
          Icons.add_location_alt,
          color: Colors.white,
        ),
        label: const Text(
          AppStrings.homeAddButton,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: AppTheme.fontSizeRegular,
          ),
        ),
      ),
    );
  }
}
