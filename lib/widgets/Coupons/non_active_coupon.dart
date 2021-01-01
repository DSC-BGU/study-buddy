import 'dart:ui';

import 'package:flutter/material.dart';
import '../../models/PurchasedCoupon.dart';

class NonActiveCoupon extends StatelessWidget {
  final PurchasedCoupon usedCoupon;

  NonActiveCoupon({@required this.usedCoupon});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        height: constraints.maxWidth * 0.30,
        child: Stack(children: [
          Image.network(
            this.usedCoupon.coupon.imageUrl,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              width: double.infinity,
              color: Colors.black38,
              child: Text(
                this.usedCoupon.coupon.description,
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
            ),
          ])
        ]),
      );
    });
  }
}
