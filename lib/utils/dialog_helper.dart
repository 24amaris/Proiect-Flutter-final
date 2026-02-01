import 'package:flutter/material.dart';
import '../common/app_strings.dart';
import '../common/app_theme.dart';

/// Helper pentru afișarea dialogurilor în aplicație
class DialogHelper {
  // Constructor privat
  DialogHelper._();

  /// Afișează un dialog de confirmare pentru ștergere
  static Future<bool> showDeleteConfirmation(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingSmall),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: Colors.red[400],
                size: AppTheme.iconSizeLarge,
              ),
            ),
            const SizedBox(width: AppTheme.spacingMedium),
            const Expanded(
              child: Text(
                AppStrings.deleteDialogTitle,
                style: TextStyle(
                  fontSize: AppTheme.fontSizeLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: const Text(
          AppStrings.deleteDialogMessage,
          style: TextStyle(fontSize: AppTheme.fontSizeMedium),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              AppStrings.deleteDialogCancel,
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: AppTheme.fontSizeMedium,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
            ),
            child: const Text(
              AppStrings.deleteDialogConfirm,
              style: TextStyle(fontSize: AppTheme.fontSizeMedium),
            ),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  /// Afișează un snackbar cu un mesaj
  static void showSnackBar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: AppTheme.spacingMedium),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: AppTheme.fontSizeMedium),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? Colors.red[400] : AppTheme.accent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
