import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:study_buddy/Screens/businessScreens/BusinessMainScreen.dart';
import 'package:study_buddy/utils/HexColor.dart';
import 'package:study_buddy/utils/firebaseStorage.dart';
import 'package:study_buddy/widgets/designs/Background.dart';
import "dart:io";
import '../../../app_localizations.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
  static const INITIAL_POINTS = 500;
  static const routeName = "/auth";
}

class _AuthScreenState extends State<AuthScreen> {
  String t(String text) => AppLocalizations.of(context).translate(text);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  String userEmail = null;
  String password = null;
  String storeName = null;
  String address = null;
  File _imageFile = null;
  bool isRegister = false;


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

  void register(BuildContext context) async {
    UserCredential authResult;
    // FirabaseStorageUtils.uploadImageToFirebase(context, _imageFile, 'test.jpg');
    try {
      authResult = await _auth.createUserWithEmailAndPassword(email: userEmail, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user.uid)
          .set({
        'username': storeName,
        'email': userEmail.trim(),
        'business': true,
        'name':storeName,
      });
      await FirebaseFirestore.instance
          .collection('stores')
          .add({
        'ownUser': authResult.user.uid,
        'storeName': storeName,
        'address': address,
        // Temporary default picture until we will setup the files storage:
        'imageUrl':"https://cdn-a.william-reed.com/var/wrbm_gb_food_pharma/storage/images/publications/food-beverage-nutrition/foodnavigator-asia.com/headlines/markets/can-unmanned-convenience-stores-take-off-in-indonesia-jd.com-thinks-so/8506049-1-eng-GB/Can-unmanned-convenience-stores-take-off-in-Indonesia-JD.com-thinks-so.jpg"
      });
      Navigator.of(context).pushNamedAndRemoveUntil(BusinessMainScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e){
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
            content:
            Text(t("The account already exists for that email."))));
      }
    }
    catch (e) {
      print(e);
    }
  }

  void login (BuildContext context) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmail.trim(),
          password: password
      );
      Navigator.of(context).pushNamedAndRemoveUntil(BusinessMainScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
            content:
            Text(t("User not found"))));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
            content:
            Text(t("Wrong Password"))));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: HexColor("#5CA2D5"),
      body: Container(
        child: LayoutBuilder(builder: (ctx, constraints) {
          return Stack(
            children: [
              Background(),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: constraints.maxHeight * 0.13),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 39.8,
                            ),
                            constraints: BoxConstraints(minHeight: constraints.maxHeight * 0.69),
                            width: constraints.maxWidth * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromRGBO(92, 162, 213, 0.9),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: constraints.maxHeight * 0.05),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        t(isRegister ? "Register" : "Login"),
                                        style: TextStyle(fontSize: 40),
                                      ),
                                      isRegister ? Text(
                                        t("Business Details"),
                                        style: TextStyle(fontSize: 15),
                                      ) : Container(),
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: constraints.maxHeight * 0.03,
                                              left: constraints.maxWidth * 0.1,
                                              right: constraints.maxWidth * 0.1),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: TextFormField(
                                                  onEditingComplete: () =>
                                                      node.nextFocus(),
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
                                                      userEmail = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 10),
                                                child: TextFormField(
                                                  onEditingComplete: () =>
                                                      node.nextFocus(),
                                                  decoration: generateDecoration(
                                                      "Password"),
                                                  key: ValueKey('password'),
                                                  validator: (value) {
                                                    if (value.isEmpty ||
                                                        value.length < 8) {
                                                      return t(
                                                          'Please enter a password with at least 8 characters.');
                                                    }
                                                    return null;
                                                  },
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  obscureText: true,
                                                  onSaved: (value) {
                                                    setState(() {
                                                      password = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              isRegister ? Container(
                                                margin: EdgeInsets.only(top: 10),
                                                child: TextFormField(
                                                  onEditingComplete: () =>
                                                      node.nextFocus(),
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
                                                      storeName = value;
                                                    });
                                                  },
                                                ),
                                              ) : null,
                                              isRegister ? Container(
                                                margin: EdgeInsets.only(top: 10),
                                                child: TextFormField(
                                                  onEditingComplete: () =>
                                                      node.nextFocus(),
                                                  decoration: generateDecoration(
                                                      "Address"),
                                                  key: ValueKey('Address'),
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
                                                      address = value;
                                                    });
                                                  },
                                                ),
                                              ) : null,
                                              Container(
                                                margin: EdgeInsets.only(top:20),
                                                child: ElevatedButton(
                                                  child: Text(isRegister ? "Register" : "Login"),
                                                  onPressed: () {
                                                    if (_formKey.currentState.validate()) {
                                                      _formKey.currentState.save();
                                                      if(isRegister){
                                                        this.register(context);
                                                      }
                                                      else{
                                                        this.login(context);
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                              Container(
                                                child: TextButton(
                                                  child: Text(isRegister ? "Login" : "Create New Store", style: TextStyle(color: Colors.black),),
                                                  onPressed: () {
                                                    setState(() {
                                                      isRegister = !isRegister;
                                                    });
                                                    },
                                                ),
                                              ),
                                              // Container(
                                              //   margin: EdgeInsets.only(top:10),
                                              //   child: Row(
                                              //     crossAxisAlignment:
                                              //         CrossAxisAlignment.center,
                                              //     children: [
                                              //       Text(
                                              //         t("Picture"),
                                              //       ),
                                              //       Container(
                                              //         child: IconButton(
                                              //             icon: Icon(Icons.image),
                                              //             onPressed:  () async {
                                              //               final picker = ImagePicker();
                                              //               final pickedFile = await picker.getImage(source: ImageSource.camera);
                                              //                 setState(() {
                                              //                   _imageFile = File(pickedFile.path);
                                              //                 });
                                              //             }),
                                              //         decoration: BoxDecoration(
                                              //             borderRadius: BorderRadius.circular(10.0),
                                              //             border: Border.all(color:Colors.white)
                                              //         ),
                                              //       )
                                              //     ],
                                              //   ),
                                              // )
                                            ].where((element) => element !=null).toList(),
                                          ))
                                    ],
                                  ),
                                ),
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
            ],
          );
        }),
      ),
    );
  }
}
