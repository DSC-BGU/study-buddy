import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/points.dart';
import './app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './dummy_data.dart';

import './Screens/categories_screen.dart';
import './Screens/category_cupons_screen.dart';
import './Screens/category_stores_screen.dart';
import './Screens/storeScreen.dart';
import './Screens/FocusScreen/FocusScreen.dart';
import './Screens/TabsScreen.dart';
import './Screens/MainScreen/Dashboard.dart';

import './models/my_coupon.dart';
import './models/store.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<MyCoupon> _availableCoupons = DUMMY_COUPONS;
  List<Store> _availableStores = DUMMY_STORES;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Points()),
      ],
      child: MaterialApp(
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
          CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
          CategoryCuponsScreen.routeName: (ctx) =>
              CategoryCuponsScreen(_availableCoupons),
          CategoryStoresScreen.routeName: (ctx) =>
              CategoryStoresScreen(_availableStores),
          StoreScreen.routeName: (ctx) => StoreScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == FocusScreen.routeName)
            return PageRouteBuilder(pageBuilder: (_, __, ___) => FocusScreen());
          return null;
        },
      ),
    );
  }
}
