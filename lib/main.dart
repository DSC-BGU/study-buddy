import 'package:flutter/material.dart';
import 'package:study_buddy/Screens/FocusScreen/FocusScreen.dart';
import 'package:study_buddy/Screens/TabsScreen.dart';
import 'Screens/MainScreen/Dashboard.dart';
import 'package:study_buddy/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      supportedLocales: [
        Locale('en', 'US'),
        Locale('he', 'IL'),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      routes: {
        '/': (ctx) => TabsScreen(),
        FocusScreen.routeName: (ctx) => FocusScreen(),
        Dashboard.routeName: (ctx) => Dashboard(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == FocusScreen.routeName)
          return PageRouteBuilder(pageBuilder: (_, __, ___) => FocusScreen());
        return null;
      },
    );
  }
}
