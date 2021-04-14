// import 'package:flutter/material.dart';

// class SplashScreen extends StatelessWidget {
//   static const String routeName = '/splash';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Image.asset("assets/icon.png"),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/Screens/sharedScreens/Authentication/WelcomeScreen.dart';
import 'package:study_buddy/Screens/sharedScreens/Authentication/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  @override
  void initState() {
    super.initState();
    initializeUser();
    navigateUser();
  }

  Future initializeUser() async {
    await Firebase.initializeApp();
    final User firebaseUser = FirebaseAuth.instance.currentUser;
    await firebaseUser.reload();
    _user = _auth.currentUser;
    // get User authentication status here
  }

  navigateUser() async {
    // checking whether user already loggedIn or not
    if (_auth.currentUser != null &&
        FirebaseAuth.instance.currentUser.reload() != null) {
      // &&  FirebaseAuth.instance.currentUser.reload() != null
      Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    WelcomeScreen()), //username: _auth.currentUser.displayName)),
            (Route<dynamic> route) => false),
      );
    } else {
      Timer(Duration(seconds: 4),
          () => Navigator.pushReplacementNamed(context, AuthScreen.routeName));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/icon.png"),
      ),
    );
  }
}
