import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class ThemeCubit extends HydratedCubit<ThemeMode> {
  new() : super(ThemeMode.light);

  static const String isDarkMode = 'is_dark';

  void toggle() {
    final isDark = state == ThemeMode.dark;
    emit(isDark ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final isDark = json[isDarkMode] as bool?;
    return isDark == true ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {isDarkMode: state == ThemeMode.dark};
  }
}
