import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darkTheme = false;
  //key to access the system preferences and know if the dark theme is active or not
  String keyPreferences = "darkmode";

  ThemeProvider(){
    _darkTheme = false;
    _loadFromPrefs();
  }
  
  bool get darkTheme => _darkTheme;

  //function to change the theme of the application and save it in the preferences
  toogleTheme(){
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  //bring the boolean value from the preferences, to know if the dark theme is active or not
 _loadFromPrefs() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   _darkTheme = prefs.getBool(keyPreferences) ?? true;
   notifyListeners();
 }

  //save in preferences if the dark theme is active or not
 _saveToPrefs() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setBool(keyPreferences, _darkTheme);
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
      //likes and comments
      subtitle1: TextStyle(
        fontSize: 16.5,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
      //Fecha
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
      //text style Sing up and login
      overline: TextStyle(
        fontSize: 30.0,
        color: Colors.white,
        fontWeight: FontWeight.w600
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
    //DropdownButton color (admin)
    selectedRowColor: Colors.white10,
    //Style textbutton singup
    textButtonTheme: TextButtonThemeData(  
      style: TextButton.styleFrom(
        primary: Colors.white,
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      )
    ),
    accentColor: Colors.white, 
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
        color: Colors.black,
      ),
      //Numeros perfil de usuario
      caption: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      ),
      //text style Sing up and login
      overline: TextStyle(
        fontSize: 30.0,
        color: Colors.black,
        fontWeight: FontWeight.w600
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
    //DropdownButton color (admin)
    selectedRowColor: Colors.black12,
    //Style textbutton singup
    textButtonTheme: TextButtonThemeData(  
      style: TextButton.styleFrom(
        primary: Colors.black,
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      )
    ),
    accentColor: Colors.black, 
  );
}
