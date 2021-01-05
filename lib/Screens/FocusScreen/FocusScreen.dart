import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';
import '../../providers/FocusProvider.dart';
import '../../widgets/FocusCircleSlider.dart';
import '../../widgets/FocusTimer.dart';
import '../../widgets/MainScreen/PointsStatus.dart';
import '../../widgets/MainScreen/StartButton.dart';

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
    topWidget() {
      if (mode == FocusMode.coop && focusProvider.focusStatus == false) {
        return Column(
          children: [
            Text(t("Session number:"), style: Theme.of(context).textTheme.headline6,),
            Text(
              (focusProvider.joinCode.toString().substring(0, 3) +
                  "  " +
                  focusProvider.joinCode.toString().substring(3)),
              style: Theme.of(context).textTheme.headline3,
            ),
            Container(
              width: 150,
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(labelText: t('Join a Session'),),
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (text){
                  if(text.length > 6)
                    return "";
                  return null;
                },
                onFieldSubmitted: (text){
                  text = text.trim();
                  if (text.trim != ""){
                    int joinCode = int.parse(text);
                    focusProvider.joinSession(joinCode,context);
                  }
                },
              ),
            ),
          ],
        );
      }
      return focusProvider.focusStatus
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "You are in focus mode",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "Do not touch or use your phone to get the points",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            )
          : Hero(
              tag: 'pointStatus',
              child: PointsStatus(),
            );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: topWidget(),
            ),
            Flexible(
              child: FocusCircleSlider(),
            ),
            Flexible(
              child: FlatButton(
                child: Text(mode == FocusMode.solo
                    ? t("Focus with Friends")
                    : t("Focus alone")),
                onPressed: () {
                  changeMode(focusProvider);
                },
              ),
            ),
            Flexible(
              child: Hero(
                tag: 'StartButton',
                child: FocusTimer(
                  child: StartButton(onClick: () {}),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
