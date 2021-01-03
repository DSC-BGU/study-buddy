import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import '../../providers/Coupon_provider.dart';

class UsedCoupon extends StatelessWidget {
  final String couponId;
  // String couponImageUrl;
  // String couponDescription;

  UsedCoupon({
    @required this.couponId,
  });
  //  {
  //   getCouponData();
  //   print(this.couponImageUrl);
  // }
  // Future<void> getCouponData() async {
  //   FirebaseFirestore.instance
  //       .collection('coupons')
  //       .doc(couponId)
  //       .snapshots()
  //       .listen((event) {
  //     final couponData = event.data();
  //     this.couponImageUrl = couponData['imageUrl'];
  //     this.couponDescription = couponData['description'];
  //   });
  // }

  // void selectCoupon(BuildContext context) {
  //   Navigator.of(context)
  //       .pushNamed(
  //     MealDetailScreen.routName,
  //     arguments: id,
  //   )
  //       .then((result) {
  //     if (result != null) {
  //       // removeItem(result);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    CouponProvider couponProvider =
        CouponProvider(this.couponId); // Provider.of<CouponProvider>(context);
    // couponProvider.getCouponData(this.couponId);
    String couponImageUrl = couponProvider.imageUrl;
    String couponDescription = couponProvider.description;

    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        height: constraints.maxWidth * 0.30,
        child: Stack(children: [
          Image.network(
            couponImageUrl,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              width: double.infinity,
              color: Colors.black38,
              child: Text(
                couponDescription,
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
            ),
          ])
        ]),
      );
    });
  }
}
