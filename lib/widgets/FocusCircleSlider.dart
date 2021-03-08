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
    this.maxMinutes = 120,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusProvider focusProvider = Provider.of<FocusProvider>(context);
    final setTime = printDuration(focusProvider.remainTime);
    int minutesLeft = focusProvider.remainTime.inMinutes;
    return Container(
      child: SingleCircularSlider(maxMinutes, minutesLeft,
          primarySectors: 4,
          height: height,
          baseColor: Colors.white,
          handlerColor: Theme.of(context).primaryColor,
          selectionColor: Theme.of(context).backgroundColor,
          sliderStrokeWidth: 15,
          width: height,
          child: Center(
            child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                  border: Border.all(color: Colors.black, width: 7),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textDirection: TextDirection.ltr,
                    children: [
                      Text(
                        "01:30",
                        style: TextStyle(fontSize: 13),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "00:00",
                            style: TextStyle(fontSize: 13),
                          ),
                          Text(
                            setTime,
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "01:00",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                      Text(
                        "00:30",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                )),
          ), onSelectionChange: (int init, int end, int laps) {
        focusProvider.setTime(Duration(minutes: end));
      }),
    );
  }
}
