import 'package:flutter/material.dart';
import '../../models/sharedModels/Store.dart' as St;
import '../../widgets/studentWidgets/Coupons/StoreCoupon.dart';

class StoreScreenArguments {
  StoreScreenArguments();
}

class StoreScreen extends StatelessWidget {
  static const routeName = '/store-detail';
  StoreScreen();

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments;
    St.Store store = routeArgs;
    List<StoreCoupon> list =
        store.coupons.map((e) => StoreCoupon(coupon: e)).toList();
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(store.name + ' '), Icon(Icons.store)]),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              title: Container(
                color: Colors.black54,
                child: Text(
                  '${store.address}\n${store.description}',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
              backgroundColor: Colors.black,
              expandedHeight: 100.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.network(store.imageUrl, fit: BoxFit.cover),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 220.0,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return list[index];
                },
                childCount: list.length,
              ),
              // delegate: SliverChildListDelegate(
              //   list,
              // ),
            ),
          ],
        ));
  }
}
