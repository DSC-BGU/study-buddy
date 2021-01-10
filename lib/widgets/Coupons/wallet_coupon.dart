import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Coupon.dart';
import '../../models/PurchasedCoupon.dart';
import '../../providers/StoreProvider.dart';

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
        margin: EdgeInsets.only(bottom: 8),
        height: constraints.maxWidth * 0.30,
        child: Stack(
          children: [
            Image.network(
              coupon.imageUrl,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.black38,
                  child: Text(
                    coupon.description,
                    style: TextStyle(color: Colors.white, fontSize: 26),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
