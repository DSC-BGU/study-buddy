import 'package:flutter/material.dart';
import 'package:study_buddy/widgets/designs/Background.dart';
import '../../app_localizations.dart';
import '../../models/sharedModels/Store.dart' as St;
import '../../widgets/studentWidgets/Coupons/StoreCoupon.dart';
import 'DrawerButton.dart';
import 'DrawerMenu.dart';

class StoreScreenArguments {
  StoreScreenArguments();
}

class StoreScreen extends StatelessWidget {
  static const routeName = '/store-detail';
  StoreScreen();

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    final routeArgs = ModalRoute.of(context).settings.arguments;
    St.Store store = routeArgs;
    List<StoreCoupon> list =
        store.coupons.map((e) => StoreCoupon(coupon: e)).toList();
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
        endDrawer: !AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
        body: SafeArea(child: LayoutBuilder(
          builder: (ctx, constraints) {
            return Stack(children: [
              Background(),
              Column(children: [
                Container(
                  height: constraints.maxHeight * 0.18,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          '\n' + t(store.name),
                          style: TextStyle(fontSize: 25),
                        ),
                        Text(
                          t(store.address),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          t(store.description),
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverFixedExtentList(
                        itemExtent: 220.0,
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return list[index];
                          },
                          childCount: list.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              DrawerButton(),
            ]);
          },
        )));
  }
}
