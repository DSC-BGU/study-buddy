import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/services/DB.dart';

import './providers/points.dart';
import './app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './dummy_data.dart';

import './Screens/categories_screen.dart';
import './Screens/category_stores_screen.dart';
import './Screens/storeScreen.dart';
import './Screens/FocusScreen/FocusScreen.dart';
import './Screens/TabsScreen.dart';
import './Screens/MainScreen/Dashboard.dart';
import './Screens/auth_screen.dart';

import 'models/Coupon.dart';
import 'models/store.dart';
import 'models/User.dart' as Student;
import 'providers/Coupon_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<Coupon> _availableCoupons = DUMMY_COUPONS;
  List<Store> _availableStores = DUMMY_STORES;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final db = DatabaseService();
    return MultiProvider(
      providers: [
        StreamProvider<Student.User>.value(value: db.streamUser('test')),
        ChangeNotifierProvider(create: (context) => Points()),
        ChangeNotifierProvider(create: (context) => Coupon_provider()),
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
        // initialRoute: '/',
        routes: {
          '/': (ctx) => StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.hasData) {
                    return TabsScreen();
                  }
                  return AuthScreen();
                },
              ),
          FocusScreen.routeName: (ctx) => FocusScreen(),
          Dashboard.routeName: (ctx) => Dashboard(),
          CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
          CategoryStoresScreen.routeName: (ctx) =>
              CategoryStoresScreen(_availableStores),
          StoreScreen.routeName: (ctx) => StoreScreen(),
        },
      ),
    );
  }
}
