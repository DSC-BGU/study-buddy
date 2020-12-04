import 'package:flutter/material.dart';
import 'package:study_buddy/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:study_buddy/dummy_data.dart';

import './Screens/MainScreen/MainScreen.dart';
import './Screens/categories_screen.dart';
import './Screens/category_cupons_screen.dart';
import './Screens/category_stores_screen.dart';
import './Screens/storeScreen.dart';

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
      routes: {
        '/': (ctx) => MainScreen(),
        CategoriesScreen.routName: (ctx) => CategoriesScreen(),
        CategoryCuponsScreen.routName: (ctx) =>
            CategoryCuponsScreen(_availableCoupons),
        CategoryStoresScreen.routName: (ctx) =>
            CategoryStoresScreen(_availableStores),
        StoreScreen.routName: (ctx) => StoreScreen(),
      },
    );
  }
}
