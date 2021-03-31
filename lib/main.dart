import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/Screens/businessScreens/BusinessMainScreen.dart';
import 'package:study_buddy/Screens/businessScreens/ScannerScreen.dart';
import 'package:study_buddy/Screens/studentScreens/MyCoupons.dart';
import 'package:study_buddy/utils/HexColor.dart';
import 'package:study_buddy/utils/analyticsService.dart';

import './app_localizations.dart';

import './Screens/studentScreens/TabsScreen.dart';
import './Screens/studentScreens/storeScreen.dart';
import './Screens/studentScreens/categories_screen.dart';
import './Screens/studentScreens/MainScreen/Dashboard.dart';
import './Screens/studentScreens/category_stores_screen.dart';
import './Screens/studentScreens/FocusScreen/FocusScreen.dart';
import './Screens/studentScreens/FocusScreen/ResultScreen.dart';
import './Screens/sharedScreens/Authentication/auth_screen.dart';
import './Screens/sharedScreens/Authentication/WelcomeScreen.dart';

import './providers/studentProviders/points.dart';
import './providers/studentProviders/user_provider.dart';
import './providers/studentProviders/FocusProvider.dart';
import './providers/sharedProviders/StoreProvider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

GetIt locator = GetIt.instance;

void setupSingletons() async {
  locator.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  setupSingletons();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => Points()),
        ChangeNotifierProvider(create: (context) => StoreProvider()),
        ChangeNotifierProvider(create: (context) => FocusProvider()),
      ],
      child: MaterialApp(
        title: 'Paid Attention',
        navigatorObservers: [
          locator<AnalyticsService>().getAnalyticsObserver()
        ],
        theme: ThemeData(
          primaryColor: HexColor("#F3D24F"),
          accentColor: HexColor("#FF8485"),
          hintColor: HexColor("#1E2230"),
          backgroundColor: HexColor("#5CA2D5"),
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
          '/': (ctx) => StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.hasData) {
                    UserProvider userProvider = Provider.of<UserProvider>(ctx);
                    if (userProvider.business) {
                      return BusinessMainScreen();
                    }
                    return FocusScreen();
                  }
                  return WelcomeScreen();
                },
              ),
          FocusScreen.routeName: (ctx) => FocusScreen(),
          MyCoupons.routeName: (ctx) => MyCoupons(),
          Dashboard.routeName: (ctx) => Dashboard(),
          CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
          CategoryStoresScreen.routeName: (ctx) => CategoryStoresScreen(),
          StoreScreen.routeName: (ctx) => StoreScreen(),
          ResultScreen.routeName: (ctx) => ResultScreen(),
          ScannerScreen.routeName: (ctx) => ScannerScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
          'tabScreen': (ctx) => TabsScreen()
        },
      ),
    );
  }
}
