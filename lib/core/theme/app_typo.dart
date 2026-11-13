import 'package:material_ui/material_ui.dart';

/// Typography for Memory Reminder — IBM Plex Sans Arabic (covers Arabic + Latin).
abstract final class AppTypo {
  /// Must match the `family:` name declared in pubspec.yaml.
  static const String fontFamily = 'IBMPlexSansArabic';

  // ── Scale (size / weight / line-height) ──────────────────────────────────
  /// 32 / 700 / ~46
  static const TextStyle displayLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.45,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// 28 / 600 / ~41
  static const TextStyle displayMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.45,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// 24 / 600 / ~35
  static const TextStyle headline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.45,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// 20 / 600 / ~29 (extra step used by app bars and dialog titles)
  static const TextStyle titleLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.45,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// 18 / 600 / 26 (memory card titles)
  static const TextStyle titleMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.45,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// 16 / 400 / 26 (default reading text)
  static const TextStyle bodyLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.625,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// 14 / 400 / 22
  static const TextStyle bodyMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.57,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// 12 / 500 / 18 (timestamps, file sizes)
  static const TextStyle labelCaption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// 16 / 600 — buttons.
  static const TextStyle labelLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// 14 / 500 — chips, tabs, navigation labels.
  static const TextStyle labelMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0,
    leadingDistribution: TextLeadingDistribution.even,
  );

  /// Material [TextTheme] mapping (colorless — see class docs).
  static const TextTheme textTheme = TextTheme(
    displayLarge: displayLg,
    displayMedium: displayMd,
    displaySmall: headline,
    headlineLarge: headline,
    headlineMedium: titleLg,
    headlineSmall: titleMd,
    titleLarge: titleLg,
    titleMedium: titleMd,
    titleSmall: labelMd,
    bodyLarge: bodyLg,
    bodyMedium: bodyMd,
    bodySmall: labelCaption,
    labelLarge: labelLg,
    labelMedium: labelMd,
    labelSmall: labelCaption,
  );

  /// Equal-width digits so columns of amounts / doses line up.
  /// Use for financial and medication values:
  /// `Text('1,250', style: AppTypo.tabular(AppTypo.bodyLg))`.
  static TextStyle tabular(TextStyle base) => base.copyWith(
    fontFeatures: const [FontFeature.tabularFigures()],
  );
}
