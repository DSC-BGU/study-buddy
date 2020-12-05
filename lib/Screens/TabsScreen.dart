import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:study_buddy/Screens/Barcodes.dart';
import 'package:study_buddy/Screens/MainScreen/Dashboard.dart';
import 'package:study_buddy/Screens/store.dart';

import '../app_localizations.dart';

class TabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(t("Hi user")),
        ),
        body: TabBarView(
          children: <Widget>[StoreScreen(), Dashboard(), Barcodes()],
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            tabs: [
              Tab(
                icon: Icon(MaterialCommunityIcons.store),
                text: t('Store'),
              ),
              Tab(
                icon: Icon(MaterialCommunityIcons.clock_outline),
                text: t('Home'),
              ),
              Tab(
                icon: Icon(MaterialCommunityIcons.wallet),
                text: t('Coupons'),
              )
            ],
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
          ),
        ),
      ),
    );
  }
}
