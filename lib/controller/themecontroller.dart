import 'package:aventus/constants/constants.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppThemes.lightTheme;

  ThemeData get currentTheme => _currentTheme;

  void switchTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}
