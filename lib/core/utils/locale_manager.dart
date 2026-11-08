import 'dart:ui';

abstract class LocaleManager {
  static const String translationPath = 'assets/translations';

  static List<Locale> get supportedLocales => const [
    Locale('ar'),
    Locale('en'),
  ];

  static Locale get initialLocale => const Locale('en');
  static Locale get fallbackLocale => const Locale('ar');
}
