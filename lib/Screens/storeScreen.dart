import 'package:flutter/material.dart';
import 'package:study_buddy/models/store.dart';
import 'package:study_buddy/widgets/Coupons/StoreCoupon.dart';

//import 'package:study_buddy/widgets/SingleCoupon.dart';

class StoreScreen extends StatelessWidget {
  static const routeName = '/store-detail';
  Store store;

  StoreScreen({this.store});

  @override
  Widget build(BuildContext context) {
    List<StoreCoupon> list = store.coupons.map((e) => StoreCoupon(
          coupon: e,
        ));
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
