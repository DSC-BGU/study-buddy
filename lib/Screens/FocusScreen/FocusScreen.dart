import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/models/User.dart';
import 'package:study_buddy/providers/FocusProvider.dart';
import 'package:study_buddy/providers/points.dart';
import 'package:study_buddy/widgets/FocusCircleSlider.dart';
import 'package:study_buddy/widgets/FocusTimer.dart';
import 'package:study_buddy/widgets/MainScreen/PointsStatus.dart';
import 'package:study_buddy/widgets/MainScreen/StartButton.dart';
import 'dart:async';

class FocusScreen extends StatefulWidget {
  const FocusScreen({Key key}) : super(key: key);

  static const String routeName = "/focus";

  @override
  _FocusScreenState createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {

  @override
  Widget build(BuildContext context) {
    FocusProvider focusProvider = Provider.of<FocusProvider>(context);
    topWidget() => focusProvider.focusStatus
        ? Text('You can do that!')
        : Hero(
            tag: 'pointStatus',
            child: PointsStatus(),
          );

    return Scaffold(
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
