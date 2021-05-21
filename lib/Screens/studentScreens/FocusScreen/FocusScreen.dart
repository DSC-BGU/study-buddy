import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
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

class FocusScreen extends StatelessWidget {
  static const String routeName = '/focus';
  @override
  Widget build(BuildContext context) {
    FocusProvider focusProvider = Provider.of<FocusProvider>(context);
    UserProvider user = Provider.of<UserProvider>(context);
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
        endDrawer: !AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
        body: (user.name == "")
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ShowCaseWidget(
                autoPlay: false,
                autoPlayDelay: Duration(seconds: 5),
                onFinish: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool("wizardShown", true);
                },
                builder: Builder(
                  builder: (BuildContext context) {
                    return FocusScreenContent(
                        user: user, focusProvider: focusProvider);
                  },
                )));
  }
}

class FocusScreenContent extends StatefulWidget {
  const FocusScreenContent({
    Key key,
    @required this.user,
    @required this.focusProvider,
  }) : super(key: key);

  final UserProvider user;
  final FocusProvider focusProvider;

  @override
  _FocusScreenContentState createState() => _FocusScreenContentState();
}

class _FocusScreenContentState extends State<FocusScreenContent> {
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  GlobalKey _four = GlobalKey();

  @override
  void initState() {
    super.initState();
    //Start showcase view after current widget frames are drawn.
    if (WidgetsBinding.instance != null) {
      WidgetsBinding.instance.addPostFrameCallback((_)async{
          final prefs = await SharedPreferences.getInstance();
          if (prefs.getBool('wizardShown') == null) {
            ShowCaseWidget.of(context).startShowCase([_one, _two, _three,_four]);
          }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return SafeArea(
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
                          GestureDetector(
                            onDoubleTap: () async {
                              final prefs = await SharedPreferences.getInstance();
                              prefs.remove('wizardShown');
                            },
                            child: CircleAvatar(
                                radius: constraints.maxHeight * 0.07,
                                backgroundImage: widget.user.imageProvider),
                          ),
                          Text(
                            t("Hi") + " " + widget.user.name,
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(t("You have") +
                              " " +
                              widget.user.points.toString() +
                              " " +
                              t("points")),
                          widget.focusProvider.mode == FocusMode.coop
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
                  Showcase(
                    key: _one,
                    description:
                        t("Scroll the timer to set a target for your focus session!") +
                            "\n" +
                            t("remember: the more you learn, the more you eran!"),
                    child: FocusCircleSlider(
                      height: constraints.maxHeight * 0.32,
                      maxMinutes: 120,
                    ),
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
                                    child: Text(widget.focusProvider.focusStatus
                                        ? t("Give up")
                                        : t("Start")))),
                          ),
                          widget.focusProvider.focusStatus
                              ? null
                              : Showcase(
                                  key: _four,
                                  description: t(
                                      'Focus with friends and get extra points'),
                                  child: Container(
                                    width: constraints.maxWidth * 0.24,
                                    child: FlatButton(
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
                                ),
                        ].where((element) => element != null).toList(),
                      ),
                      widget.focusProvider.mode == FocusMode.solo
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
                          Showcase(
                            key: _two,
                            description: t(
                                "Check out our coupons store where you can spend the points you earn!"),
                            child: Button(
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
                          ),
                          Showcase(
                            description: t("You can find the coupons you bought over here"),
                            key: _three,
                            child: Container(
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
    );
  }
}
