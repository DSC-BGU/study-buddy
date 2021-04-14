import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/Screens/businessScreens/BusinessMainScreen.dart';
import 'package:study_buddy/Screens/businessScreens/CreateNewCouponScreen.dart';
import 'package:study_buddy/Screens/studentScreens/DrawerButton.dart';
import 'package:study_buddy/Screens/studentScreens/DrawerMenu.dart';
import 'package:study_buddy/models/sharedModels/store.dart';
import 'package:study_buddy/models/studentModels/couponModels/Coupon.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';
import 'package:study_buddy/widgets/businessWidgets/business_coupon.dart';
import 'package:study_buddy/widgets/designs/Background.dart';

import '../../app_localizations.dart';

class ManageCoupons extends StatelessWidget {
  static const String routeName = '/manageCoupons';
  final databaseReference = FirebaseFirestore.instance;
  final Store currStore = null;

  ManageCoupons();

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    UserProvider user = Provider.of<UserProvider>(context);
    String storeId = user.storeId;
    List<Coupon> bussinessCoupons = user.getBussinessCoupons(storeId);
    bool rtl = AppLocalizations.of(context).isRtl();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
      endDrawer: !AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return Stack(
              children: [
                Background(),
                DrawerButton(),
                Container(
                  width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: constraints.maxHeight * 0.02,
                        bottom: constraints.maxHeight * 0.03),
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        left: constraints.maxWidth * 0.05,
                        right: constraints.maxWidth * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: rtl
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: constraints.maxHeight * 0.044,
                            backgroundImage: user.imageProvider,
                          ),
                          Text(
                            user.name,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Stack(children: [
                      Card(
                        margin: EdgeInsets.only(
                            left: 18,
                            top: constraints.maxHeight * 0.18,
                            right: 17,
                            bottom: 8),
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                            height: constraints.maxHeight * 0.14,
                            width: constraints.maxWidth * 0.9,
                            child: Center(
                              child: Text(
                                t('ניהול קופונים'),
                                style: TextStyle(fontSize: 35),
                              ),
                            )),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: constraints.maxHeight * 0.07),
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/kidWithComputer.svg",
                          ),
                        ),
                      ),
                    ]),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (ctx, index) {
                          return BusinessCoupon(
                              coupon: bussinessCoupons[index]);
                        },
                        itemCount: bussinessCoupons.length,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: constraints.maxHeight * 0.11,
                            width: constraints.maxWidth * 0.2,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("/");
                              },
                              child: Center(
                                child: Text(
                                  t('חזרה'),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            height: constraints.maxHeight * 0.11,
                            width: constraints.maxWidth * 0.2,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(CreateNewCouponScreen.routeName);
                              },
                              child: Center(
                                child: Text(
                                  t('יצירת\nקופון'),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
