import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_mode_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  static const storageKey = 'theme_mode';

  final preferences = SharedPreferencesAsync();

  @override
  ThemeMode build() {
    unawaited(loadSavedTheme());
    return ThemeMode.system;
  }

  Future<void> loadSavedTheme() async {
    final savedTheme = await preferences.getString(storageKey);

    if (savedTheme == ThemeMode.light.name) {
      state = ThemeMode.light;
    } else if (savedTheme == ThemeMode.dark.name) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.system;
    }
  }

  void changeTheme(ThemeMode newTheme) {
    state = newTheme;

    unawaited(
      preferences.setString(
        storageKey,
        newTheme.name,
      ),
    );
  }
}