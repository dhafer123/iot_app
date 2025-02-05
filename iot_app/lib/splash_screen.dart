import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
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
    nextScreen: const login_screen(),
    splashIconSize: 400,

    backgroundColor: const Color.fromARGB(255, 107, 159, 248),
    );
  }
}