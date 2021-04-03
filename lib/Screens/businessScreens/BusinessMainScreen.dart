import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:study_buddy/Screens/businessScreens/BusinessDrawerMenu.dart';
import 'package:study_buddy/Screens/businessScreens/ScanDetailsScreen.dart';
import 'package:study_buddy/Screens/studentScreens/DrawerButton.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';
import 'package:study_buddy/utils/HexColor.dart';
import 'package:study_buddy/widgets/businessWidgets/ScanButton.dart';
import 'package:study_buddy/widgets/designs/Background.dart';
import 'package:study_buddy/widgets/designs/Button.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';

class BusinessMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    UserProvider user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: HexColor("#5CA2D5"),
      drawer:
          AppLocalizations.of(context).isRtl() ? BusinessDrawerMenu() : null,
      endDrawer:
          !AppLocalizations.of(context).isRtl() ? BusinessDrawerMenu() : null,
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
                      top: constraints.maxHeight * 0.03,
                      bottom: constraints.maxHeight * 0.03),
                  child: Container(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: constraints.maxHeight * 0.055,
                          backgroundImage: user.imageProvider,
                        ),
                        Text(
                          user.name,
                          style: TextStyle(fontSize: 20),
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
                              top: constraints.maxHeight * 0.02,
                              left: constraints.maxWidth * 0.1,
                              right: constraints.maxWidth * 0.1,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Column(
                                children: [
                                  Button(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.arrow_back_ios),
                                        Text(t("Create new coupon")),
                                        Icon(Ionicons.ios_add),
                                      ],
                                    ),
                                    width: constraints.maxWidth * 0.7,
                                    color: Theme.of(context)
                                        .primaryColor, //HexColor("#E1E0E0"),
                                    height: constraints.maxHeight * 0.08,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Button(
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.arrow_back_ios),
                                          Text(t("Manage coupons")),
                                          Icon(Ionicons.md_pricetag_outline),
                                        ],
                                      ),
                                      width: constraints.maxWidth * 0.7,
                                      color: Theme.of(context)
                                          .primaryColor, //HexColor("#E1E0E0"),
                                      height: constraints.maxHeight * 0.08,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Button(
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.arrow_back_ios),
                                          Text(t("Manage my store")),
                                          Icon(Ionicons.home_outline),
                                        ],
                                      ),
                                      width: constraints.maxWidth * 0.7,
                                      color: Theme.of(context)
                                          .primaryColor, //HexColor("#E1E0E0"),
                                      height: constraints.maxHeight * 0.08,
                                    ),
                                  ),
                                  Card(), // @TODO
                                  ScanButton(
                                    child: Container(
                                      // decoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(16),
                                      // ),
                                      margin: EdgeInsets.only(
                                          top: constraints.maxHeight * 0.095,
                                          bottom: constraints.maxHeight * 0.03),
                                      child: Text(
                                        t("Scan barcode"),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      width: constraints.maxWidth * 0.6,
                                      color: Theme.of(context).primaryColor,
                                      height: constraints.maxHeight * 0.11,
                                      // shape: RoundedRectangleBorder(
                                      //     borderRadius:
                                      //         BorderRadius.circular(16)),
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
                            margin: EdgeInsets.only(
                                bottom: constraints.maxHeight *
                                    0.015), // TODO: constrains
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
