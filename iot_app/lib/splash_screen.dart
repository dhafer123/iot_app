import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/client_screen.dart';
import 'package:iot_app/responsable_screen.dart';
import 'package:iot_app/satisfaction_page.dart';
import 'package:iot_app/sign_in_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash: 
    Column(
      children: [
        Center(
          child: LottieBuilder.asset("assets/Lottie/Animation - 1738699815780.json"),
        )
      ],
    ), 
    nextScreen:  ClientPage(),
    splashIconSize: 400,

    backgroundColor: Colors.blue.shade800,
    );
  }
}