import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeMap = {
  "dark": ThemeMode.dark,
  "light": ThemeMode.light,
};

class AppProvider extends ChangeNotifier {
  int _first = 0;

  // var _cache;

  SharedPreferences? preferences;
  int get checkVisit => _first;

  Future<bool> init() async {
    preferences = await SharedPreferences.getInstance();
    var visit = preferences?.getInt("visit");

    if (visit == null || visit == 0) {
      preferences?.setInt('visit', 1);
      return true;
    }
    return false;
  }

  void visited() {
    _first = 1;

    notifyListeners();
  }

  ThemeMode? _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode!;
  bool get isDark => _themeMode == ThemeMode.dark;

  Future<void> initTheme() async {
    // var _cache = await opedHive('app');
    preferences = await SharedPreferences.getInstance();
    String? stringTheme = preferences?.getString('theme');

    ThemeMode? theme =
        stringTheme == null ? ThemeMode.light : themeMap[stringTheme];

    if (theme == null) {
      preferences!.setString(
        'theme',
        ThemeMode.light.toString().split(".").last,
      );
      _themeMode = ThemeMode.light;
    }
    _themeMode = theme;

    notifyListeners();
  }

  Future<void> setTheme(ThemeMode newTheme) async {
    // var _cache = await opedHive('app');
    preferences = await SharedPreferences.getInstance();
    if (_themeMode == newTheme) {
      return;
    }
    _themeMode = newTheme;

    preferences?.setString(
      'theme',
      newTheme.toString().split('.').last,
    );
    notifyListeners();
  }
}
