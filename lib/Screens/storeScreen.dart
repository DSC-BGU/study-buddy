import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/models/Coupon.dart';
import 'package:study_buddy/providers/Coupon_provider.dart';
import 'package:study_buddy/widgets/SingleCoupon.dart';
import '../dummy_data.dart';
import 'package:study_buddy/models/store.dart';
//import 'package:study_buddy/widgets/SingleCoupon.dart';

class StoreScreen extends StatelessWidget {
  static const routeName = '/store-detail';

  StoreScreen();

  List<Coupon> displayeCoupons = DUMMY_COUPONS;

  @override
  Widget build(BuildContext context) {
    List<SingleCoupon> list = [];

    final storeId = ModalRoute.of(context).settings.arguments as String;
    Coupon_provider coupon_provider = Provider.of(context);
    List<Coupon> couponList = coupon_provider.storesCoupons(storeId);

    for (Coupon c in couponList) {
      list.add(new SingleCoupon(
          id: c.id,
          title: c.title,
          storeId: c.storeId,
          description: c.description,
          imageUrl: c.imageUrl,
          points: c.points,
          categories: c.categories));
    }
    ;

    final selectedStore =
        DUMMY_STORES.firstWhere((store) => store.id == storeId);
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
