import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_buddy/utils/HexColor.dart';
import 'package:study_buddy/widgets/designs/Background.dart';
import 'package:study_buddy/widgets/designs/TopCurve.dart';

import '../../../app_localizations.dart';
import '../../../widgets/sharedWidgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
  static const INITIAL_POINTS = 500;
  static const routeName = "/auth";
}

class _AuthScreenState extends State<AuthScreen> {
  String t(String text) => AppLocalizations.of(context).translate(text);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _isLoading = false;
  String userEmail = null;
  String password = null;
  String storeName = null;
  String address = null;

  // void _submitAuthForm(
  //   String email,
  //   String password,
  //   String username,
  //   bool isLogin,
  //   BuildContext ctx,
  // ) async {
  //   UserCredential authResult;
  //
  //   try {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     if (isLogin) {
  //       authResult = await _auth.signInWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
  //     } else {
  //       authResult = await _auth.createUserWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );
  //
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(authResult.user.uid)
  //           .set({
  //         'username': username,
  //         'email': email,
  //         'points': AuthScreen.INITIAL_POINTS, // points,
  //         "purchased_coupons": [],
  //         'business': true
  //       });
  //     }
  //   } on PlatformException catch (err) {
  //     var message = 'An error occurred, please check your credentials!';
  //
  //     if (err.message != null) {
  //       message = err.message;
  //     }
  //
  //     Scaffold.of(ctx).showSnackBar(
  //       SnackBar(
  //         content: Text(t(message)),
  //         backgroundColor: Theme.of(ctx).errorColor,
  //       ),
  //     );
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   } catch (err) {
  //     print(err);
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  InputDecoration generateDecoration(text) {
    return InputDecoration(
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      border: new OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10.0),
        ),
      ),
      labelText: t(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#5CA2D5"),
      body: SafeArea(
        child: LayoutBuilder(builder: (ctx, constraints) {
          return Stack(
            children: [
              Background(),
              Container(
                margin: EdgeInsets.only(top: constraints.maxHeight * 0.13),
                child: Form(
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 39.8,
                            ),
                            height: constraints.maxHeight * 0.59,
                            width: constraints.maxWidth * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(92, 162, 213, 0.9),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: constraints.maxHeight * 0.05),
                              child: Column(
                                children: [
                                  Text(
                                    t("Register"),
                                    style: TextStyle(fontSize: 40),
                                  ),
                                  Text(
                                    t("Business Details"),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: constraints.maxHeight * 0.059,
                                          left: constraints.maxWidth * 0.1,
                                          right: constraints.maxWidth * 0.1),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            decoration: generateDecoration(
                                                "Email Address"),
                                            key: ValueKey('email'),
                                            validator: (value) {
                                              if (value.isEmpty ||
                                                  !value.contains('@')) {
                                                return t(
                                                    'Please enter a valid email address.');
                                              }
                                              return null;
                                            },
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            onSaved: (value) {
                                              setState(() {
                                                userEmail=value;
                                              });
                                            },
                                          ),
                                          TextFormField(
                                            decoration: generateDecoration(
                                                "Password"),
                                            key: ValueKey('password'),
                                            validator: (value) {
                                              if (value.isEmpty ||
                                                  value.length<6) {
                                                return t(
                                                    'Please enter a password with at least 6 characters.');
                                              }
                                              return null;
                                            },
                                            keyboardType:
                                            TextInputType.visiblePassword,
                                            obscureText: true,
                                            onSaved: (value) {
                                              setState(() {
                                                password=value;
                                              });
                                            },
                                          ),
                                          TextFormField(
                                            decoration: generateDecoration(
                                                "Store name"),
                                            key: ValueKey('name'),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return t(
                                                    'Please enter the store name.');
                                              }
                                              return null;
                                            },
                                            keyboardType:
                                            TextInputType.name,
                                            onSaved: (value) {
                                              setState(() {
                                                storeName=value;
                                              });
                                            },
                                          ),
                                          TextFormField(
                                            decoration: generateDecoration(
                                                "Address"),
                                            key: ValueKey('name'),
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return t(
                                                    'Please enter the store address.');
                                              }
                                              return null;
                                            },
                                            keyboardType:
                                            TextInputType.streetAddress,
                                            onSaved: (value) {
                                              setState(() {
                                                address=value;
                                              });
                                            },
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth * 0.08,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  width: constraints.maxWidth * 0.12,
                                  height: constraints.maxWidth * 0.12,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 50),
                                child: SvgPicture.asset(
                                  "assets/kidWithComputer.svg",
                                ),
                              )
                            ]),
                      )
                    ],
                  ),
                ),
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       width: constraints.maxWidth * 0.42,
              //       height: constraints.maxHeight * 0.16,
              //       child: Image.asset("assets/logo-temp.png"),
              //     ),
              //     Container(
              //       height: constraints.maxHeight * 0.78,
              //       child: AuthForm(
              //         _submitAuthForm,
              //         _isLoading,
              //       ),
              //     )
              //   ],
              // )
            ],
          );
        }),
      ),
    );
  }
}
