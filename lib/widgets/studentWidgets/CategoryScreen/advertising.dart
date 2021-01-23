import 'package:flutter/material.dart';
import '../../../app_localizations.dart';

class Advertising extends StatelessWidget {
  final double width;
  final double height;
  const Advertising({
    this.height = 100,
    this.width = double.infinity,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth * 0.93,
          height: this.height,
          child: Text(
            t('Advertising'),
            style: Theme.of(context).textTheme.headline4,
          ),
        );
      },
    );
  }
}
