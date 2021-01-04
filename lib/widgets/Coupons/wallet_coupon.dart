import 'package:flutter/material.dart';
import '../../models/Coupon.dart';
import 'dart:ui';

class WalletCoupon extends StatelessWidget {
  final Coupon coupon;

  WalletCoupon({
    @required this.coupon,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        height: constraints.maxWidth * 0.30,
        child: Stack(children: [
          // Image.network(
          //   coupon.imageUrl ?? null,
          //   width: double.infinity,
          //   fit: BoxFit.fitWidth,
          // ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              width: double.infinity,
              color: Colors.black38,
              child: Text(
                coupon.description,
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
            ),
          ])
        ]),
      );
    });
  }
}
