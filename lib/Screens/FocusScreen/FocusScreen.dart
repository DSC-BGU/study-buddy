import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  Duration _remainTime = Duration(minutes: 60);
  Duration _targetTime = Duration(minutes: 60);
  Timer _timer;
  bool _focus = false;

  void onSetTime(newDuration) {
    setState(() {
      _remainTime = newDuration;
      _targetTime = newDuration;
    });
  }

  void onFocus(context) {
    const oneMinutes = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneMinutes,
      (Timer timer) => setState(
        () {
          if (_remainTime.inMinutes < 1) {
            timer.cancel();
            Points points = Provider.of<Points>(context, listen: false);
            points.focusSuccesss(_targetTime.inMinutes);
            setState(() {
              _focus = false;
            });
          } else {
            _remainTime = Duration(minutes: _remainTime.inMinutes - 1);
          }
        },
      ),
    );
    setState(() {
      _focus = true;
    });
  }

  void onOutOfFoucus() {
    if (_timer != null) {
      _timer.cancel();
    }
    setState(() {
      _focus = false;
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    topWidget() => _focus
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
              child: FocusCircleSlider(
                currentTime: _remainTime,
                onSetTime: onSetTime,
              ),
            ),
            Flexible(
              child: Hero(
                tag: 'StartButton',
                child: FocusTimer(
                  child: StartButton(onClick: () {}),
                  onStartFocus: () {
                    onFocus(context);
                  },
                  onOutFocus: onOutOfFoucus,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
