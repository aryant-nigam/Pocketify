import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pocketify/utils/app_icons.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomToast {
  late FToast fToast;
  late String msg;
  late Color backgroundColor, textColor;
  late BuildContext context;

  CustomToast(
      {required this.context,
      required this.msg,
      required this.backgroundColor,
      required this.textColor}) {
    fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LottieBuilder.asset(
            "assets/done.json",
            height: 45,
            width: 45,
          ),
          SizedBox(
            width: 12.0,
          ),
          AnimatedTextKit(animatedTexts: [
            WavyAnimatedText("${msg}",
                textStyle:
                    TextStyle(color: textColor, fontWeight: FontWeight.w700),
                speed: const Duration(milliseconds: 125))
          ])
        ],
      ),
    );
    showToast(toast);
  }

  showToast(Widget toast) {
    fToast.showToast(
        child: toast,
        toastDuration: Duration(milliseconds: 3200),
        positionedToastBuilder: (context, child) {
          return Positioned(child: child, bottom: 10, left: 10, right: 10);
        });
  }

  FToast create() => fToast;
}
