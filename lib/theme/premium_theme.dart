import 'package:flutter/material.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// PREMIUM MULTIMEDIA PLATFORM - COMPLETE DESIGN SYSTEM
/// Spotify + YouTube + IDM Combined
/// ═══════════════════════════════════════════════════════════════════════════

// ─────────────────────────────────────────────────────────────────────────
// PREMIUM COLORS
// ─────────────────────────────────────────────────────────────────────────
class PremiumColors {
  // Background
  static const Color bg0 = Color(0xFF0D0D0D); // Pure dark (OLED)
  static const Color bg1 = Color(0xFF1A1A1A); // Cards
  static const Color bg2 = Color(0xFF242424); // Elevated
  
  // Accent - Purple/Blue Glow
  static const Color accentPrimary = Color(0xFF7B68EE); // Medium Slate Blue
  static const Color accentGlow = Color(0xFF9D7FFF); // Lighter
  static const Color accentDark = Color(0xFF5A4FB5); // Darker
  
  // Secondary
  static const Color accentCyan = Color(0xFF00D9FF);
  static const Color accentMagenta = Color(0xFFFF00FF);
  
  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textTertiary = Color(0xFF808080);
  
  // Semantic
  static const Color success = Color(0xFF00D084);
  static const Color error = Color(0xFFFF5252);
  static const Color warning = Color(0xFFFFB800);
  
  // Gradients
  static const LinearGradient gradientAccent = LinearGradient(
    colors: [Color(0xFF7B68EE), Color(0xFF9D7FFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient gradientGlow = LinearGradient(
    colors: [Color(0xFF00D9FF), Color(0xFF7B68EE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ─────────────────────────────────────────────────────────────────────────
// PREMIUM TYPOGRAPHY - من غير Google Fonts
// ─────────────────────────────────────────────────────────────────────────
class PremiumTypography {
  static const TextStyle displayLarge = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w900,
    letterSpacing: -1.0,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
  );

  static const TextStyle headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headingSmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );
}

// ─────────────────────────────────────────────────────────────────────────
// PREMIUM SPACING
// ─────────────────────────────────────────────────────────────────────────
class PremiumSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

// ─────────────────────────────────────────────────────────────────────────
// PREMIUM RADIUS
// ─────────────────────────────────────────────────────────────────────────
class PremiumRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double circle = 999;

  static const BorderRadius smRadius = BorderRadius.all(Radius.circular(8));
  static const BorderRadius mdRadius = BorderRadius.all(Radius.circular(12));
  static const BorderRadius lgRadius = BorderRadius.all(Radius.circular(16));
  static const BorderRadius xlRadius = BorderRadius.all(Radius.circular(20));
  static const BorderRadius xxlRadius = BorderRadius.all(Radius.circular(24));
}

// ─────────────────────────────────────────────────────────────────────────
// PREMIUM SHADOWS - Glassmorphism
// ─────────────────────────────────────────────────────────────────────────
class PremiumShadows {
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    )
  ];

  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x24000000),
      blurRadius: 12,
      offset: Offset(0, 4),
    )
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x33000000),
      blurRadius: 24,
      offset: Offset(0, 12),
    )
  ];

  static const List<BoxShadow> glow = [
    BoxShadow(
      color: Color(0xFF7B68EE),
      blurRadius: 16,
      spreadRadius: 2,
    )
  ];

  static const List<BoxShadow> glowCyan = [
    BoxShadow(
      color: Color(0xFF00D9FF),
      blurRadius: 12,
      spreadRadius: 1,
    )
  ];
}

// ─────────────────────────────────────────────────────────────────────────
// DURATIONS & CURVES
// ─────────────────────────────────────────────────────────────────────────
class PremiumDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
}

class PremiumCurves {
  static const Curve smooth = Curves.easeInOutCubic;
  static const Curve enter = Curves.easeOutCubic;
  static const Curve exit = Curves.easeInCubic;
}

// ═══════════════════════════════════════════════════════════════════════════
// THEME DATA - PREMIUM DARK THEME
// ═══════════════════════════════════════════════════════════════════════════
ThemeData getPremiumTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: PremiumColors.bg0,
    primaryColor: PremiumColors.accentPrimary,

    appBarTheme: AppBarTheme(
      backgroundColor: PremiumColors.bg0.withOpacity(0.8),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: PremiumTypography.headingMedium.copyWith(
        color: PremiumColors.textPrimary,
      ),
      iconTheme: const IconThemeData(color: PremiumColors.textPrimary),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: PremiumColors.bg1.withOpacity(0.95),
      selectedItemColor: PremiumColors.accentPrimary,
      unselectedItemColor: PremiumColors.textTertiary,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: PremiumColors.accentPrimary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: PremiumSpacing.xl,
          vertical: PremiumSpacing.lg,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: PremiumRadius.lgRadius,
        ),
        elevation: 0,
      ),
    ),

    cardColor: PremiumColors.bg1,

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: PremiumColors.bg2,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: PremiumSpacing.lg,
        vertical: PremiumSpacing.md,
      ),
      border: OutlineInputBorder(
        borderRadius: PremiumRadius.lgRadius,
        borderSide: const BorderSide(
          color: PremiumColors.accentPrimary,
          width: 0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: PremiumRadius.lgRadius,
        borderSide: BorderSide(
          color: PremiumColors.accentPrimary.withOpacity(0.3),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: PremiumRadius.lgRadius,
        borderSide: const BorderSide(
          color: PremiumColors.accentPrimary,
          width: 2,
        ),
      ),
      hintStyle: PremiumTypography.bodyMedium.copyWith(
        color: PremiumColors.textTertiary,
      ),
    ),

    textTheme: TextTheme(
      displayLarge: PremiumTypography.displayLarge.copyWith(
        color: PremiumColors.textPrimary,
      ),
      displayMedium: PremiumTypography.displayMedium.copyWith(
        color: PremiumColors.textPrimary,
      ),
      headlineLarge: PremiumTypography.headingLarge.copyWith(
        color: PremiumColors.textPrimary,
      ),
      headlineMedium: PremiumTypography.headingMedium.copyWith(
        color: PremiumColors.textPrimary,
      ),
      headlineSmall: PremiumTypography.headingSmall.copyWith(
        color: PremiumColors.textPrimary,
      ),
      bodyLarge: PremiumTypography.bodyLarge.copyWith(
        color: PremiumColors.textSecondary,
      ),
      bodyMedium: PremiumTypography.bodyMedium.copyWith(
        color: PremiumColors.textSecondary,
      ),
      bodySmall: PremiumTypography.bodySmall.copyWith(
        color: PremiumColors.textTertiary,
      ),
    ),

    colorScheme: ColorScheme.dark(
      primary: PremiumColors.accentPrimary,
      secondary: PremiumColors.accentCyan,
      tertiary: PremiumColors.accentMagenta,
      background: PremiumColors.bg0,
      surface: PremiumColors.bg1,
      error: PremiumColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: PremiumColors.textPrimary,
      onSurface: PremiumColors.textPrimary,
      onError: Colors.white,
    ),
  );
}