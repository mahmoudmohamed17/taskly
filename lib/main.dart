import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';

import 'core/bootstrap/bootstrap_app.dart';
import 'core/utils/locale_manager.dart';
import 'taskly.dart';

void main() async {
  await bootstrapApp();

  runApp(
    EasyLocalization(
      supportedLocales: LocaleManager.supportedLocales,
      path: LocaleManager.translationPath,
      fallbackLocale: LocaleManager.fallbackLocale,
      startLocale: LocaleManager.initialLocale,
      child: const Taskly(),
    ),
  );
}
