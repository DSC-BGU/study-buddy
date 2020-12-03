import 'package:flutter/material.dart';

import '../../app_localizations.dart';

class MainScreenNavigationRow extends StatelessWidget {
  const MainScreenNavigationRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RaisedButton(
          onPressed: () => {},
          child: Text(t('Reports')),
          color: Theme.of(context).accentColor.withOpacity(0.7),
        ),
        RaisedButton(
          onPressed: () => {},
          child: Text(t('Coupons')),
          color: Theme.of(context).accentColor.withOpacity(0.7),
        ),
        RaisedButton(
          onPressed: () => {},
          child: Text(t('My Groups')),
          color: Theme.of(context).accentColor.withOpacity(0.7),
        ),
      ],
    );
  }
}
