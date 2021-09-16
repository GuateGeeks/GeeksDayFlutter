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
    //BackgroundColor
    scaffoldBackgroundColor: Colors.grey.shade900,
    // Thema Principal
    colorScheme: ColorScheme.dark(),
    //Estilos de texto
    textTheme: TextTheme(
      //Nombre de usuarios
      headline1: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      //Fecha y likes
      subtitle2: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
      //Post Description
      headline4: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      //Texto del modal Crear Post/Quiz Seleccionado
      headline2: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      //Texto del modal Crear Post/Quiz No Seleccionado
      headline5: TextStyle(
        color: Colors.grey,
        fontSize: 15.0,
      ),
      //Texto Menu y comentarios
      headline6: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      //Estilos Texto Perfil de usuario
      headline3: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
      //Numeros perfil de usuario
      caption: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      ),
    ),
    //Estilos inputs Crear Post/Quiz
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.black,
    ),
    //Color botones like y coment
    buttonColor: Color.fromRGBO(0, 0, 0, 0),
    //Icons Color
    iconTheme: IconThemeData(
      color: Colors.white,
    ),

    // primaryColor: Colors.black,
    // primaryColorDark: Colors.white,
    // backgroundColor: Color.fromRGBO(0, 0, 0, 0),
    // accentColor: Colors.white,
    // iconTheme: IconThemeData(color: Colors.white),
  );

  static final lightTheme = ThemeData(
    //Color del appbar
    appBarTheme: AppBarTheme(color: Colors.blue),
    //BackgroundColor
    scaffoldBackgroundColor: Color.fromRGBO(240, 240, 240, 1),
    // Thema Principal
    colorScheme: ColorScheme.light(),
    //Estilos de texto
    textTheme: TextTheme(
      //Nombre de usuarios
      headline1: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      //Fecha y likes
      subtitle2: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
      //Post Description
      headline4: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      //Texto del modal Crear Post/Quiz Seleccionado
      headline2: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      //Texto del modal Crear Post/Quiz No Seleccionado
      headline5: TextStyle(
        color: Colors.grey,
        fontSize: 15.0,
      ),
      //Texto Menu y comentarios
      headline6: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      //Estilos Texto Perfil de usuario
      headline3: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w800,
        color: Colors.white,
      ),
      //Numeros perfil de usuario
      caption: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      ),
    ),
    //Estilos inputs Crear Post/Quiz
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color.fromRGBO(214, 214, 214, 1),
    ),
    //Color botones like y coment
    buttonColor: Color.fromRGBO(235, 235, 235, .6),
    //Icons Color
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  );
}
