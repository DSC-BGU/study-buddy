import 'package:flutter/material.dart';
import 'package:study_buddy/widgets/businessWidgets/BusinessDrawerMenu.dart';
import 'package:study_buddy/Screens/studentScreens/DrawerButton.dart';
import 'package:study_buddy/utils/HexColor.dart';
import 'package:study_buddy/widgets/designs/Background.dart';

import '../../app_localizations.dart';

class CreateNewCouponScreen extends StatelessWidget {
  static const String routeName = '/createNewCoupon';
  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);

    return Scaffold(
      backgroundColor: HexColor("#5CA2D5"),
      drawer:
          AppLocalizations.of(context).isRtl() ? BusinessDrawerMenu() : null,
      endDrawer:
          !AppLocalizations.of(context).isRtl() ? BusinessDrawerMenu() : null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return Stack(
              children: [
                Background(),
                DrawerButton(),
              ],
            );
          },
        ),
      ),
    );
  }
}
