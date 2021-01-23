import 'package:flutter/material.dart';
import '../../../app_localizations.dart';

class StartButton extends StatelessWidget {
  final void Function() onClick;
  const StartButton({
    this.onClick,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: constraints.maxHeight,
        child: RaisedButton(
          shape: new CircleBorder(),
          elevation: 2,
          child: Text(t('Start')),
          onPressed: onClick,
          color: Theme.of(context).primaryColor,
        ),
      );
    });
  }
}
