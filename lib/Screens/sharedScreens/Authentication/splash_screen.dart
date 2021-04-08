import 'dart:async';

import 'package:flutter/material.dart';
import 'package:study_buddy/widgets/designs/cleanBackground.dart';

import '../../../app_localizations.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // void initState() {
  //   super.initState();
  //   Timer(
  //       Duration(seconds: 3),
  //       () => Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (BuildContext context) => WelcomeScreen() //tmp
  //           )));
  // }

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          CleanBackground(),
          Center(
            child: Image.asset("assets/logo.png"),
          ),
          // Center(
          //   child: Image.asset("assets/icon.png"),
          // ),
        ],
      ),
    );
  }
}
