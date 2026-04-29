import 'package:flutter/material.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// ECLIPSE PLAYER - CINEMATIC "WOW" DESIGN SYSTEM
/// Motion-Driven, Apple TV + Netflix Inspired
/// ═══════════════════════════════════════════════════════════════════════════

// ─────────────────────────────────────────────────────────────────────────
// CINEMATIC COLOR PALETTE
// ─────────────────────────────────────────────────────────────────────────
class CinematicColors {
  // Deep Cinema Black (OLED Perfect)
  static const Color deepBlack = Color(0xFF0a0e27);
  static const Color veryDarkBlue = Color(0xFF0f1429);
  static const Color darkCharcoal = Color(0xFF1a1f3a);
  
  // Brand Accent - Neon Cyan (High Energy)
  static const Color neonCyan = Color(0xFF00d9ff);
  static const Color neonCyanLight = Color(0xFF33e5ff);
  static const Color neonCyanDark = Color(0xFF00a8cc);
  
  // Secondary Colors
  static const Color accentMagenta = Color(0xFFff006e);
  static const Color accentGold = Color(0xFFffd60a);
  static const Color accentPurple = Color(0xFF9D4EDD);
  
  // Glow Effect Colors
  static Color glowCyan = const Color(0xFF00d9ff).withOpacity(0.2);
  static Color glowMagenta = const Color(0xFFff006e).withOpacity(0.15);
  
  // Text
  static const Color textPrimary = Color(0xFFffffff);
  static const Color textSecondary = Color(0xFFb0b3ba);
  static const Color textTertiary = Color(0xFF7a7e88);
  static const Color textMuted = Color(0xFF4a4e5c);
  
  // Semantic
  static const Color success = Color(0xFF00d084);
  static const Color error = Color(0xFFff4444);
  static const Color warning = Color(0xFFffb800);
  
  // Gradients
  static const LinearGradient gradientCyan = LinearGradient(
    colors: [Color(0xFF00d9ff), Color(0xFF00a8cc)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient gradientMagenta = LinearGradient(
    colors: [Color(0xFFff006e), Color(0xFFff4695)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient gradientCinematic = LinearGradient(
    colors: [Color(0xFF0a0e27), Color(0xFF1a1f3a), Color(0xFF0f1429)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient gradientHero = LinearGradient(
    colors: [Color(0xFF00d9ff), Color(0xFF9D4EDD)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ─────────────────────────────────────────────────────────────────────────
// CINEMATIC TYPOGRAPHY - من غير Google Fonts (خط النظام الافتراضي)
// ─────────────────────────────────────────────────────────────────────────
class CinematicTypography {
  // Display - Cinematic Headlines
  static const TextStyle displayLarge = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w900,
    letterSpacing: -1.5,
    height: 1.1,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.0,
    height: 1.15,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    height: 1.2,
  );

  // Headline - Section Headers
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 1.25,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.3,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.4,
  );

  // Title
  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.45,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.5,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  // Label
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.33,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.45,
  );
}

// ─────────────────────────────────────────────────────────────────────────
// SPACING - Cinema Grade
// ─────────────────────────────────────────────────────────────────────────
class CinematicSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;

  static const EdgeInsets paddingLg = EdgeInsets.all(16);
  static const EdgeInsets paddingXl = EdgeInsets.all(24);
  static const EdgeInsets paddingXxl = EdgeInsets.all(32);
}

// ─────────────────────────────────────────────────────────────────────────
// BORDER RADIUS - Cinema Style
// ─────────────────────────────────────────────────────────────────────────
class CinematicRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 28;
  static const double circle = 999;

  static const BorderRadius radiusXs = BorderRadius.all(Radius.circular(4));
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(8));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(12));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(16));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(20));
  static const BorderRadius radiusCircle = BorderRadius.all(Radius.circular(999));
}

// ─────────────────────────────────────────────────────────────────────────
// CINEMATIC SHADOWS - Deep & Glowing
// ─────────────────────────────────────────────────────────────────────────
class CinematicShadows {
  // Subtle glow
  static const BoxShadow glowSm = BoxShadow(
    color: Color(0xFF00d9ff),
    blurRadius: 8,
    spreadRadius: 0,
    offset: Offset(0, 0),
  );

  // Medium glow
  static const BoxShadow glowMd = BoxShadow(
    color: Color(0xFF00d9ff),
    blurRadius: 16,
    spreadRadius: 1,
    offset: Offset(0, 0),
  );

  // Strong glow
  static const List<BoxShadow> glowLg = [
    BoxShadow(
      color: Color(0xFF00d9ff),
      blurRadius: 24,
      spreadRadius: 2,
      offset: Offset(0, 0),
    )
  ];

  // Deep shadow
  static const BoxShadow shadowDeep = BoxShadow(
    color: Color(0x40000000),
    blurRadius: 20,
    offset: Offset(0, 8),
  );

  // Cinema card shadow
  static const List<BoxShadow> shadowCinema = [
    BoxShadow(
      color: Color(0x2F000000),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
    BoxShadow(
      color: Color(0xFF00d9ff),
      blurRadius: 12,
      spreadRadius: -6,
      offset: Offset(0, 0),
    ),
  ];

  // Floating effect
  static const List<BoxShadow> shadowFloat = [
    BoxShadow(
      color: Color(0x3F000000),
      blurRadius: 24,
      offset: Offset(0, 12),
    )
  ];
}

// ─────────────────────────────────────────────────────────────────────────
// ANIMATION TIMINGS - Cinema Frame Rates
// ─────────────────────────────────────────────────────────────────────────
class CinematicDurations {
  static const Duration instant = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 250);
  static const Duration normal = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 600);
  static const Duration verySlow = Duration(milliseconds: 1000);
}

// ─────────────────────────────────────────────────────────────────────────
// ANIMATION CURVES - Cinema Transitions
// ─────────────────────────────────────────────────────────────────────────
class CinematicCurves {
  static const Curve easeInOutCinema = Curves.easeInOutCubic;
  static const Curve easeOutCinema = Curves.easeOutCubic;
  static const Curve easeInCinema = Curves.easeInCubic;
  static const Curve smoothBounce = Curves.elasticOut;
  static const Curve springSmooth = Curves.elasticInOut;
}

// ═══════════════════════════════════════════════════════════════════════════
// DARK THEME - CINEMATIC
// ═══════════════════════════════════════════════════════════════════════════
ThemeData createCinematicTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: CinematicColors.deepBlack,
    primaryColor: CinematicColors.neonCyan,
    
    appBarTheme: AppBarTheme(
      backgroundColor: CinematicColors.deepBlack,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: CinematicTypography.headlineMedium.copyWith(
        color: CinematicColors.textPrimary,
        fontWeight: FontWeight.w800,
      ),
      iconTheme: const IconThemeData(color: CinematicColors.textPrimary),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: CinematicColors.veryDarkBlue.withOpacity(0.95),
      selectedItemColor: CinematicColors.neonCyan,
      unselectedItemColor: CinematicColors.textTertiary,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: CinematicColors.neonCyan,
      foregroundColor: CinematicColors.deepBlack,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: CinematicRadius.radiusLg,
      ),
    ),

    cardTheme: CardThemeData(
      color: CinematicColors.darkCharcoal,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: CinematicRadius.radiusLg,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CinematicColors.neonCyan,
        foregroundColor: CinematicColors.deepBlack,
        padding: const EdgeInsets.symmetric(
          horizontal: CinematicSpacing.lg,
          vertical: CinematicSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: CinematicRadius.radiusLg,
        ),
        elevation: 0,
        shadowColor: CinematicColors.neonCyan.withOpacity(0.4),
      ),
    ),

    textTheme: TextTheme(
      displayLarge: CinematicTypography.displayLarge.copyWith(color: CinematicColors.textPrimary),
      displayMedium: CinematicTypography.displayMedium.copyWith(color: CinematicColors.textPrimary),
      displaySmall: CinematicTypography.displaySmall.copyWith(color: CinematicColors.textPrimary),
      headlineLarge: CinematicTypography.headlineLarge.copyWith(color: CinematicColors.textPrimary),
      headlineMedium: CinematicTypography.headlineMedium.copyWith(color: CinematicColors.textPrimary),
      headlineSmall: CinematicTypography.headlineSmall.copyWith(color: CinematicColors.textPrimary),
      bodyLarge: CinematicTypography.bodyLarge.copyWith(color: CinematicColors.textPrimary),
      bodyMedium: CinematicTypography.bodyMedium.copyWith(color: CinematicColors.textSecondary),
      bodySmall: CinematicTypography.bodySmall.copyWith(color: CinematicColors.textTertiary),
      labelLarge: CinematicTypography.labelLarge.copyWith(color: CinematicColors.textPrimary),
      labelMedium: CinematicTypography.labelMedium.copyWith(color: CinematicColors.textSecondary),
      labelSmall: CinematicTypography.labelSmall.copyWith(color: CinematicColors.textTertiary),
    ),

    colorScheme: ColorScheme.dark(
      primary: CinematicColors.neonCyan,
      secondary: CinematicColors.accentMagenta,
      tertiary: CinematicColors.accentPurple,
      background: CinematicColors.deepBlack,
      surface: CinematicColors.veryDarkBlue,
      error: CinematicColors.error,
      onPrimary: CinematicColors.deepBlack,
      onSecondary: Colors.white,
      onBackground: CinematicColors.textPrimary,
      onSurface: CinematicColors.textPrimary,
      onError: Colors.white,
    ),
  );
}