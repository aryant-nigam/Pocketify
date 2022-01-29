import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:pocketify/screens/homescreen.dart';
import 'package:pocketify/screens/splash_screen.dart';
import 'package:pocketify/utils/routes.dart';
import 'package:pocketify/utils/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: AppTheme.darkTheme(context),
      theme: AppTheme.lightTheme(context),
      home: SplashScreen(),
      routes: {
        Routes.HomeScreenRoute : (context){return HomeScreen();}
      },
    );
  }
}
