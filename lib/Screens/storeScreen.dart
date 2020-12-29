import 'package:flutter/material.dart';
import '../models/Store.dart' as st;
import '../widgets/Coupons/StoreCoupon.dart';

class StoreScreen extends StatelessWidget {
  static const routeName = '/store-detail';
  st.Store store;

  StoreScreen();

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments;
    this.store = routeArgs;
    List<StoreCoupon> list = store.coupons
        .map((e) => StoreCoupon(
              coupon: e,
            ))
        .toList();
    final selectedStore = this.store;
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text(
            '${selectedStore.name}',
          ),
          backgroundColor: Colors.black,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background:
                Image.network(selectedStore.imageUrl, fit: BoxFit.cover),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildListDelegate(
            list,
          ),
        ),
      ],
    ));
  }
}
