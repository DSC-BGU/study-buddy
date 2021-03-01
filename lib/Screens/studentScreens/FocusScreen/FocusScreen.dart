import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';
import 'package:study_buddy/widgets/designs/Button.dart';
import 'package:study_buddy/widgets/designs/TopCurve.dart';
import 'package:study_buddy/widgets/studentWidgets/MainScreen/FocusWithFriendsModal.dart';
import '../../../app_localizations.dart';
import '../../../providers/studentProviders/FocusProvider.dart';
import '../../../widgets/FocusCircleSlider.dart';
import '../../../widgets/FocusTimer.dart';
import '../DrawerButton.dart';
import '../DrawerMenu.dart';


class FocusScreen extends StatelessWidget {
  static const String routeName = '/focus';

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    FocusProvider focusProvider = Provider.of<FocusProvider>(context);
    UserProvider user = Provider.of<UserProvider>(context);
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        drawer: AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
        endDrawer: !AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
        body: SafeArea(
          child: LayoutBuilder(builder: (ctx, constraints) {
<<<<<<< HEAD
            return Stack(
              children: [
                Container(color: Colors.white),
                TopCurve(),
                DrawerButton(),
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: constraints.maxWidth * 0.42,
                        height: constraints.maxHeight * 0.16,
                        child: Image.asset("assets/logo-temp.png"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: constraints.maxHeight * 0.04,
                            bottom: constraints.maxHeight * 0.03),
                        child: Container(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: constraints.maxHeight * 0.07,
                                backgroundImage:
                                    AssetImage("assets/avatar_temp.jpg"),
                              ),
                              Text(
                                t("Hi") + " " + user.name,
                                style: TextStyle(fontSize: 34),
                              ),
                              Text("You have" +
                                  " " +
                                  user.points.toString() +
                                  " " +
                                  "points")
                            ],
                          ),
                        ),
                      ),
                      FocusCircleSlider(
                        maxMinutes: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: constraints.maxHeight * 0.035,
                            top: constraints.maxHeight * 0.04),
                        child: Column(
                          children: [
                            FocusTimer(
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height: MediaQuery.of(context).size.height *
                                      0.045,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Theme.of(context).accentColor,
                                  ),
                                  child: Center(
                                      child: Text(focusProvider.focusStatus
                                          ? t("Give up")
                                          : t("Start")))),
                            ),
                            Button(
                              onPressed: () {},
                              child: Text(t("Focus with Friends")),
                              black: true,
                            ),
                            Text(
                              t("want to get more points? focus with your friends"),
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
=======
            return Stack( children: [
              Container(color: Colors.white),
              TopCurve(),
              DrawerButton(),
              Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: constraints.maxHeight * 0.03,
                        bottom: constraints.maxHeight * 0.03),
                    child: Container(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: constraints.maxHeight * 0.07,
                            backgroundImage:
                            AssetImage("assets/avatar_temp.jpg"),
                          ),
                          Text(
                            t("Hii") + " " + user.name,
                            style: TextStyle(fontSize: 34),
                          ),
                          Text("You have" +
                              " " +
                              user.points.toString() +
                              " " +
                              "points")
                        ],
                      ),
                    ),
                  ),
                  FocusCircleSlider(
                    height: constraints.maxHeight * 0.3,
                    maxMinutes: 60,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FocusTimer(
                            child: Container(
                                width: constraints.maxWidth * 0.4,
                                height:  constraints.maxHeight * 0.11,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Theme.of(context).accentColor,),
                                child: Center(child: Text(focusProvider.focusStatus ? t("Give up") : t("Start")))
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => Container(
                                  height: constraints.maxHeight * 0.5,
                                  child: FocusWithFriendsModal(),
                                ),
                              );
                            },
                            child: Text(t("Focus with Friends")),
                            minWidth: constraints.maxWidth * 0.4,
                            color: Theme.of(context).hintColor,
                            textColor: Colors.white,
                            height: constraints.maxHeight * 0.11,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          t("want to get more points? focus with your friends"),
                          style: TextStyle(fontSize: 12),
>>>>>>> 768a109b6307192a3ebff68b1f04ff2ddd5964d3
                        ),
                      ),
                    ],
                  ),
<<<<<<< HEAD
                )
              ],
            );
=======
                  Padding(
                    padding: const EdgeInsets.only(bottom:15),
                    child: Container(
                      child: Column(
                        children: [
                          Button(
                            onPressed: () {},
                            child: Text(t("Coupons store")),
                            icon: Icon(Ionicons.ios_add),
                            width: constraints.maxWidth * 0.7,
                          ),
                          Button(
                            onPressed: () {},
                            child: Text(t("My coupons")),
                            icon: Icon(Ionicons.md_pricetag),
                            width: constraints.maxWidth * 0.7,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
            ],);
>>>>>>> 768a109b6307192a3ebff68b1f04ff2ddd5964d3
          }),
        ));
  }
}
