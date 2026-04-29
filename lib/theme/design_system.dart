import 'package:flutter/material.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// ECLIPSE PLAYER - PREMIUM DESIGN SYSTEM
/// Inspired by Netflix, Spotify, YouTube Premium
/// ═══════════════════════════════════════════════════════════════════════════

// ─────────────────────────────────────────────────────────────────────────
// COLOR PALETTE - Premium & Professional
// ─────────────────────────────────────────────────────────────────────────
class AppColors {
  // Primary Brand Colors
  static const Color primaryGreen = Color(0xFF1DB954);
  static const Color primaryGreenLight = Color(0xFF1ed760);
  static const Color primaryGreenDark = Color(0xFF1aa34a);

  // Secondary Colors
  static const Color accentPink = Color(0xFFFF006E);
  static const Color accentCyan = Color(0xFF00D9FF);
  static const Color accentPurple = Color(0xFF9D4EDD);

  // Dark Mode Backgrounds (OLED Optimized)
  static const Color darkBg = Color(0xFF0F0F0F);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkCard = Color(0xFF242424);
  static const Color darkElevated = Color(0xFF2D2D2D);

  // Light Mode Backgrounds
  static const Color lightBg = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF5F5F5);

  // Text Colors
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3B3B3);
  static const Color textTertiary = Color(0xFF727272);

  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textDarkSecondary = Color(0xFF666666);
  static const Color textDarkTertiary = Color(0xFF999999);

  // Semantic Colors
  static const Color success = Color(0xFF00D084);
  static const Color warning = Color(0xFFFFB800);
  static const Color error = Color(0xFFFF4444);
  static const Color info = Color(0xFF4A90E2);

  // Gradients
  static const LinearGradient gradientGreen = LinearGradient(
    colors: [Color(0xFF1DB954), Color(0xFF1ed760)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradientPurple = LinearGradient(
    colors: [Color(0xFF9D4EDD), Color(0xFFFF006E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradientCyan = LinearGradient(
    colors: [Color(0xFF00D9FF), Color(0xFF4A90E2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ─────────────────────────────────────────────────────────────────────────
// TYPOGRAPHY - Modern Hierarchy (من غير Google Fonts)
// ─────────────────────────────────────────────────────────────────────────
class AppTypography {
  // Display - Large Headlines (32-48pt)
  static const TextStyle displayLarge = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.0,
    height: 1.2,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.8,
    height: 1.25,
  );

  static const TextStyle displaySmall = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.3,
  );

  // Headline - Section Headers (24-28pt)
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    height: 1.35,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.45,
  );

  // Title - Page/Section Titles (18-20pt)
  static const TextStyle titleLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.5,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.5,
  );

  // Body - Main Content (14-16pt)
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

  // Label - Small UI Elements (11-14pt)
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

  // Caption - Meta Information (10-12pt)
  static const TextStyle captionLarge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
    height: 1.33,
  );

  static const TextStyle captionSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3,
    height: 1.25,
  );
}

// ─────────────────────────────────────────────────────────────────────────
// SPACING - REFINED 8px Grid System with Perfect Consistency
// ─────────────────────────────────────────────────────────────────────────
class AppSpacing {
  // Base Spacing Units
  static const double xs = 4;    // 4px - Ultra-tight spacing (rarely used)
  static const double sm = 8;    // 8px - Tight spacing
  static const double md = 12;   // 12px - Compact spacing
  static const double lg = 16;   // 16px - Standard spacing (MOST COMMON)
  static const double xl = 24;   // 24px - Large spacing
  static const double xxl = 32;  // 32px - Extra large spacing
  static const double xxxl = 48; // 48px - Massive spacing (sections)

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // UNIFORM PADDING - All edges equal
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const EdgeInsets paddingXs = EdgeInsets.all(4);
  static const EdgeInsets paddingSm = EdgeInsets.all(8);
  static const EdgeInsets paddingMd = EdgeInsets.all(12);
  static const EdgeInsets paddingLg = EdgeInsets.all(16);
  static const EdgeInsets paddingXl = EdgeInsets.all(24);
  static const EdgeInsets paddingXxl = EdgeInsets.all(32);

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // VERTICAL PADDING - Consistent top & bottom
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const EdgeInsets paddingVerticalSm = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets paddingVerticalMd = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets paddingVerticalLg = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets paddingVerticalXl = EdgeInsets.symmetric(vertical: 24);
  static const EdgeInsets paddingVerticalXxl = EdgeInsets.symmetric(vertical: 32);

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // HORIZONTAL PADDING - Consistent left & right (screen edge padding)
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const EdgeInsets paddingHorizontalSm = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets paddingHorizontalMd = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets paddingHorizontalLg = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets paddingHorizontalXl = EdgeInsets.symmetric(horizontal: 24);

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // CONTAINER PADDING - Card, List Item, Content Areas
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const EdgeInsets containerPaddingSm = EdgeInsets.all(8);   // Tight containers
  static const EdgeInsets containerPaddingMd = EdgeInsets.all(12);  // Compact
  static const EdgeInsets containerPaddingLg = EdgeInsets.all(16);  // Standard (MOST USED)
  static const EdgeInsets containerPaddingXl = EdgeInsets.all(24);  // Spacious

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // LIST ITEM SPACING - Between list items for breathing room
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const EdgeInsets listItemSeparation = EdgeInsets.only(bottom: 12);  // 12px gap
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: 16,  // Screen edge padding
    vertical: 12,    // Top & bottom breathing room
  );

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // SECTION SPACING - Between different content sections
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const double sectionVerticalSm = 16;   // Small gap between sections
  static const double sectionVerticalLg = 24;   // Large gap between sections
  static const double sectionVerticalXl = 32;   // Extra large gap

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // ELEMENT SPACING - Inside containers (icon+text, etc)
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  static const double iconTextSpacing = 12;     // Icon to text spacing
  static const double titleContentSpacing = 8;  // Title to content spacing
}

// ─────────────────────────────────────────────────────────────────────────
// BORDER RADIUS - Consistent Rounding
// ─────────────────────────────────────────────────────────────────────────
class AppRadius {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double circle = 999;

  // BorderRadius Constants
  static const BorderRadius radiusXs = BorderRadius.all(Radius.circular(4));
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(8));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(12));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(16));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(24));
  static const BorderRadius radiusCircle = BorderRadius.all(Radius.circular(999));

  // Common Shapes
  static const RoundedRectangleBorder shapeRounded = RoundedRectangleBorder(
    borderRadius: radiusLg,
  );

  static const RoundedRectangleBorder shapeSmall = RoundedRectangleBorder(
    borderRadius: radiusSm,
  );
}

// ─────────────────────────────────────────────────────────────────────────
// SHADOWS - Premium Depth System
// ─────────────────────────────────────────────────────────────────────────
class AppShadows {
  // Subtle Shadow
  static const BoxShadow shadowSm = BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 4,
    offset: Offset(0, 2),
  );

  // Normal Shadow
  static const BoxShadow shadowMd = BoxShadow(
    color: Color(0x24000000),
    blurRadius: 8,
    offset: Offset(0, 4),
  );

  // Prominent Shadow
  static const BoxShadow shadowLg = BoxShadow(
    color: Color(0x33000000),
    blurRadius: 16,
    offset: Offset(0, 8),
  );

  // Heavy Shadow
  static const List<BoxShadow> shadowXl = [
    BoxShadow(
      color: Color(0x40000000),
      blurRadius: 24,
      offset: Offset(0, 12),
    )
  ];

  // Floating Card Shadow
  static const List<BoxShadow> shadowCard = [
    BoxShadow(
      color: Color(0x1F000000),
      blurRadius: 12,
      offset: Offset(0, 4),
    )
  ];

  // Elevation Shadow (for FAB)
  static const List<BoxShadow> shadowElevation = [
    BoxShadow(
      color: Color(0x2D000000),
      blurRadius: 20,
      offset: Offset(0, 8),
    )
  ];
}

// ─────────────────────────────────────────────────────────────────────────
// DURATIONS - Animation Timing
// ─────────────────────────────────────────────────────────────────────────
class AppDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);
}

// ─────────────────────────────────────────────────────────────────────────
// CURVES - Animation Curves
// ─────────────────────────────────────────────────────────────────────────
class AppCurves {
  static const Curve easeInOutSmooth = Curves.easeInOutCubic;
  static const Curve easeOutSmooth = Curves.easeOutCubic;
  static const Curve easeInSmooth = Curves.easeInCubic;
  static const Curve bounce = Curves.elasticOut;
}

// ═══════════════════════════════════════════════════════════════════════════
// DARK THEME - OLED Optimized
// ═══════════════════════════════════════════════════════════════════════════
ThemeData createDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBg,
    primaryColor: AppColors.primaryGreen,
    
    // App Bar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTypography.headlineMedium.copyWith(
        color: AppColors.textLight,
        fontWeight: FontWeight.w700,
      ),
      iconTheme: const IconThemeData(color: AppColors.textLight),
    ),

    // Bottom Navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: AppColors.primaryGreen,
      unselectedItemColor: AppColors.textTertiary,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),

    // FAB
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.radiusLg,
      ),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: AppColors.darkCard,
      elevation: 0,
      shape: AppRadius.shapeRounded,
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        shape: AppRadius.shapeRounded,
        elevation: 4,
        shadowColor: AppColors.primaryGreen.withOpacity(0.3),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryGreen,
        side: const BorderSide(color: AppColors.primaryGreen, width: 1.5),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        shape: AppRadius.shapeRounded,
      ),
    ),

    // Text Field
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkElevated,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      border: OutlineInputBorder(
        borderRadius: AppRadius.radiusLg,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.radiusLg,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.radiusLg,
        borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2),
      ),
      hintStyle: AppTypography.bodyMedium.copyWith(
        color: AppColors.textTertiary,
      ),
    ),

    // List Tile
    listTileTheme: ListTileThemeData(
      textColor: AppColors.textLight,
      iconColor: AppColors.primaryGreen,
      shape: AppRadius.shapeRounded,
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.darkElevated,
      thickness: 1,
      space: 16,
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: AppTypography.displayLarge.copyWith(color: AppColors.textLight),
      displayMedium: AppTypography.displayMedium.copyWith(color: AppColors.textLight),
      displaySmall: AppTypography.displaySmall.copyWith(color: AppColors.textLight),
      headlineLarge: AppTypography.headlineLarge.copyWith(color: AppColors.textLight),
      headlineMedium: AppTypography.headlineMedium.copyWith(color: AppColors.textLight),
      headlineSmall: AppTypography.headlineSmall.copyWith(color: AppColors.textLight),
      titleLarge: AppTypography.titleLarge.copyWith(color: AppColors.textLight),
      titleMedium: AppTypography.titleMedium.copyWith(color: AppColors.textLight),
      titleSmall: AppTypography.titleSmall.copyWith(color: AppColors.textLight),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: AppColors.textLight),
      bodyMedium: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary),
      bodySmall: AppTypography.bodySmall.copyWith(color: AppColors.textTertiary),
      labelLarge: AppTypography.labelLarge.copyWith(color: AppColors.textLight),
      labelMedium: AppTypography.labelMedium.copyWith(color: AppColors.textSecondary),
      labelSmall: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary),
    ),

    // Color Scheme
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryGreen,
      secondary: AppColors.accentPink,
      tertiary: AppColors.accentCyan,
      background: AppColors.darkBg,
      surface: AppColors.darkSurface,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: AppColors.textLight,
      onSurface: AppColors.textLight,
      onError: Colors.white,
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// PREMIUM COLORS ALIAS - استخدام سهل
// ═══════════════════════════════════════════════════════════════════════════
class PremiumColors {
  // Background colors
  static const Color bg0 = AppColors.darkBg;
  static const Color bg1 = AppColors.darkSurface;
  static const Color bg2 = AppColors.darkCard;
  static const Color bg3 = AppColors.darkElevated;

  // Accent colors
  static const Color accentCyan = AppColors.accentCyan;
  static const Color accentPink = AppColors.accentPink;
  static const Color accentPurple = AppColors.accentPurple;
  static const Color accentGreen = AppColors.primaryGreen;

  // Text colors
  static const Color textPrimary = AppColors.textLight;
  static const Color textSecondary = AppColors.textSecondary;
  static const Color textTertiary = AppColors.textTertiary;

  // Status colors
  static const Color success = AppColors.success;
  static const Color warning = AppColors.warning;
  static const Color error = AppColors.error;
  static const Color info = AppColors.info;
}

// ═══════════════════════════════════════════════════════════════════════════
// LIGHT THEME
// ═══════════════════════════════════════════════════════════════════════════
ThemeData createLightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBg,
    primaryColor: AppColors.primaryGreen,
    
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightSurface,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTypography.headlineMedium.copyWith(
        color: AppColors.textDark,
      ),
      iconTheme: const IconThemeData(color: AppColors.textDark),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightSurface,
      selectedItemColor: AppColors.primaryGreen,
      unselectedItemColor: AppColors.textDarkTertiary,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),

    cardTheme: CardThemeData(
      color: AppColors.lightCard,
      elevation: 0,
      shape: AppRadius.shapeRounded,
    ),

    textTheme: TextTheme(
      displayLarge: AppTypography.displayLarge.copyWith(color: AppColors.textDark),
      displayMedium: AppTypography.displayMedium.copyWith(color: AppColors.textDark),
      displaySmall: AppTypography.displaySmall.copyWith(color: AppColors.textDark),
      headlineLarge: AppTypography.headlineLarge.copyWith(color: AppColors.textDark),
      headlineMedium: AppTypography.headlineMedium.copyWith(color: AppColors.textDark),
      headlineSmall: AppTypography.headlineSmall.copyWith(color: AppColors.textDark),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: AppColors.textDark),
      bodyMedium: AppTypography.bodyMedium.copyWith(color: AppColors.textDarkSecondary),
      bodySmall: AppTypography.bodySmall.copyWith(color: AppColors.textDarkTertiary),
    ),

    colorScheme: ColorScheme.light(
      primary: AppColors.primaryGreen,
      secondary: AppColors.accentPink,
      tertiary: AppColors.accentCyan,
      background: AppColors.lightBg,
      surface: AppColors.lightSurface,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: AppColors.textDark,
      onSurface: AppColors.textDark,
      onError: Colors.white,
    ),
  );
}