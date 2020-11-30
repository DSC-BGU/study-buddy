import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:study_buddy/widgets/MainScreen/PointsStatus.dart';
import 'package:study_buddy/widgets/MainScreen/StartButton.dart';

class FocusScreen extends StatelessWidget {
  const FocusScreen({Key key}) : super(key: key);

  static const String routeName = "/focus";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(child: Hero(tag: 'pointStatus', child: PointsStatus())),
            Flexible(
              child: FocusCircleSlider(),
            ),
            Flexible(
              child: Hero(
                tag: 'StartButton',
                child: StartButton(onClick: () => {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FocusCircleSlider extends StatefulWidget {
  final int maxMinutes;
  final int defaultStart;
  const FocusCircleSlider({
    this.maxMinutes = 90,
    this.defaultStart = 60,
    Key key,
  }) : super(key: key);

  @override
  _FocusCircleSliderState createState() => _FocusCircleSliderState();
}

class _FocusCircleSliderState extends State<FocusCircleSlider> {
  int _currentState;

  @override
  void initState() {
    _currentState = this.widget.defaultStart;
    super.initState();
  }

  void onTimeChange(int init, int end, int laps) {
    setState(() {
      _currentState = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleCircularSlider(
        this.widget.maxMinutes,
        _currentState,
        baseColor: Theme.of(context).accentColor,
        handlerColor: Theme.of(context).primaryColor,
        child: Center(child: Text(_currentState.toString())),
        onSelectionChange: onTimeChange,
      ),
    );
  }
}
