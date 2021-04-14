import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Screens/studentScreens/TabsScreen.dart';
import '../../../app_localizations.dart';
import '../../../Screens/sharedScreens/Authentication/auth_screen.dart';

class LoginWithGoogle extends StatelessWidget {
  final double width;
  final double height;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final bool isLogin;

  LoginWithGoogle(
    this.isLogin, {
    this.height = 40,
    this.width = 240,
  });

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return InkWell(
      child: Container(
        width: this.width,
        height: this.height,
        margin: EdgeInsets.only(top: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).hintColor),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('./assets/google.jpg'),
                      fit: BoxFit.cover),
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                isLogin ? t('Login with Google') : t('Sign in with Google'),
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      onTap: () async {
        signInWithGoogle().whenComplete(() {}).then((userCredential) async {
          bool isBgu = userCredential.additionalUserInfo.profile['hd'] ==
              "post.bgu.ac.il";
          if (userCredential.additionalUserInfo.isNewUser) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userCredential.user.uid)
                .set({
              'username': userCredential.user.displayName,
              'email': userCredential.user.email,
              'phoneNumber': userCredential.user.phoneNumber,
              'photoURL': userCredential.user.photoURL,
              'points': AuthScreen.INITIAL_POINTS, // points,
              'isBgu': isBgu,
              'business': false,
            });
          }
        });
      },
    );
  }
}
