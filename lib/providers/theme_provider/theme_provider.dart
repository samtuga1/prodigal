import 'package:flutter/material.dart';
import 'package:prodigal/injection/injection.dart';
import 'package:prodigal/services/local_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme_provider.g.dart';

@riverpod
class ThemeProvider extends _$ThemeProvider {
  @override
  ThemeMode build() {
    setThemeFromSharePreference();
    return ThemeMode.system;
  }

  void setThemeFromSharePreference() async {
    // get theme from shared preferences
    String themeVal = await sl<LocalStorage>().getString('theme') ?? ThemeMode.system.name;

    state = ThemeMode.values.byName(themeVal);
  }

  void toggleTheme(ThemeMode theme) async {
    state = theme;
    sl<LocalStorage>().setString('theme', state.name);
  }
}
