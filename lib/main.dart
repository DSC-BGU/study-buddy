import 'package:flutter/material.dart';
import 'package:study_buddy/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './Screens/MainScreen/MainScreen.dart';
import './Screens/categories_screen.dart';

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
      initialRoute: CategoriesScreen.routName, //'/',
      routes: {
        // '/': (ctx) => MainScreen(),
        CategoriesScreen.routName: (ctx) => CategoriesScreen(),
      },
    );
  }
}
