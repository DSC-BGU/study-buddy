import 'package:flutter/material.dart';
import 'package:study_buddy/models/Coupon.dart';
import '../models/Store.dart' as St;
import '../widgets/Coupons/StoreCoupon.dart';

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
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text(
            '${store.name}',
          ),
          backgroundColor: Colors.black,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(store.imageUrl, fit: BoxFit.cover),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 150.0,
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
