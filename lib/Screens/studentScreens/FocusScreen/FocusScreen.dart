import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/Screens/studentScreens/MyCoupons.dart';
import 'package:study_buddy/Screens/studentScreens/categories_screen.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';
import 'package:study_buddy/utils/HexColor.dart';
import 'package:study_buddy/widgets/designs/Background.dart';
import 'package:study_buddy/widgets/designs/Button.dart';
import 'package:study_buddy/widgets/studentWidgets/MainScreen/FocusWithFriendsModal.dart';
import '../../../app_localizations.dart';
import '../../../providers/studentProviders/FocusProvider.dart';
import '../../../widgets/FocusCircleSlider.dart';
import '../../../widgets/FocusTimer.dart';
import '../DrawerButton.dart';
import '../DrawerMenu.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FocusScreen extends StatelessWidget {
  static const String routeName = '/focus';

  @override
  Widget build(BuildContext context) {
    double textSize = MediaQuery.of(context).textScaleFactor;
    print(textSize);
    String t(String text) => AppLocalizations.of(context).translate(text);
    FocusProvider focusProvider = Provider.of<FocusProvider>(context);
    UserProvider user = Provider.of<UserProvider>(context);
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
        endDrawer: !AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
        body: SafeArea(
          child: LayoutBuilder(builder: (ctx, constraints) {
            return Stack(
              children: [
                Background(),
                DrawerButton(),
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: constraints.maxHeight * 0.03,
                            bottom: constraints.maxHeight * 0.03),
                        child: Container(
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius: constraints.maxHeight * 0.07,
                                  backgroundImage: user.imageProvider),
                              Text(
                                t("Hi") + " " + user.name,
                                style: TextStyle(
                                  fontSize: 25, //ScreenUtil().setSp(2),
                                ),
                              ),
                              Text(t("You have") +
                                  " " +
                                  user.points.toString() +
                                  " " +
                                  t("points")),
                              focusProvider.mode == FocusMode.coop
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          top: constraints.maxHeight * 0.03),
                                      child: Text(t("Social session") + " 💪",
                                          style: TextStyle(fontSize: 20)))
                                  : null,
                            ].where((element) => element != null).toList(),
                          ),
                        ),
                      ),
                      FocusCircleSlider(
                        height: constraints.maxHeight * 0.32,
                        maxMinutes: 120,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FocusTimer(
                                child: Container(
                                    width: constraints.maxWidth * 0.24,
                                    height: constraints.maxHeight * 0.11,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Center(
                                        child: Text(focusProvider.focusStatus
                                            ? t("Give up")
                                            : t("Start")))),
                              ),
                              focusProvider.focusStatus
                                  ? null
                                  : Container(
                                      width: constraints.maxWidth * 0.24,
                                      child: FlatButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context) => Container(
                                              height:
                                                  constraints.maxHeight * 0.5,
                                              child: FocusWithFriendsModal(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          t("Focus with Friends"),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        minWidth: constraints.maxWidth * 0.4,
                                        color: Theme.of(context).accentColor,
                                        height: constraints.maxHeight * 0.11,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                    ),
                            ].where((element) => element != null).toList(),
                          ),
                          focusProvider.mode == FocusMode.solo
                              ? Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    t("want to get more points? focus with your friends"),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                )
                              : null,
                        ].where((element) => element != null).toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Container(
                          child: Column(
                            children: [
                              Button(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(CategoriesScreen.routeName);
                                },
                                child: Text(t("Coupons store")),
                                icon: Icon(Ionicons.ios_add),
                                width: constraints.maxWidth * 0.7,
                                color: HexColor("#E1E0E0"),
                                height: constraints.maxHeight * 0.08,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Button(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(MyCoupons.routeName);
                                  },
                                  child: Text(t("My coupons")),
                                  icon: Icon(Ionicons.md_pricetag),
                                  width: constraints.maxWidth * 0.7,
                                  color: HexColor("#E1E0E0"),
                                  height: constraints.maxHeight * 0.08,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
        ));
  }
}
