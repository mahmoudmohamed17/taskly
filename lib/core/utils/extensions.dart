import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension StringExtension on String {
  /// Capitalizes first letter of the string
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalizes first letter of each word
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Reverses the string
  String reverse() {
    return split('').reversed.join();
  }

  /// Checks if string is a valid email
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Checks if string is a valid phone number
  bool get isValidPhone {
    final phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
    return phoneRegex.hasMatch(this);
  }

  /// Checks if string is a valid URL
  bool get isValidUrl {
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    return urlRegex.hasMatch(this);
  }

  /// Removes all whitespace from string
  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Truncates string to specified length with ellipsis
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }
}

extension ContextExtension on BuildContext {
  /// Returns MediaQuery size
  Size get screenSize => MediaQuery.of(this).size;

  /// Returns screen width
  double get screenWidth => screenSize.width;

  /// Returns screen height
  double get screenHeight => screenSize.height;

  /// Returns current theme
  ThemeData get theme => Theme.of(this);

  /// Returns text theme
  TextTheme get textTheme => theme.textTheme;

  /// Returns color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Returns if keyboard is visible
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  /// Hides keyboard
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  /// Hides current snackbar
  void hideCurrentSnackBar() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }

  /// Opens drawer
  void openDrawer() {
    Scaffold.of(this).openDrawer();
  }

  /// Closes drawer
  void closeDrawer() {
    Scaffold.of(this).closeDrawer();
  }

  /// Current Locale
  Locale get currentLocale => Localizations.localeOf(this);

  /// Checks if current theme is dark
  bool get isDarkMode => theme.brightness == Brightness.dark;
}

extension LocaleContext on BuildContext {
  void cycleLocale() {
    final locales = supportedLocales;
    final nextIndex = (locales.indexOf(locale) + 1) % locales.length;
    setLocale(locales[nextIndex]);
  }
}

extension Spaces on double {
  SizedBox get verticalSpace => SizedBox(height: h);

  SizedBox get horizontalSpace => SizedBox(width: w);
}

extension DateFormatter on DateTime {
  /// e.g. "Fri, Oct 30, 3:45 PM" (localized order and digits)
  String timeWithDate({String? locale}) {
    return DateFormat.MMMEd(locale).add_jm().format(toLocal());
  }

  /// Use this if you want the timezone shown too
  String timeWithDateAndZone({String? locale}) {
    return DateFormat.MMMEd(locale).add_jmz().format(toLocal());
  }
}
