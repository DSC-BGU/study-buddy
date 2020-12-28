import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/providers/StoreProvider.dart';
import 'package:study_buddy/providers/user.dart';

import './providers/points.dart';
import './app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import './Screens/categories_screen.dart';
import './Screens/category_stores_screen.dart';
import './Screens/storeScreen.dart';
import './Screens/FocusScreen/FocusScreen.dart';
import './Screens/TabsScreen.dart';
import './Screens/MainScreen/Dashboard.dart';

import 'providers/Coupon_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    StoreProvider storeProvider = StoreProvider();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Points()),
        ChangeNotifierProvider(create: (context) => User()),
        ChangeNotifierProvider(create: (context) => Coupon_provider()),
        ChangeNotifierProvider(create: (context) => storeProvider),
      ],
      child: MaterialApp(
        title: 'Study Buddy',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
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
          CategoriesScreen.routeName: (ctx) =>
              CategoriesScreen(storeProvider.categories),
          CategoryStoresScreen.routeName: (ctx) =>
              CategoryStoresScreen(storeProvider.stores),
          StoreScreen.routeName: (ctx) => StoreScreen(),
        },
      ),
    );
  }
}
