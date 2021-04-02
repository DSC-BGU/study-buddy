import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_buddy/Screens/studentScreens/DrawerButton.dart';
import 'package:study_buddy/Screens/studentScreens/DrawerMenu.dart';
import 'package:study_buddy/widgets/designs/Background.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';

class ScanDetailsScreen extends StatefulWidget {
  static const String routeName = '/scanDetails';

  ScanDetailsScreen();

  @override
  _ScanDetailsScreenState createState() => _ScanDetailsScreenState();
}

class _ScanDetailsScreenState extends State<ScanDetailsScreen> {
  bool loading = true;
  String purchasedId;
  String userName;
  String couponTitle;
  String couponDescription;
  String couponImage; // for now, not in use
  int points;
  bool init = false;
  bool used;
  DateTime dateExpired;
  bool valid;

  void useCoupon(BuildContext context, UserProvider userProvider) {
    Navigator.pop(context);
    approvePurchaseAlert();
    userProvider.useCoupon(this.purchasedId);
  }

  void bringData() {
    setState(() {
      this.purchasedId = ModalRoute.of(context).settings.arguments;
    });
    if (init) {
      return;
    } else {
      setState(() {
        init = true;
      });
    }
    String userId;
    String couponId;

    FirebaseFirestore.instance
        .collection('purchasedCoupons')
        .doc(purchasedId)
        .get()
        .then((doc) {
      Map data = doc.data();
      userId = data['userId'];
      couponId = data['couponId'];
      this.used = data['used'];

      FirebaseFirestore.instance
          .collection('coupons')
          .doc(couponId)
          .get()
          .then((doc) {
        Map data = doc.data();
        setState(() {
          this.couponTitle = data['title'];
          this.couponDescription = data['description'];
          this.points = data['points'];
          Timestamp time = data['dateExpired'];
          this.dateExpired = time.toDate();
          this.couponImage = data['imageUrl'];
        });
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .then((doc) {
        Map data = doc.data();
        setState(() {
          this.userName = data['username'];
        });
      });
    });
  }

  @override
  void initState() {
    loading = true;
    super.initState();
  }

  void approvePurchaseAlert() {
    Alert(
      context: context,
      title: 'Approved',
      desc: 'Coupon succussfuly used',
      closeIcon: Icon(Icons.verified),
      buttons: [
        DialogButton(
          child: Text(
            'COOL',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  AlertDialog notValidCouponAlert() {
    return AlertDialog(
      title: Text('Invalid Coupon'),
      content: Text('Coupon been used before or it is expired'),
      actions: [
        DialogButton(
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bringData();
    if (loading) {
      if (this.userName != null && this.dateExpired != null) {
        setState(() {
          loading = false;
          valid = !used && DateTime.now().compareTo(dateExpired) < 0;
        });
      }
    }

    String t(String text) => AppLocalizations.of(context).translate(text);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
      endDrawer: !AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
      body: SafeArea(
        child: LayoutBuilder(builder: (ctx, constraints) {
          if (loading) {
            return Center(
              child: Container(
                height: constraints.maxHeight * 0.5,
                width: constraints.maxHeight * 0.5,
                child: CircularProgressIndicator(
                  strokeWidth: 7,
                ),
              ),
            );
          } else {
            if (valid) {
              return Stack(
                children: [
                  Background(),
                  DrawerButton(),
                  Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                            child: Text(
                              this.userName +
                                  ' ' +
                                  t('just entered your store'),
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          Center(
                            child: Text(
                              t('The coupon') + ': ' + t(this.couponTitle),
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                          Center(
                            child: Text(
                              t('More details \\ terms') +
                                  ': ' +
                                  t(this.couponDescription),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: constraints.maxWidth * 0.24,
                                child: FlatButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    t("decline"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  minWidth: constraints.maxWidth * 0.4,
                                  color: Theme.of(context).accentColor,
                                  height: constraints.maxHeight * 0.11,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              Container(
                                width: constraints.maxWidth * 0.24,
                                child: FlatButton(
                                  onPressed: () =>
                                      useCoupon(context, userProvider),
                                  child: Text(
                                    t("approve"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  minWidth: constraints.maxWidth * 0.4,
                                  color: Theme.of(context).accentColor,
                                  height: constraints.maxHeight * 0.11,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              );
            } else {
              return notValidCouponAlert();
            }
          }
        }),
      ),
    );
  }
}
