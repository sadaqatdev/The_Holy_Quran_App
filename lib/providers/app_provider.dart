import 'package:al_quran/utils/hiveutils.dart';
import 'package:flutter/material.dart';

final themeMap = {
  "dark": ThemeMode.dark,
  "light": ThemeMode.light,
};

class AppProvider extends ChangeNotifier {
  int _first = 0;

  // var _cache;

  int get checkVisit => _first;

  Future<bool> init() async {
    var _cache = await opedHive('app');
    int? visit = _cache!.get('visit');
    if (visit == null || visit == 0) {
      _cache.put('visit', 1);
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
    var _cache = await opedHive('app');
    String? stringTheme = _cache?.get('theme');

    ThemeMode? theme =
        stringTheme == null ? ThemeMode.light : themeMap[stringTheme];

    if (theme == null) {
      _cache!.put(
        'theme',
        ThemeMode.light.toString().split(".").last,
      );
      _themeMode = ThemeMode.light;
    }
    _themeMode = theme;

    notifyListeners();
  }

  Future<void> setTheme(ThemeMode newTheme) async {
    var _cache = await opedHive('app');
    if (_themeMode == newTheme) {
      return;
    }
    _themeMode = newTheme;

    _cache?.put(
      'theme',
      newTheme.toString().split('.').last,
    );
    notifyListeners();
  }
}
