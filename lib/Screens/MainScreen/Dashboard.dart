import 'package:flutter/material.dart';
import 'package:study_buddy/Screens/FocusScreen/FocusScreen.dart';
import 'package:study_buddy/widgets/MainScreen/PointsStatus.dart';
import 'package:study_buddy/widgets/utils/MyCustomRoute.dart';
import '../../widgets/MainScreen/MainScreenNavigationRow.dart';
import '../../widgets/MainScreen/StartButton.dart';
import 'ProgressionGraph.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  static const String routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    void _onPressStart() {
      Navigator.push(
        context,
        new MyCustomRoute(
          builder: (context) => FocusScreen(),
        ),
      );
    }

    return Container(
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
    );
  }
}
