import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
