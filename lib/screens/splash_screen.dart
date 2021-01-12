import 'package:bregzy_vendor/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';


// ignore: camel_case_types
class Splash_Screen extends StatefulWidget {
  static String id = 'Splash_Screen';
  @override
  _Splash_ScreenState createState() => _Splash_ScreenState();
}

// ignore: camel_case_types
class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplash(
      imagePath: 'images/logo-bregzy-2000x727.png',
      home: LoginPage(),
      duration: 2500,
      type: AnimatedSplashType.StaticDuration,
    );
  }
}
