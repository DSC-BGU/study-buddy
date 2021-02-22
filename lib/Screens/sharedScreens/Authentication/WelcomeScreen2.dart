


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_buddy/widgets/designs/Background.dart';
import 'package:study_buddy/widgets/designs/Button.dart';
import 'package:study_buddy/widgets/sharedWidgets/auth/login_with_google_bar.dart';

import '../../../app_localizations.dart';
import '../../../widgets/designs/TopCurve.dart';
import "auth_screen.dart";

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: LayoutBuilder(builder: (ctx, constraints) {
          return Stack(
            children: [
              Background(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: constraints.maxHeight * 0.5,
                        child: SvgPicture.asset(
                          "assets/kidsWithClock.svg",
                        )),
                    Container(
                        width:  constraints.maxWidth * 0.7 ,
                        child:Image.asset("assets/logo-temp2.png")
                    ),
                    Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                          child: Column(
                            children: [
                              LoginWithGoogle(
                                true,
                                width: constraints.maxWidth * 0.5,
                              ),
                              Container(
                                  child: Button(
                                    onPressed: () {
                                      Navigator.of(ctx).pushNamed(AuthScreen.routeName);
                                    },
                                    child: Text(t('Businesses Entrance')),
                                    yellow: true,
                                  ))
                            ],
                          ),
                        ))
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
