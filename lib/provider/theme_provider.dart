import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darkTheme = false;
  //key to access the system preferences and know if the dark theme is active or not
  String keyPreferences = "darkmode";

  ThemeProvider() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  bool get darkTheme => _darkTheme;

  //function to change the theme of the application and save it in the preferences
  toogleTheme() {
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
    fontFamily: 'Biryani',
    //Color del AppBar
    appBarTheme: AppBarTheme(
      color: Colors.black54,
      toolbarTextStyle: TextStyle(
        fontFamily: 'Abel',
        color: Colors.white,
        fontWeight: FontWeight.w100,
        fontSize: 24,
      ),
      iconTheme: IconThemeData(
        color: Color(0xFF0E89AF),
      ),
    ),
    //BackgroundColor
    scaffoldBackgroundColor: Color(0xFF2B2B2B),
    // Thema Principal
    colorScheme: ColorScheme.dark(),
    //Estilos de texto
    textTheme: TextTheme(
      //Nombre de usuarios
      headline1: TextStyle(
        height: 1,
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        color: Color(0xFFD6D6D6),
      ),
      //Fecha y likes
      headline2: TextStyle(
        fontSize: 12.0,
        fontFamily: 'assets/fonts/Biryani-Regular.ttf',
        color: Color(0xFF797979),
      ),
      //Post Description
      bodyText1: TextStyle(
        fontFamily: 'EmojiOne',
        fontSize: 12.0,
        fontWeight: FontWeight.w100,
        letterSpacing: 0.7,
        color: Color(0xFFD6D6D6),
      ),
      //Texto pantalla configuracion
      headline4: TextStyle(
        fontSize: 22,
        color: Color(0xFFD6D6D6),
      ),
      //Texto opciones pantalla de configuracion
      headline5: TextStyle(
          color: Color(0xFFD6D6D6), fontSize: 12.0, fontFamily: 'Abel'),
      //Texto Menu y comentarios
      headline6: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      //Estilos Texto Perfil de usuario
      headline3: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF5093FF),
      ),
      //Numeros perfil de usuario
      caption: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Color(0xFFD6D6D6),
      ),
      //text style Sing up and login
      overline: TextStyle(
          fontSize: 25.0,
          color: Color(0xFF4A4A4A),
          fontWeight: FontWeight.w600),
    ),
    //Estilos inputs Crear Post/Quiz
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white),
        fillColor: Color.fromRGBO(74, 74, 74, 0.25)),
    //Color botones like y coment
    buttonColor: Color.fromRGBO(0, 0, 0, 0),
    //Icons Color
    iconTheme: IconThemeData(
      color: Color(0xFFD6D6D6),
    ),
    //DropdownButton color (admin)
    selectedRowColor: Colors.white10,

    primaryColor: Colors.black,
  );

  static final lightTheme = ThemeData(
    fontFamily: 'Biryani',
    //Color del appbar
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      toolbarTextStyle: TextStyle(
        fontFamily: 'Abel',
        color: Colors.black,
        fontWeight: FontWeight.w100,
        fontSize: 24,
      ),
      iconTheme: IconThemeData(
        color: Color(0xFF0E89AF),
      ),
      elevation: 2,
      actionsIconTheme: IconThemeData(
        color: Color(0xFF0E89AF),
      ),
    ),
    //BackgroundColor
    scaffoldBackgroundColor: Colors.white,
    //Estilos de texto
    textTheme: TextTheme(
      //Nombre de usuarios
      headline1: TextStyle(
        height: 1,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Color(0xFF767676),
      ),
      //Fecha y likes
      headline2: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
        color: Color(0xFF797979),
      ),
      //Post Description
      bodyText1: TextStyle(
        fontFamily: 'EmojiOne',
        fontSize: 12.0,
        fontWeight: FontWeight.w100,
        letterSpacing: 0.7,
        color: Color(0xFF767676),
      ),
      //Texto pantalla configuracion
      headline4: TextStyle(
        fontSize: 22,
        color: Color(0xFF767676),
      ),
      //Texto opciones pantalla de configuracion
      headline5: TextStyle(
          color: Color(0xFFD6D6D6), fontSize: 12.0, fontFamily: 'Abel'),
      //Texto Menu y comentarios
      headline6: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      //Estilos Texto Perfil de usuario
      headline3: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF4B3BAB),
      ),
      //Numeros perfil de usuario
      caption: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Color(0xFF9A9C9E),
      ),
      //text style Sing up and login
      overline: TextStyle(
        fontSize: 30.0,
        color: Color(0xFF4A4A4A),
        fontWeight: FontWeight.w600,
      ),
    ),

    //BottomNavbar Style
    backgroundColor: Color(0xFF4A4A4A),
    //Icons Color
    iconTheme: IconThemeData(
      color: Colors.white,
    ),

    //Estilos inputs Crear Post/Quiz
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color.fromRGBO(214, 214, 214, 1),
    ),
    //Color botones like y coment
    buttonColor: Color.fromRGBO(235, 235, 235, .6),

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
    )),
    primaryColor: Color(0xFF4A4A4A),
  );
}
