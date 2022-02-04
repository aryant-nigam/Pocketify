import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketify/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie/src/lottie_image_asset.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveToHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Vx.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(children: [
              Lottie.asset("assets/ss.json"),
              Text(
                "Pocketify",
                style: TextStyle(
                    fontFamily: GoogleFonts.bangers().fontFamily,
                    color: Color.fromRGBO(96, 9, 100, 1),
                    fontSize: 45),
              ),
            ]),
            SizedBox(
              height: 40,
              child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                RotateAnimatedText(
                  "Manage your bills",
                  textStyle: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      color: Color.fromRGBO(96, 9, 100, 1),
                      fontSize: 15),
                  duration: Duration(milliseconds: 1200),
                ),
                RotateAnimatedText(
                  "Get expense insights",
                  textStyle: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      color: Color.fromRGBO(96, 9, 100, 1),
                      fontSize: 15),
                  duration: Duration(milliseconds: 1200),
                ),
                RotateAnimatedText(
                  "Make worthy savings",
                  textStyle: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      color: Color.fromRGBO(96, 9, 100, 1),
                      fontSize: 15),
                  duration: Duration(milliseconds: 1200),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  void moveToHomeScreen() async {
    await Future.delayed(Duration(milliseconds: 7200));
    Navigator.pushReplacementNamed(context, Routes.HomeScreenRoute);
  }
}
