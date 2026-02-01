import 'package:flutter/material.dart';
import '../common/app_strings.dart';
import '../common/app_theme.dart';

/// AppBar customizat cu gradient și titlu centrat
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(AppTheme.radiusRound),
            bottomRight: Radius.circular(AppTheme.radiusRound),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowDark,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: AppBar(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                AppStrings.appName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: AppTheme.fontSizeHero,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
        ),
      ),
    );
  }
}
