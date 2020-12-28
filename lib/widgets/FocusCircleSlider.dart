import 'package:flutter/material.dart';
import 'package:study_buddy/utils/TimeFunctions.dart';

import 'MainScreen/circular_slider.dart';

class FocusCircleSlider extends StatelessWidget {
  final int maxMinutes;
  final Duration currentTime;
  final void Function(Duration newDuration) onSetTime;
  const FocusCircleSlider({
    this.onSetTime,
    this.maxMinutes = 90,
    this.currentTime,
    Key key,
  }) : super(key: key);


  void onTimeChange(int init, int end, int laps) {
      onSetTime(Duration(minutes: end));
  }

  void onEndChange(int init, int end, int laps) {
    if (this.onSetTime != null)
      this.onSetTime(Duration(minutes: end));
  }

  @override
  Widget build(BuildContext context) {
    final setTime = printDuration(this.currentTime);
    print(setTime);
    int minutesLeft = this.currentTime.inMinutes;
    return Container(
      child: SingleCircularSlider(
        this.maxMinutes,
        minutesLeft,
        baseColor: Theme.of(context).accentColor,
        handlerColor: Theme.of(context).primaryColor,
        child: Center(
          child: Text(setTime),
        ),
        onSelectionChange: onTimeChange,
        onSelectionEnd: onEndChange,
      ),
    );
  }
}
