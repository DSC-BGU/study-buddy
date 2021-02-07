import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_buddy/widgets/sharedWidgets/auth/login_with_google_bar.dart';

import '../../../app_localizations.dart';
import '../../../widgets/sharedWidgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
  static const INITIAL_POINTS = 500;
}

class _AuthScreenState extends State<AuthScreen> {
  String t(String text) => AppLocalizations.of(context).translate(text);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _isLoading = false;
  bool _business = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'username': username,
          'email': email,
          'points': AuthScreen.INITIAL_POINTS, // points,
          'business':true
        });
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(t(message)),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget login = null;
    if (this._business) {
      login = AuthForm(
        _submitAuthForm,
        _isLoading,
      );
    } else
      login =  LoginWithGoogle(true);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Center(
          child: Card(
            child: Container(
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight * 0.5,
                    minWidth: constraints.maxWidth * 0.7,
                    maxWidth: constraints.maxWidth * 0.8,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: _business ? constraints.maxWidth*0.2 : constraints.maxWidth*0.4,
                            height: _business ? constraints.maxWidth*0.2 : constraints.maxWidth*0.4,
                            child: Image.asset("assets/icon/icon.jpg"),
                          ),
                          login,
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                _business = !_business;
                              });
                            },
                            child: Text(
                              t(_business ? "student login" : "business login"),
                            ),
                          ),
                        ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
