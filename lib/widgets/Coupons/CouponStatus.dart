import 'package:flutter/material.dart';
import '../../Screens/Coupons/PopUpQR.dart';
import '../../models/Coupon.dart';
import './SingleCoupon.dart';

class CouponStatus extends StatelessWidget {
  final List<Coupon> coupons;
  final bool status;

  CouponStatus(this.coupons, this.status);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: () {
            if (status) {
              return null;
            } else {
              showDialog(
                  context: context,
                  builder: (ctx) => PopUpQR(ctx, coupons[index].title));
            }
          },
          child: SingleCoupon(coupon: coupons[index]),
        );
      },
      itemCount: coupons.length,
    );
  }
}
