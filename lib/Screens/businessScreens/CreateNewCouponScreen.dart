import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:study_buddy/Screens/businessScreens/BusinessMainScreen.dart';
import 'package:study_buddy/utils/HexColor.dart';
//import 'package:study_buddy/utils/firebaseStorage.dart';
import 'package:study_buddy/widgets/designs/Background.dart';
import "dart:io";
import '../../app_localizations.dart';
import 'package:date_time_picker/date_time_picker.dart';
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:path/path.dart';

class CreateNewCouponScreen extends StatefulWidget {
  @override
  _CreateNewCouponState createState() => _CreateNewCouponState();

  static const routeName = "/CreateNewCoupon";
}

class _CreateNewCouponState extends State<CreateNewCouponScreen> {
  String t(String text) => AppLocalizations.of(context).translate(text);
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference coupons =
      FirebaseFirestore.instance.collection('coupons');

  final _formKey = GlobalKey<FormState>();

  String description = null;
  String title = null;
  int points = 0;
  Timestamp dateExpired = null;
  String store = null;
  File _imageFile = null;

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

  Future<void> addCoupon(BuildContext context) {
    getStore();
    return coupons
        .add({
          'description': description,
          'imageUrl': _imageFile.path,
          'title': title,
          'points': points,
          'dateExpired': dateExpired,
          'store': store,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void getStore() async {
    // FirabaseStorageUtils.uploadImageToFirebase(context, _imageFile, 'test.jpg');
    try {
      final User user = auth.currentUser;
      final uid = user.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data = documentSnapshot.data();
          store = data['store'];
        } else {
          store = null;
        }
      });
    } catch (e) {
      print(e);
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
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight * 0.69),
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
                                        t("New Coupon"),
                                        style: TextStyle(fontSize: 40),
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: constraints.maxHeight * 0.03,
                                              left: constraints.maxWidth * 0.1,
                                              right:
                                                  constraints.maxWidth * 0.1),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: TextFormField(
                                                  onEditingComplete: () =>
                                                      node.nextFocus(),
                                                  decoration:
                                                      generateDecoration(
                                                          "Title"),
                                                  key: ValueKey('title'),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return t(
                                                          'Please enter a valid title.');
                                                    }
                                                    return null;
                                                  },
                                                  keyboardType:
                                                      TextInputType.name,
                                                  onSaved: (value) {
                                                    setState(() {
                                                      title = value;
                                                    });
                                                  },
                                                ),
                                              ),

                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                child: TextFormField(
                                                  onEditingComplete: () =>
                                                      node.nextFocus(),
                                                  decoration:
                                                      generateDecoration(
                                                          "Points"),
                                                  key: ValueKey('points'),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return t(
                                                          'Please enter a valid points.');
                                                    }
                                                    return null;
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onSaved: (value) {
                                                    setState(() {
                                                      points = value as int;
                                                    });
                                                  },
                                                ),
                                              ),

                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                child: TextFormField(
                                                  onEditingComplete: () =>
                                                      node.nextFocus(),
                                                  decoration:
                                                      generateDecoration(
                                                          "Description"),
                                                  key: ValueKey('description'),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return t(
                                                          'Please enter valid description.');
                                                    }
                                                    return null;
                                                  },
                                                  keyboardType:
                                                      TextInputType.name,
                                                  onSaved: (value) {
                                                    setState(() {
                                                      description = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      child: IconButton(
                                                          icon: Icon(
                                                              FontAwesomeIcons
                                                                  .camera),
                                                          onPressed: () async {
                                                            final picker =
                                                                ImagePicker();
                                                            final pickedFile =
                                                                await picker.getImage(
                                                                    source: ImageSource
                                                                        .camera);
                                                            setState(() {
                                                              _imageFile = File(
                                                                  pickedFile
                                                                      .path);
                                                            });
                                                          }),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                    Text(
                                                      t(" Add picture"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  child: DateTimePicker(
                                                    type: DateTimePickerType
                                                        .dateTimeSeparate,
                                                    dateMask: 'd MMM, yyyy',
                                                    initialValue: DateTime.now()
                                                        .toString(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime(2100),
                                                    icon: Icon(Icons.event),
                                                    dateLabelText:
                                                        'Expiration date',
                                                    timeLabelText:
                                                        "Expiration hour",
                                                    onChanged: (val) =>
                                                        print(val),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return t(
                                                            'Please enter valid expiration date and hour.');
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (value) {
                                                      setState(() {
                                                        dateExpired =
                                                            value as Timestamp;
                                                      });
                                                    },
                                                  )),

                                              //********* */
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 20),
                                                child: ElevatedButton(
                                                  child: Text("Create coupon"),
                                                  onPressed: () {
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      _formKey.currentState
                                                          .save();

                                                      this.addCoupon(context);
                                                    }
                                                  },
                                                ),
                                              ),
                                              //************** */
                                            ]
                                                .where((element) =>
                                                    element != null)
                                                .toList(),
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
