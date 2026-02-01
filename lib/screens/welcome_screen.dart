import 'package:flutter/material.dart';
import '../common/app_strings.dart';
import '../common/app_theme.dart';
import 'home_screen.dart';

/// Ecranul de bun venit care prezintă aplicația
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF223843),
              Color(0xFF2c4652),
              Color(0xFF3a5562),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingXXLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),

                    

                    // Titlu
                    Text(
                      AppStrings.welcomeTitle,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppTheme.spacingMedium),

                    // Subtitlu
                    Text(
                      AppStrings.welcomeSubtitle,
                      style: TextStyle(
                        fontSize: AppTheme.fontSizeLarge,
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppTheme.spacingXLarge),

                    // Descriere
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingLarge),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        AppStrings.welcomeDescription,
                        style: TextStyle(
                          fontSize: AppTheme.fontSizeMedium,
                          color: Colors.white.withValues(alpha: 0.85),
                          height: 1.6,
                          letterSpacing: 0.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingXXLarge),

                    // Caracteristici
                    _buildFeature(Icons.favorite_border, AppStrings.welcomeFeature1),
                    const SizedBox(height: AppTheme.spacingMedium),
                    _buildFeature(Icons.filter_list, AppStrings.welcomeFeature2),
                    const SizedBox(height: AppTheme.spacingMedium),
                    _buildFeature(Icons.check_circle_outline, AppStrings.welcomeFeature3),

                    const Spacer(),

                    // Buton de start
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: AppTheme.accentGradient,
                        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.accent.withValues(alpha: 0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.flight_takeoff,
                              color: Colors.white,
                              size: AppTheme.iconSizeLarge,
                            ),
                            const SizedBox(width: AppTheme.spacingMedium),
                            Text(
                              AppStrings.welcomeStartButton,
                              style: const TextStyle(
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

                    const SizedBox(height: AppTheme.spacingLarge),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Widget pentru o caracteristică
  Widget _buildFeature(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppTheme.spacingSmall),
          decoration: BoxDecoration(
            color: AppTheme.accent.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
          ),
          child: Icon(
            icon,
            color: AppTheme.accent,
            size: AppTheme.iconSizeMedium,
          ),
        ),
        const SizedBox(width: AppTheme.spacingMedium),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: AppTheme.fontSizeRegular,
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
