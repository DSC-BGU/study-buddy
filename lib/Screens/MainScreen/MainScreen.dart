import 'package:flutter/material.dart';
import 'package:study_buddy/widgets/MainScreen/PointsStatus.dart';
import '../../app_localizations.dart';
import '../../widgets/MainScreen/MainScreenNavigationRow.dart';
import 'ProgressionGraph.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(child: PointsStatus()),
            Flexible(child: MainScreenNavigationRow()),
            Flexible(child: ProgressionGraph()),
            Flexible(child: StartButton()),
          ],
        ),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: constraints.maxHeight,
        child: RawMaterialButton(
          shape: new CircleBorder(),
          elevation: 2,
          child: Text(t('Start')),
          onPressed: () => {},
          fillColor: Theme.of(context).primaryColor,
        ),
      );
    });
  }
}
