import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  int themeMode = 0;

  ThemeMode getThemeMode() {
    if (themeMode == 1) {
      return ThemeMode.light;
    } else if (themeMode == 2) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  void changeTheme(int type) {
    themeMode = type;
    notifyListeners();
  }
}
