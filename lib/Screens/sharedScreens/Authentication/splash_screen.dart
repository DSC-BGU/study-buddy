import 'package:flutter/material.dart';

import '../../../app_localizations.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return Scaffold(
      body: Center(
        child: Text(t('Loading...')),
      ),
    );
  }
}
