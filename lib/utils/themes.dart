import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class AppTheme {
  static final Color FAB_light = Color.fromRGBO(96, 9, 100, 1);
  static final Color FAB_dark = Color.fromRGBO(70, 9, 80,1);
  static final Color progressBase = Vx.purple100;
  static final Color progressMarker = Color.fromRGBO(96, 9, 100, 1);
  static Color cream = Color(0xfff5f5f5);

  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      primaryTextTheme: GoogleFonts.bangersTextTheme(),
      canvasColor: Vx.purple300,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.black,
      ), //Your Accent Color
      cardColor: Color.fromRGBO(96, 9, 100, 1),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Vx.black,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: 17),
          //color: Colors.white,
          toolbarTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: 13),
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black)),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      primaryTextTheme: GoogleFonts.bangersTextTheme(),
      canvasColor: Vx.gray900,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.white,
      ), //Your Accent Color
      cardColor: Color.fromRGBO(96, 9, 100, 1),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Vx.black,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: 17),
          //color: Colors.white,
          toolbarTextStyle: TextStyle(
              color: Colors.black,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontSize: 13),
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black)),
    );
  }
}
