import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/models/studentModels/couponModels/Coupon.dart';
import 'package:study_buddy/providers/sharedProviders/StoreProvider.dart';

class BusinessCoupon extends StatelessWidget {
  final Coupon coupon;

  BusinessCoupon({@required this.coupon});
  @override
  Widget build(BuildContext context) {
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);
    return LayoutBuilder(builder: (ctx, constraints) {
      return Dismissible(
        key: Key(coupon.id),
        onDismissed: (direction) {
          storeProvider.removeCoupon(coupon.id);
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("${coupon.title} dismissed")));
        },
        background: Container(
          color: Theme.of(context).accentColor,
          child: Icon(Icons.delete),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: EdgeInsets.fromLTRB(17, 7, 17, 7),
          child: Container(
            height: constraints.maxWidth * 0.20,
            width: double.infinity,
            margin: EdgeInsets.all(6),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                coupon.title,
                style: TextStyle(fontSize: 34),
              ),
              Text(
                coupon.description,
                style: TextStyle(fontSize: 28),
              )
            ]),
          ),
        ),
      );
    });
  }
}
