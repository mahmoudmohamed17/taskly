import 'package:flutter/material.dart';

/// Raw palette + Material 3 [ColorScheme]s for the modern Blue/Purple theme.
///
/// Rule of thumb: widgets should read colors from `Theme.of(context)`
/// (`colorScheme`) or `context.appColors` — never from this class directly.
/// The raw constants exist so the theme layer has one source of truth.
abstract final class AppColors {
  // ── Brand ────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF2563EB); // Royal Blue
  static const Color secondary = Color(0xFF7C3AED); // Royal Purple / Violet
  static const Color tertiary = Color(0xFF0284C7); // Sky Blue

  // ── Gradients ────────────────────────────────────────────────────────────
  /// Gradient sampled from the app logo (Sky Blue to Royal Blue).
  static const LinearGradient logoGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF70C1FF), // Azure / Sky Blue (top)
      Color(0xFF2B8AFF), // Royal Blue (bottom)
    ],
  );

  /// Brand gradient blending the logo blue with vibrant purple.
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF60A5FA), // Light Blue
      Color(0xFF2563EB), // Royal Blue
      Color(0xFF7C3AED), // Vivid Purple
    ],
  );

  // ── Light neutrals ───────────────────────────────────────────────────────
  static const Color canvas = Color(0xFFF8FAFC); // Slate 50
  static const Color card = Color(0xFFFFFFFF);
  static const Color fieldFill = Color(0xFFF1F5F9); // Slate 100
  static const Color border = Color(0xFFE2E8F0); // Slate 200
  static const Color onSurface = Color(0xFF0F172A); // Slate 900
  static const Color onSurfaceVariant = Color(0xFF475569); // Slate 600
  static const Color outline = Color(0xFF94A3B8); // Slate 400

  // ── Dark neutrals ────────────────────────────────────────────────────────
  static const Color darkBg = Color(0xFF0F172A); // Deep Obsidian
  static const Color darkSurface = Color(0xFF1E293B); // cards
  static const Color darkOverlay = Color(0xFF334155); // dialogs / sheets
  static const Color darkBorder = Color(0xFF334155);

  /// Modal scrim: rgba(15, 23, 42, 0.45)
  static const Color scrim = Color(0x730F172A);

  // ── Material 3 color schemes ─────────────────────────────────────────────
  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFDBEAFE),
    onPrimaryContainer: Color(0xFF1E3A8A),
    secondary: secondary,
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFEDE9FE),
    onSecondaryContainer: Color(0xFF3B0764),
    tertiary: tertiary,
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFE0F2FE),
    onTertiaryContainer: Color(0xFF075985),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF93000A),
    surface: canvas,
    onSurface: onSurface,
    onSurfaceVariant: onSurfaceVariant,
    surfaceDim: Color(0xFFE2E8F0),
    surfaceBright: canvas,
    surfaceContainerLowest: card,
    surfaceContainerLow: fieldFill,
    surfaceContainer: Color(0xFFF1F5F9),
    surfaceContainerHigh: Color(0xFFE2E8F0),
    surfaceContainerHighest: Color(0xFFCBD5E1),
    outline: outline,
    outlineVariant: border,
    shadow: Color(0xFF0F172A),
    scrim: Color(0xFF0F172A),
    inverseSurface: Color(0xFF1E293B),
    onInverseSurface: Color(0xFFF8FAFC),
    inversePrimary: Color(0xFF93C5FD),
    surfaceTint: Colors.transparent, // no M3 tint overlay on elevation
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF60A5FA),
    onPrimary: Color(0xFF001B3E),
    primaryContainer: Color(0xFF1D4ED8),
    onPrimaryContainer: Color(0xFFDBEAFE),
    secondary: Color(0xFFA78BFA),
    onSecondary: Color(0xFF2E1065),
    secondaryContainer: Color(0xFF5B21B6),
    onSecondaryContainer: Color(0xFFEDE9FE),
    tertiary: Color(0xFF38BDF8),
    onTertiary: Color(0xFF082F49),
    tertiaryContainer: Color(0xFF0369A1),
    onTertiaryContainer: Color(0xFFE0F2FE),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: darkBg,
    onSurface: Color(0xFFE2E8F0),
    onSurfaceVariant: Color(0xFFAAB8CC),
    surfaceDim: Color(0xFF0B1120),
    surfaceBright: Color(0xFF283548),
    surfaceContainerLowest: Color(0xFF0B1120),
    surfaceContainerLow: Color(0xFF172033),
    surfaceContainer: darkSurface,
    surfaceContainerHigh: Color(0xFF2A3647),
    surfaceContainerHighest: darkOverlay,
    outline: Color(0xFF7C8A9E),
    outlineVariant: darkBorder,
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFE2E8F0),
    onInverseSurface: darkBg,
    inversePrimary: primary,
    surfaceTint: Colors.transparent,
  );
}

/// Colors for one memory category.
///
/// * [base]   – saturated color: dots, icons, selected-chip fill (white text).
/// * [tint]   – 12 % (light) / 20 % (dark) container background.
/// * [onTint] – text/icon color that stays AA-readable on top of [tint].
@immutable
class AppCategoryColors {
  const AppCategoryColors({
    required this.base,
    required this.tint,
    required this.onTint,
  });

  final Color base;
  final Color tint;
  final Color onTint;

  static const AppCategoryColors medical = AppCategoryColors(
    base: Color(0xFF0D9488),
    tint: Color(0x1F0D9488),
    onTint: Color(0xFF0F766E),
  );

  static const AppCategoryColors financial = AppCategoryColors(
    base: Color(0xFFB45309),
    tint: Color(0x1FB45309),
    onTint: Color(0xFF92400E),
  );

  static const AppCategoryColors family = AppCategoryColors(
    base: Color(0xFFC2410C),
    tint: Color(0x1FC2410C),
    onTint: Color(0xFF9A3412),
  );

  static const AppCategoryColors friends = AppCategoryColors(
    base: Color(0xFF4F46E5),
    tint: Color(0x1F4F46E5),
    onTint: Color(0xFF4F46E5),
  );

  static const AppCategoryColors personal = AppCategoryColors(
    base: Color(0xFF7C3AED),
    tint: Color(0x1F7C3AED),
    onTint: Color(0xFF7C3AED),
  );

  static const AppCategoryColors other = AppCategoryColors(
    base: Color(0xFF64748B),
    tint: Color(0x1F64748B),
    onTint: Color(0xFF475569),
  );
}

/// Status colors (success / warning / info / danger).
///
/// * [main]        – icons, fills, borders (not guaranteed AA as small text).
/// * [text]        – AA-safe color for text on the page background.
/// * [container]   – soft banner / snackbar background.
/// * [onContainer] – text on [container].
@immutable
class AppStatusColors {
  const AppStatusColors({
    required this.main,
    required this.text,
    required this.container,
    required this.onContainer,
  });

  final Color main;
  final Color text;
  final Color container;
  final Color onContainer;
}

/// App-specific tokens that Material's [ColorScheme] has no slot for.
/// Access with `context.appColors`.
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({
    required this.success,
    required this.warning,
    required this.info,
    required this.danger,
    required this.overlaySurface,
    required this.voiceProcessingTrack,
  });

  final AppStatusColors success;
  final AppStatusColors warning;
  final AppStatusColors info;

  /// Voice "no match" / destructive emphasis (#DC2626 family).
  final AppStatusColors danger;

  /// Dialogs and bottom sheets.
  final Color overlaySurface;

  /// Amber track that rotates around the mic button while processing.
  final Color voiceProcessingTrack;

  static const AppSemanticColors light = AppSemanticColors(
    success: AppStatusColors(
      main: Color(0xFF15803D),
      text: Color(0xFF15803D),
      container: Color(0xFFDCFCE7),
      onContainer: Color(0xFF14532D),
    ),
    warning: AppStatusColors(
      main: Color(0xFFD97706),
      text: Color(0xFF92400E),
      container: Color(0xFFFEF3C7),
      onContainer: Color(0xFF78350F),
    ),
    info: AppStatusColors(
      main: Color(0xFF0284C7),
      text: Color(0xFF0369A1),
      container: Color(0xFFE0F2FE),
      onContainer: Color(0xFF0C4A6E),
    ),
    danger: AppStatusColors(
      main: Color(0xFFDC2626),
      text: Color(0xFFB91C1C),
      container: Color(0xFFFEE2E2),
      onContainer: Color(0xFF7F1D1D),
    ),
    overlaySurface: AppColors.card,
    voiceProcessingTrack: Color(0xFFF59E0B),
  );

  static const AppSemanticColors dark = AppSemanticColors(
    success: AppStatusColors(
      main: Color(0xFF4ADE80),
      text: Color(0xFF4ADE80),
      container: Color(0xFF0F3320),
      onContainer: Color(0xFFBBF7D0),
    ),
    warning: AppStatusColors(
      main: Color(0xFFFBBF24),
      text: Color(0xFFFCD34D),
      container: Color(0xFF3A2A08),
      onContainer: Color(0xFFFDE68A),
    ),
    info: AppStatusColors(
      main: Color(0xFF38BDF8),
      text: Color(0xFF7DD3FC),
      container: Color(0xFF0C2D44),
      onContainer: Color(0xFFBAE6FD),
    ),
    danger: AppStatusColors(
      main: Color(0xFFF87171),
      text: Color(0xFFFCA5A5),
      container: Color(0xFF3F1414),
      onContainer: Color(0xFFFECACA),
    ),
    overlaySurface: AppColors.darkOverlay,
    voiceProcessingTrack: Color(0xFFFBBF24),
  );

  @override
  AppSemanticColors copyWith({
    AppStatusColors? success,
    AppStatusColors? warning,
    AppStatusColors? info,
    AppStatusColors? danger,
    Color? overlaySurface,
    Color? voiceProcessingTrack,
  }) {
    return AppSemanticColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      danger: danger ?? this.danger,
      overlaySurface: overlaySurface ?? this.overlaySurface,
      voiceProcessingTrack: voiceProcessingTrack ?? this.voiceProcessingTrack,
    );
  }

  /// Theme switches snap at the midpoint; token groups are not interpolated.
  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return t < 0.5 ? this : other;
  }
}

/// Colors for one memory attachment file.
/// * [base] – saturated color: dots, icons, selected-chip fill (white text).
/// * [tint] – 12 % (light) / 20 % (dark) container background.
@immutable
class MemoryFileColor {
  final Color base;
  final Color tint;

  const MemoryFileColor({
    required this.base,
    required this.tint,
  });

  static const MemoryFileColor pdf = MemoryFileColor(
    base: Color(0xFFDC2626), // Crimson Red
    tint: Color(0xFFFEE2E2), // Soft Rose
  );

  static const MemoryFileColor image = MemoryFileColor(
    base: Color(0xFF059669), // Emerald Green
    tint: Color(0xFFD1FAE5), // Soft Mint
  );

  static const MemoryFileColor docx = MemoryFileColor(
    base: Color(0xFF2563EB), // Royal / Word Blue
    tint: Color(0xFFDBEAFE), // Soft Blue
  );

  static const MemoryFileColor video = MemoryFileColor(
    base: Color(0xFF7C3AED), // Rich Purple / Violet
    tint: Color(0xFFEDE9FE), // Soft Lavender
  );

  static const MemoryFileColor audio = MemoryFileColor(
    base: Color(0xFFD97706), // Warm Amber
    tint: Color(0xFFFEF3C7), // Soft Amber
  );
}

extension AppColorsContext on BuildContext {
  /// Semantic + category colors for the current theme.
  AppSemanticColors get appColors => Theme.of(this).extension<AppSemanticColors>() ?? AppSemanticColors.light;
}
