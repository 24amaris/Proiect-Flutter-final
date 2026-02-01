import 'package:flutter/material.dart';
import '../common/app_strings.dart';
import '../common/app_theme.dart';
import '../models/destination.dart';
import '../data/destination_data.dart';
import '../utils/validators.dart';
import '../utils/dialog_helper.dart';

class AddDestinationScreen extends StatefulWidget {
  const AddDestinationScreen({super.key});

  @override
  State<AddDestinationScreen> createState() => _AddDestinationScreenState();
}

class _AddDestinationScreenState extends State<AddDestinationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _budgetController = TextEditingController();
  final _attractionsController = TextEditingController();

  final Set<String> _selectedSeasons = {};
  bool _visited = false;

  @override
  void dispose() {
    _nameController.dispose();
    _countryController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _budgetController.dispose();
    _attractionsController.dispose();
    super.dispose();
  }

  /// Salvarea noii destinații
  void _saveDestination() {
    // Validare sezoane
    if (_selectedSeasons.isEmpty) {
      DialogHelper.showSnackBar(
        context,
        AppStrings.validationSeasonsRequired,
        isError: true,
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final newDestination = Destination(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        country: _countryController.text.trim(),
        imageUrl: _imageUrlController.text.trim(),
        description: _descriptionController.text.trim(),
        seasons: _selectedSeasons.toList(),
        budget: double.parse(_budgetController.text.trim()),
        attractions: _attractionsController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        visited: _visited,
      );

      destinations.add(newDestination);

      if (mounted) {
        DialogHelper.showSnackBar(
          context,
          'Destinația a fost adăugată cu succes!',
        );
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text(
          AppStrings.addTitle,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: AppTheme.fontSizeLarge,
          ),
        ),
        backgroundColor: AppTheme.primaryDark,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.primaryGradient,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppTheme.spacingLarge),
          children: [
            // Nume destinație
            _buildLabel(AppStrings.addNameLabel),
            _buildTextField(
              _nameController,
              AppStrings.addNameHint,
              validator: Validators.validateDestinationName,
            ),
            const SizedBox(height: AppTheme.spacingLarge),

            // Țară
            _buildLabel(AppStrings.addCountryLabel),
            _buildTextField(
              _countryController,
              AppStrings.addCountryHint,
              validator: Validators.validateCountry,
            ),
            const SizedBox(height: AppTheme.spacingLarge),

            // Descriere
            _buildLabel(AppStrings.addDescriptionLabel),
            _buildTextField(
              _descriptionController,
              AppStrings.addDescriptionHint,
              maxLines: 4,
              validator: Validators.validateDescription,
            ),
            const SizedBox(height: AppTheme.spacingLarge),

            // URL Imagine
            _buildLabel(AppStrings.addImageLabel),
            _buildTextField(
              _imageUrlController,
              AppStrings.addImageHint,
              validator: Validators.validateImageUrl,
            ),
            const SizedBox(height: AppTheme.spacingLarge),

            // Buget
            _buildLabel(AppStrings.addBudgetLabel),
            _buildTextField(
              _budgetController,
              AppStrings.addBudgetHint,
              keyboardType: TextInputType.number,
              validator: Validators.validateBudget,
            ),
            const SizedBox(height: AppTheme.spacingLarge),

            // Selector sezoane
            _buildLabel(AppStrings.addSeasonsLabel),
            _buildSeasonSelector(),
            const SizedBox(height: AppTheme.spacingLarge),

            // Atracții
            _buildLabel(AppStrings.addAttractionsLabel),
            _buildTextField(
              _attractionsController,
              AppStrings.addAttractionsHint,
              maxLines: 3,
              validator: Validators.validateAttractions,
            ),
            const SizedBox(height: AppTheme.spacingLarge),

            // Checkbox vizitat
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingLarge),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                border: Border.all(
                  color: AppTheme.accent.withValues(alpha: 0.3),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.shadowLight,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: _visited ? AppTheme.accentGradient : null,
                      color: _visited ? null : Colors.grey[200],
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                    ),
                    child: Checkbox(
                      value: _visited,
                      onChanged: (value) {
                        setState(() {
                          _visited = value ?? false;
                        });
                      },
                      activeColor: Colors.transparent,
                      checkColor: Colors.white,
                      side: BorderSide.none,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingSmall),
                  const Expanded(
                    child: Text(
                      AppStrings.addVisitedCheckbox,
                      style: TextStyle(
                        fontSize: AppTheme.fontSizeMedium,
                        color: AppTheme.primaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppTheme.spacingXXLarge),

            // Buton salvare
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: AppTheme.accentGradient,
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                boxShadow: AppTheme.buttonShadow(AppTheme.accent),
              ),
              child: ElevatedButton(
                onPressed: _saveDestination,
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: AppTheme.iconSizeLarge,
                    ),
                    SizedBox(width: AppTheme.spacingMedium),
                    Text(
                      AppStrings.addSaveButton,
                      style: TextStyle(
                        fontSize: AppTheme.fontSizeLarge,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget pentru etichetă
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: AppTheme.fontSizeMedium,
          fontWeight: FontWeight.w600,
          color: AppTheme.primaryDark,
        ),
      ),
    );
  }

  /// Widget pentru câmp de text
  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: AppTheme.elevationSmall,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(
          fontSize: AppTheme.fontSizeMedium,
          color: AppTheme.primaryDark,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: AppTheme.textLight,
            fontSize: AppTheme.fontSizeMedium,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            borderSide: BorderSide(
              color: AppTheme.borderLight,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            borderSide: BorderSide(
              color: AppTheme.borderLight,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            borderSide: const BorderSide(
              color: AppTheme.accent,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            borderSide: BorderSide(
              color: Colors.red[400]!,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            borderSide: BorderSide(
              color: Colors.red[400]!,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingLarge,
            vertical: AppTheme.spacingLarge,
          ),
        ),
      ),
    );
  }

  /// Widget pentru selector de sezoane
  Widget _buildSeasonSelector() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(
          color: _selectedSeasons.isEmpty
              ? Colors.red[300]!
              : AppTheme.borderLight,
          width: _selectedSeasons.isEmpty ? 2 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: AppTheme.elevationSmall,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_selectedSeasons.isEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
              child: Text(
                'Selectează cel puțin un sezon',
                style: TextStyle(
                  fontSize: AppTheme.fontSizeSmall,
                  color: Colors.red[400],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
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

  /// Widget pentru chip de sezon
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
