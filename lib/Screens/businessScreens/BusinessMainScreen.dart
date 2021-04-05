import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:study_buddy/Screens/businessScreens/BusinessDrawerMenu.dart';
import 'package:study_buddy/Screens/businessScreens/CreateNewCouponScreen.dart';
import 'package:study_buddy/Screens/businessScreens/ManageStoreScreen.dart';
import 'package:study_buddy/Screens/businessScreens/manage_coupons.dart';
import 'package:study_buddy/Screens/studentScreens/DrawerButton.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';
import 'package:study_buddy/utils/HexColor.dart';
import 'package:study_buddy/widgets/businessWidgets/ScanButton.dart';
import 'package:study_buddy/widgets/businessWidgets/mainScreenButton.dart';
import 'package:study_buddy/widgets/designs/Background.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';

class BusinessMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    UserProvider user = Provider.of<UserProvider>(context);
    bool rtl = AppLocalizations.of(context).isRtl();
    return Scaffold(
      backgroundColor: HexColor("#5CA2D5"),
      drawer: rtl ? BusinessDrawerMenu() : null,
      endDrawer: !rtl ? BusinessDrawerMenu() : null,
      body: SafeArea(
        child: LayoutBuilder(builder: (ctx, constraints) {
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
              Container(
                margin: EdgeInsets.only(top: constraints.maxHeight * 0.13),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: constraints.maxHeight * 0.055,
                          ),
                          height: constraints.maxHeight * 0.59,
                          width: constraints.maxWidth * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(92, 162, 213, 0.9),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(
                              top: constraints.maxHeight * 0.02,
                              left: constraints.maxWidth * 0.04,
                              right: constraints.maxWidth * 0.04,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Container(
                                    height: constraints.maxHeight * 0.08,
                                    child: MainScreenButton(
                                      routeName:
                                          CreateNewCouponScreen.routeName,
                                      title: "Create new coupon",
                                      icon: Icon(Ionicons.ios_add),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    height: constraints.maxHeight * 0.08,
                                    child: MainScreenButton(
                                      routeName: ManageCoupons.routeName,
                                      title: "Manage coupons",
                                      icon: Icon(Ionicons.md_pricetag_outline),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    height: constraints.maxHeight * 0.08,
                                    child: MainScreenButton(
                                      routeName: ManageStoreScreen.routeName,
                                      title: "Manage my store",
                                      icon: Icon(Ionicons.home_outline),
                                    ),
                                  ),
                                  ScanButton(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        top: constraints.maxHeight * 0.11,
                                      ),
                                      child: Center(
                                        child: Text(
                                          t("Scan barcode"),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      width: constraints.maxWidth * 0.55,
                                      height: constraints.maxHeight * 0.11,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: constraints.maxHeight * 0.26,
                            width: constraints.maxWidth * 0.44,
                            margin: EdgeInsets.only(
                              bottom: constraints.maxHeight * 0.01,
                            ),
                            child: SvgPicture.asset(
                              "assets/kidsWithPhone.svg",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
