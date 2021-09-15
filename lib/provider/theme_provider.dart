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
    primaryColorDark: Colors.white,
    backgroundColor: Color.fromRGBO(0, 0, 0, 0),
    accentColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.black,
      focusedBorder: OutlineInputBorder(
        borderSide: new BorderSide(
          color: Color(0xff303030),
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: new BorderSide(
          color: Color.fromRGBO(0, 0, 0, 0),
        ),
      ),
    ),
  );

  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(color: Colors.blue),
    scaffoldBackgroundColor: Color.fromRGBO(240, 240, 240, 1),
    colorScheme: ColorScheme.light(),
    primaryColor: Colors.white,
    primaryColorDark: Colors.black,
    backgroundColor: Color.fromRGBO(235, 235, 235, .6),
    accentColor: Colors.grey,
    iconTheme: IconThemeData(color: Colors.grey),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color.fromRGBO(240, 240, 240, 1),
      focusedBorder: OutlineInputBorder(
        borderSide: new BorderSide(
          color: Color.fromRGBO(0, 0, 0, 0),
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: new BorderSide(
          color: Color.fromRGBO(240, 240, 240, 1),
        ),
      ),
    ),
  );
}
