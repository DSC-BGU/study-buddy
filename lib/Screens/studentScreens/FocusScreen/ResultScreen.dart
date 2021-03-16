import 'package:flutter/material.dart';
import '../../../app_localizations.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = "/result";
  @override
  Widget build(BuildContext context) {
    ResultScreenArguments args = ModalRoute.of(context).settings.arguments;
    String t(String text) => AppLocalizations.of(context).translate(text);
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  (args.success ? t("You did it!") : t('You got destructed')),
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  ((args.success
                          ? t("You just got")
                          : t("You could have get")) + " " +
                      args.points.toString() +
                      " " + t("points")),
                  style: Theme.of(context).textTheme.headline5,
                )
              ],
            ),
            Container(
                height: 150,
                child: Image.asset(
                    args.success ? "assets/present.png" : "assets/sad.png")),
            RaisedButton(
              onPressed: () => {Navigator.of(context).pop()},
              child: Text(t("Go Back")),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}

class ResultScreenArguments {
  bool success;
  int points;
  ResultScreenArguments({this.success, this.points});
}
