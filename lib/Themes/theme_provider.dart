import 'package:flutter/material.dart';
import 'dark_theme.dart'; // Import your dark mode
import 'light_theme.dart'; // Import your light mode

class ThemeProvider extends ChangeNotifier {
  // Initialize with a default theme (lightMode)
  ThemeData _themeData = lightTheme;

  // Getter for themeData
  ThemeData get themeData => _themeData;

  // Check if the current theme is dark mode
  bool get isDarkMode => _themeData == darkMode;

  // Setter for themeData
  set themeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners(); // Notify listeners of theme changes
  }

  // Function to toggle between light and dark mode
  void toggleTheme() {
    if (_themeData == lightTheme) {
      themeData = darkMode; // Use setter to update theme
    } else {
      themeData = lightTheme; // Use setter to update theme
    }
  }
}
