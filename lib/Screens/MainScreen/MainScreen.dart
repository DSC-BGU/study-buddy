import 'package:flutter/material.dart';
import 'package:study_buddy/Screens/FocusScreen/FocusScreen.dart';
import 'package:study_buddy/widgets/MainScreen/PointsStatus.dart';
import '../../widgets/MainScreen/MainScreenNavigationRow.dart';
import '../../widgets/MainScreen/StartButton.dart';
import 'ProgressionGraph.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onPressStart() {
      Navigator.pushNamed(context, FocusScreen.routeName);
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(child: Hero(tag: 'pointStatus', child: PointsStatus())),
            Flexible(child: MainScreenNavigationRow()),
            Flexible(child: ProgressionGraph()),
            Flexible(
              child: Hero(
                tag: 'StartButton',
                child: StartButton(
                  onClick: _onPressStart,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
