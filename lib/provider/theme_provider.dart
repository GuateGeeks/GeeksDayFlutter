import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    primaryColor: Colors.black,
    backgroundColor: Color.fromRGBO(0, 0, 0, 0),
    accentColor: Colors.white,
  );

  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(color: Colors.blue),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    primaryColor: Colors.white,
    backgroundColor: Color.fromRGBO(235, 235, 235, .6),
    accentColor: Colors.grey,
  );
}
