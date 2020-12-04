import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:study_buddy/utils/TimeFunctions.dart';

class FocusCircleSlider extends StatefulWidget {
  final int maxMinutes;
  final Duration currentTime;
  final void Function(Duration newDuration) onSetTime;
  const FocusCircleSlider({
    this.onSetTime,
    this.maxMinutes = 90,
    this.currentTime,
    Key key,
  }) : super(key: key);

  @override
  _FocusCircleSliderState createState() => _FocusCircleSliderState();
}

class _FocusCircleSliderState extends State<FocusCircleSlider> {
  @override
  void initState() {
    super.initState();
  }

  void onTimeChange(int init, int end, int laps) {
    setState(() {
      this.widget.onSetTime(Duration(minutes: end));
    });
  }

  void onEndChange(int init, int end, int laps) {
    if (this.widget.onSetTime != null)
      this.widget.onSetTime(Duration(minutes: end));
  }

  @override
  Widget build(BuildContext context) {
    final setTime = printDuration(widget.currentTime);
    return Container(
      child: SingleCircularSlider(
        this.widget.maxMinutes,
        widget.currentTime.inMinutes,
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
