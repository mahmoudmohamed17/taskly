import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_typo.dart';

/// 4 / 8 pt spacing scale.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  /// Horizontal screen margin (1.25rem).
  static const double screenMargin = 20;
  static const double gutter = 16;

  /// Symmetric, so identical in RTL and LTR.
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: screenMargin);
}

/// Corner radii.
abstract final class AppRadius {
  static const double sm = 4;
  static const double base = 8;
  static const double md = 12; // attachment tiles
  static const double lg = 16; // cards, fields
  static const double dialog = 20;
  static const double xl = 24; // sheets
  static const double pill = 9999;

  static const BorderRadius mdAll = BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgAll = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius dialogAll = BorderRadius.all(Radius.circular(dialog));
  static const BorderRadius pillAll = BorderRadius.all(Radius.circular(pill));
  static const BorderRadius sheetTop = BorderRadius.vertical(
    top: Radius.circular(xl),
  );
}

/// Ambient, teal-tinted shadows. Dark mode uses surface tiers instead,
/// so these return an empty list there.
abstract final class AppShadows {
  static List<BoxShadow> level1(BuildContext context) => _isDark(context)
      ? const []
      : const [
          BoxShadow(
            color: Color(0x0A1D4E5B), // 4 %
            blurRadius: 8,
            spreadRadius: -2,
            offset: Offset(0, 2),
          ),
          BoxShadow(
            color: Color(0x081D4E5B), // 3 %
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ];

  static List<BoxShadow> level2(BuildContext context) => _isDark(context)
      ? const []
      : const [
          BoxShadow(
            color: Color(0x141D4E5B), // 8 %
            blurRadius: 20,
            spreadRadius: -4,
            offset: Offset(0, 4),
          ),
        ];

  /// Voice button and sheets.
  static List<BoxShadow> level3(BuildContext context) => _isDark(context)
      ? const []
      : const [
          BoxShadow(
            color: Color(0x291D4E5B), // 16 %
            blurRadius: 32,
            spreadRadius: -4,
            offset: Offset(0, 8),
          ),
        ];

  static bool _isDark(BuildContext context) => Theme.of(context).brightness == Brightness.dark;
}

/// Motion tokens. Respect `MediaQuery.disableAnimationsOf(context)`
/// by swapping these durations for [Duration.zero].
abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 120); // press feedback
  static const Duration base = Duration(milliseconds: 200); // chips, switches
  static const Duration slow = Duration(milliseconds: 320); // sheets, pages
  static const Duration voicePulse = Duration(milliseconds: 1600);

  static const Curve standard = Curves.easeInOutCubic;
  static const Curve enter = Curves.easeOutCubic;
  static const Curve exit = Curves.easeInCubic;

  /// Organic breathing of the listening rings.
  static const Curve pulse = Curves.easeInOutSine;
}

/// Entry point: `MaterialApp(theme: AppTheme.light, darkTheme: AppTheme.dark)`.
abstract final class AppTheme {
  static ThemeData get light => _build(AppColors.lightScheme, AppSemanticColors.light);

  static ThemeData get dark => _build(AppColors.darkScheme, AppSemanticColors.dark);

  static const double _minTarget = 48;
  static const double _controlHeight = 52;

  static ThemeData _build(ColorScheme scheme, AppSemanticColors semantic) {
    final bool isDark = scheme.brightness == Brightness.dark;

    final TextTheme text = AppTypo.textTheme.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );

    OutlineInputBorder fieldBorder(Color color, {double width = 1}) {
      return OutlineInputBorder(
        borderRadius: AppRadius.lgAll,
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      canvasColor: scheme.surface,
      fontFamily: AppTypo.fontFamily,
      textTheme: text,
      primaryTextTheme: text,
      extensions: <ThemeExtension<dynamic>>[semantic],
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
      splashFactory: InkRipple.splashFactory,
      dividerColor: scheme.outlineVariant,
      iconTheme: IconThemeData(color: scheme.onSurface, size: 24.sp),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),

      // ── App bar ──────────────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: text.titleMedium,
        iconTheme: IconThemeData(color: scheme.onSurface, size: 24.sp),
        systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      ),

      // ── Cards ────────────────────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLowest,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.lgAll,
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),

      // ── Buttons (pill, 52dp tall) ────────────────────────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(88, _controlHeight),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: const StadiumBorder(),
          textStyle: text.labelLarge,
          elevation: 0,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(88, _controlHeight),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: const StadiumBorder(),
          textStyle: text.labelLarge,
          iconColor: scheme.onPrimary,
          iconSize: 24.sp,
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(88, _controlHeight),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: const StadiumBorder(),
          textStyle: text.labelLarge,
          iconSize: 24.sp,
          iconColor: scheme.onPrimary,
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.outline),
          shadowColor: Colors.transparent,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(64, _minTarget),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: const StadiumBorder(),
          textStyle: text.labelLarge,
          iconSize: 24.sp,
          foregroundColor: scheme.primary,
          shadowColor: Colors.transparent,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(_minTarget, _minTarget),
          foregroundColor: scheme.onSurface,
        ),
      ),

      // ── Text fields ──────────────────────────────────────────────────────
      // The enabled border uses `outline` (>= 3:1), not the pale card border,
      // so fields stay visible for older users (WCAG 1.4.11).
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLow,
        isDense: false,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 13,
        ),
        constraints: const BoxConstraints(minHeight: _controlHeight),
        labelStyle: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
        floatingLabelStyle: text.bodyMedium?.copyWith(color: scheme.primary),
        hintStyle: text.bodyLarge?.copyWith(color: scheme.onSurface.withValues(alpha: 0.50)),
        helperStyle: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        errorStyle: text.bodySmall?.copyWith(color: scheme.error),
        errorMaxLines: 3,
        prefixIconColor: scheme.onSurfaceVariant,
        suffixIconColor: scheme.onSurfaceVariant,
        border: fieldBorder(scheme.outline.withValues(alpha: 0.50)),
        enabledBorder: fieldBorder(scheme.outline.withValues(alpha: 0.50)),
        focusedBorder: fieldBorder(scheme.primary, width: 2),
        errorBorder: fieldBorder(scheme.error),
        focusedErrorBorder: fieldBorder(scheme.error, width: 2),
        disabledBorder: fieldBorder(scheme.outlineVariant),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: scheme.primary,
        selectionColor: scheme.primary.withAlpha(77), // ~30 %
        selectionHandleColor: scheme.primary,
      ),

      // ── Search bar (pill) ────────────────────────────────────────────────
      searchBarTheme: SearchBarThemeData(
        elevation: const WidgetStatePropertyAll<double>(0),
        backgroundColor: WidgetStatePropertyAll<Color>(scheme.surfaceContainerLow),
        surfaceTintColor: const WidgetStatePropertyAll<Color>(Colors.transparent),
        constraints: const BoxConstraints(minHeight: _controlHeight),
        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(horizontal: 16),
        ),
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          StadiumBorder(side: BorderSide(color: scheme.outline)),
        ),
        textStyle: WidgetStatePropertyAll<TextStyle?>(text.bodyLarge),
        hintStyle: WidgetStatePropertyAll<TextStyle?>(
          text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ),

      // ── Chips (36dp pill; tap target stays 48dp via MaterialTapTargetSize) ─
      chipTheme: ChipThemeData(
        shape: StadiumBorder(side: BorderSide(color: scheme.outlineVariant)),
        side: BorderSide(color: scheme.outlineVariant),
        backgroundColor: scheme.surface,
        selectedColor: scheme.primaryContainer,
        checkmarkColor: scheme.onPrimaryContainer,
        labelStyle: text.labelMedium,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        elevation: 0,
        pressElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),

      // ── Bottom sheet ─────────────────────────────────────────────────────
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: semantic.overlaySurface,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: semantic.overlaySurface,
        modalBarrierColor: AppColors.scrim,
        elevation: 0,
        modalElevation: 0,
        showDragHandle: true,
        dragHandleSize: const Size(48, 5),
        dragHandleColor: scheme.outline,
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.sheetTop),
      ),

      // ── Dialogs ──────────────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: semantic.overlaySurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        barrierColor: AppColors.scrim,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        actionsPadding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 16),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.dialogAll),
        titleTextStyle: text.titleLarge,
        contentTextStyle: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
      ),

      // ── Snackbar ─────────────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        actionTextColor: scheme.inversePrimary,
        disabledActionTextColor: scheme.onInverseSurface.withAlpha(97),
        contentTextStyle: text.bodyMedium?.copyWith(color: scheme.onInverseSurface),
        insetPadding: const EdgeInsets.all(AppSpacing.screenMargin),
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
      ),

      // ── Bottom navigation (64dp) ─────────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        height: 64,
        elevation: 0,
        backgroundColor: scheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        indicatorColor: scheme.primaryContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>(
          (Set<WidgetState> states) => text.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected) ? scheme.onSurface : scheme.onSurfaceVariant,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>(
          (Set<WidgetState> states) => IconThemeData(
            size: 24,
            color: states.contains(WidgetState.selected) ? scheme.onPrimaryContainer : scheme.onSurfaceVariant,
          ),
        ),
      ),

      // ── Switch ───────────────────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return scheme.onSurface.withAlpha(97);
            }
            return states.contains(WidgetState.selected) ? scheme.onPrimary : scheme.outline;
          },
        ),
        trackColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return scheme.onSurface.withAlpha(31);
            }
            return states.contains(WidgetState.selected) ? scheme.primary : scheme.surfaceContainerHighest;
          },
        ),
        trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) => states.contains(WidgetState.selected) ? Colors.transparent : scheme.outline,
        ),
      ),

      // ── List tiles (settings, activity log) ──────────────────────────────
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        minVerticalPadding: 12,
        minTileHeight: 56,
        iconColor: scheme.onSurface,
        textColor: scheme.onSurface,
        titleTextStyle: text.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        subtitleTextStyle: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
      ),

      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      badgeTheme: BadgeThemeData(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: text.labelSmall,
        backgroundColor: scheme.primary,
        textColor: scheme.onPrimary,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.surfaceContainerHighest,
        circularTrackColor: scheme.surfaceContainerHighest,
      ),

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: scheme.inverseSurface,
          borderRadius: AppRadius.mdAll,
        ),
        textStyle: text.bodyMedium?.copyWith(color: scheme.onInverseSurface),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        iconSize: 24,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.dialogAll,
        ),
      ),
    );
  }
}
