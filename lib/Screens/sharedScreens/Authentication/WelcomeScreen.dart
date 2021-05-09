import 'package:flutter/material.dart';
import 'package:study_buddy/utils/HexColor.dart';
import 'package:study_buddy/widgets/designs/Background.dart';
import 'package:study_buddy/widgets/designs/Button.dart';
import 'package:study_buddy/widgets/sharedWidgets/auth/login_with_google_bar.dart';

import '../../../app_localizations.dart';
import "auth_screen.dart";
import 'package:flutter_svg/svg.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return Scaffold(
      backgroundColor: HexColor("#5CA2D5"),
      body: SafeArea(
        child: LayoutBuilder(builder: (ctx, constraints) {
          return Stack(
            children: [
              Background(),
              Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: constraints.maxHeight * 0.13,
                      ),
                      height: constraints.maxHeight * 0.3,
                      width: constraints.maxWidth * 0.8,
                      child: SvgPicture.asset(
                        "assets/kidsWithClock.svg",
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: constraints.maxHeight * 0.03,
                          ),
                          width: constraints.maxWidth * 0.7,
                          child: Image.asset("assets/logo.png"),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: constraints.maxHeight * 0.03,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white70,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              t("The more you learn, the more you earn!"),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: constraints.maxHeight * 0.01,
                        bottom: constraints.maxHeight * 0.01,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LoginWithGoogle(
                            true,
                            width: constraints.maxWidth * 0.5,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: constraints.maxHeight * 0.004,
                            ),
                            child: Button(
                              onPressed: () {
                                Navigator.of(ctx)
                                    .pushNamed(AuthScreen.routeName);
                              },
                              child: Text(t('Businesses Entrance')),
                              pink: true,
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
