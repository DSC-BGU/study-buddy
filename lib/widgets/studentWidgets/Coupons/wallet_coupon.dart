import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/sharedProviders/StoreProvider.dart';
import '../../../models/studentModels/couponModels/Coupon.dart';
import '../../../models/studentModels/couponModels/PurchasedCoupon.dart';

class WalletCoupon extends StatelessWidget {
  final PurchasedCoupon purchasedCoupon;

  WalletCoupon({
    @required this.purchasedCoupon,
  });

  @override
  Widget build(BuildContext context) {
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);
    Coupon coupon = storeProvider.getCouponById(purchasedCoupon.couponId);
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: EdgeInsets.all(8),
        height: constraints.maxWidth * 0.40,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.network(
                coupon.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  // height: constraints.maxWidth * 0.40,
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  // width: double.infinity,
                  child: Column(children: [
                    Text(
                      "  " + coupon.description,
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
