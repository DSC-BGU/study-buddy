import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/TimeFunctions.dart';
import '../providers/studentProviders/FocusProvider.dart';
import '../widgets/studentWidgets/MainScreen/circular_slider.dart';

class FocusCircleSlider extends StatelessWidget {
  final int maxMinutes;
  final double height;
  const FocusCircleSlider({
    this.height,
    this.maxMinutes = 90,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusProvider focusProvider = Provider.of<FocusProvider>(context);
    final setTime = printDuration(focusProvider.remainTime);
    int minutesLeft = focusProvider.remainTime.inMinutes;
    return Container(
      child: SingleCircularSlider(maxMinutes, minutesLeft,
          height: height,
          baseColor: Theme.of(context).accentColor,
          handlerColor: Theme.of(context).primaryColor,
          child: Center(
            child: Text(setTime),
          ), onSelectionChange: (int init, int end, int laps) {
        focusProvider.setTime(Duration(minutes: end));
      }),
    );
  }
}
