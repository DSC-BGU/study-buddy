import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';
import 'package:study_buddy/widgets/designs/Button.dart';
import 'package:study_buddy/widgets/designs/TopCurve.dart';
import '../../../app_localizations.dart';
import '../../../providers/studentProviders/FocusProvider.dart';
import '../../../widgets/studentWidgets/MainScreen/PointsStatus.dart';
import '../../../widgets/studentWidgets/MainScreen/StartButton.dart';
import '../../../widgets/FocusCircleSlider.dart';
import '../../../widgets/FocusTimer.dart';
import '../DrawerButton.dart';
import '../DrawerMenu.dart';

class FocusScreen extends StatefulWidget {
  const FocusScreen({Key key}) : super(key: key);

  static const String routeName = '/focus';

  @override
  _FocusScreenState createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  void changeMode(FocusProvider focusProvider) {
    focusProvider.changeMode();
  }

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    FocusProvider focusProvider = Provider.of<FocusProvider>(context);
    FocusMode mode = focusProvider.mode;
    // topWidget() {
    //   if (mode == FocusMode.coop && focusProvider.focusStatus == false) {
    //     return Column(
    //       children: [
    //         Text(
    //           t("Session number:"),
    //           style: Theme.of(context).textTheme.headline6,
    //         ),
    //         Text(
    //           (focusProvider.joinCode.toString().substring(0, 3) +
    //               "  " +
    //               focusProvider.joinCode.toString().substring(3)),
    //           style: Theme.of(context).textTheme.headline3,
    //         ),
    //         Container(
    //           width: 150,
    //           child: TextFormField(
    //             textAlign: TextAlign.center,
    //             decoration: InputDecoration(
    //               labelText: t('Join a Session'),
    //             ),
    //             keyboardType: TextInputType.number,
    //             autovalidateMode: AutovalidateMode.onUserInteraction,
    //             validator: (text) {
    //               if (text.length > 6) return "";
    //               return null;
    //             },
    //             onFieldSubmitted: (text) {
    //               text = text.trim();
    //               if (text.trim != "") {
    //                 int joinCode = int.parse(text);
    //                 focusProvider.joinSession(joinCode, context);
    //               }
    //             },
    //           ),
    //         ),
    //       ],
    //     );
    //   }
    //   return focusProvider.focusStatus
    //       ? Container(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               Text(
    //                 "You are in focus mode",
    //                 style: Theme.of(context).textTheme.headline5,
    //               ),
    //               Text(
    //                 "Do not touch or use your phone to get the points",
    //                 style: Theme.of(context).textTheme.bodyText2,
    //               ),
    //             ],
    //           ),
    //         )
    //       : Hero(
    //           tag: 'pointStatus',
    //           child: PointsStatus(),
    //         );
    // }

    UserProvider user = Provider.of<UserProvider>(context);
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        drawer: AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
        endDrawer: !AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
        body: SafeArea(
          child: LayoutBuilder(builder: (ctx, constraints) {
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
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
        ));
  }
}
