import 'package:flutter/material.dart';
import './wallet_coupon.dart';

class UserWalletCoupons extends StatelessWidget {
  final List<String> coupons;
  final void Function(int index, BuildContext context, List<String> coupons)
      onTap;

  UserWalletCoupons(this.coupons, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: () => onTap(index, context, coupons),
          child: WalletCoupon(couponId: coupons[index]),
        );
      },
      itemCount: coupons.length,
    );
  }
}
