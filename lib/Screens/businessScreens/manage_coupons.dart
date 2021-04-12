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
                                'ניהול קופונים',
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
                                  'חזרה',
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
                                  'יצירת\nקופון',
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
    // return LayoutBuilder(builder: (ctx, constraints) {
    //   return Scaffold(
    //       backgroundColor: Theme.of(context).backgroundColor,
    //       appBar: AppBar(
    //         backgroundColor: Theme.of(context).backgroundColor,
    //         elevation: 0.0,
    //         centerTitle: true,
    //         leading: Icon(
    //           Icons.face,
    //           size: 45,
    //         ),
    //         actions: [
    //           Container(
    //             width: 60,
    //             decoration: BoxDecoration(
    //                 color: Theme.of(context).accentColor,
    //                 borderRadius:
    //                     BorderRadius.only(bottomLeft: Radius.circular(20))),
    //             child: IconButton(
    //                 icon: Icon(
    //                   Icons.menu,
    //                   color: Colors.black,
    //                 ),
    //                 onPressed: null),
    //           )
    //         ],
    //       ),
    //       body: Column(
    //         children: [
    //           Stack(children: [
    //             Card(
    //               color: Theme.of(context).hintColor,
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(15.0),
    //               ),
    //               margin: EdgeInsets.fromLTRB(25, 8, 25, 8),
    //               child: Container(
    //                   height: constraints.maxHeight * 0.1,
    //                   width: double.infinity,
    //                   margin: EdgeInsets.all(8),
    //                   child: Center(
    //                     child: Text(
    //                       'ניהול קופונים',
    //                       style: TextStyle(
    //                           color: Theme.of(context).accentColor,
    //                           fontSize: 35),
    //                     ),
    //                   )),
    //             ),
    //             Center(
    //                 child: Icon(Icons.face_rounded,
    //                     size: 80, color: Theme.of(context).accentColor))
    //           ]),
    // Expanded(
    //   child: ListView.builder(
    //     itemBuilder: (ctx, index) {
    //       return BusinessCoupon(coupon: availableCoupons[index]);
    //     },
    //     itemCount: availableCoupons.length,
    //   ),
    // ),
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: [
    //     Container(
    //       margin: EdgeInsets.all(8),
    //       child: FlatButton(
    //         height: constraints.maxHeight * 0.10,
    //         color: Theme.of(context).hintColor,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(15.0),
    //         ),
    //         onPressed: () {},
    //         child: Center(
    //           child: Text(
    //             'חזרה',
    //             style: TextStyle(
    //                 fontSize: 15,
    //                 color: Theme.of(context).accentColor),
    //           ),
    //         ),
    //       ),
    //     ),
    //     Container(
    //       margin: EdgeInsets.all(8),
    //       child: FlatButton(
    //         height: constraints.maxHeight * 0.10,
    //         color: Theme.of(context).hintColor,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(15.0),
    //         ),
    //         onPressed: () {},
    //         child: Center(
    //           child: Text(
    //             'יצירת קופון',
    //             style: TextStyle(
    //                 fontSize: 15,
    //                 color: Theme.of(context).accentColor),
    //           ),
    //         ),
    //       ),
    //     )
    //   ],
    // )
    //           ],
    //         ));
    //   });
  }
}
