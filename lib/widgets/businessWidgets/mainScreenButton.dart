import 'package:flutter/material.dart';
import 'package:study_buddy/widgets/designs/Button.dart';

import '../../app_localizations.dart';

class MainScreenButton extends StatelessWidget {
  String routeName;
  String title;
  Icon icon;
  BoxConstraints constraints;

  MainScreenButton({this.routeName, this.title, this.icon, this.constraints});

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return Button(
      onPressed: () {
        Navigator.of(context).pushNamed(
          this.routeName,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.arrow_back_ios),
          Text(t(this.title)),
          this.icon,
        ],
      ),
      color: Theme.of(context).primaryColor,
      height: constraints.maxHeight * 0.08,
    );
  }
}
