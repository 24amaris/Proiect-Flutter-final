import '../common/app_strings.dart';

/// Clasa cu funcții de validare pentru formulare
class Validators {
  // Constructor privat
  Validators._();

  /// Validează că un string nu este gol
  static String? validateNotEmpty(String? value, String errorMessage) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage;
    }
    return null;
  }

  /// Validează numele destinației
  static String? validateDestinationName(String? value) {
    return validateNotEmpty(value, AppStrings.validationNameRequired);
  }

  /// Validează țara
  static String? validateCountry(String? value) {
    return validateNotEmpty(value, AppStrings.validationCountryRequired);
  }

  /// Validează descrierea
  static String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.validationDescriptionRequired;
    }
    if (value.trim().length < 10) {
      return 'Descrierea trebuie să aibă cel puțin 10 caractere';
    }
    return null;
  }

  /// Validează URL-ul imaginii
  static String? validateImageUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.validationImageRequired;
    }
    // Verifică dacă este un URL valid
    final urlPattern = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    if (!urlPattern.hasMatch(value.trim())) {
      return 'Te rog introdu un URL valid';
    }
    return null;
  }

  /// Validează bugetul
  static String? validateBudget(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.validationBudgetRequired;
    }
    final budget = double.tryParse(value.trim());
    if (budget == null || budget <= 0) {
      return 'Te rog introdu un buget valid';
    }
    return null;
  }

  /// Validează lista de sezoane
  static String? validateSeasons(List<String> seasons) {
    if (seasons.isEmpty) {
      return AppStrings.validationSeasonsRequired;
    }
    return null;
  }

  /// Validează lista de atracții
  static String? validateAttractions(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.validationAttractionsRequired;
    }
    // Verifică dacă există cel puțin o atracție (separate prin virgulă)
    final attractions = value.split(',').where((a) => a.trim().isNotEmpty).toList();
    if (attractions.isEmpty) {
      return 'Te rog adaugă cel puțin o atracție';
    }
    return null;
  }
}
