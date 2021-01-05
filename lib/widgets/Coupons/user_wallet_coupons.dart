import 'package:flutter/material.dart';
import '../../models/PurchasedCoupon.dart';
import './wallet_coupon.dart';
import './PopUpQR.dart';

class UserWalletCoupons extends StatelessWidget {
  final List<PurchasedCoupon> purchasedCoupons;

  UserWalletCoupons(this.purchasedCoupons);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        //   return WalletCoupon(purchasedCoupon: purchasedCoupons[index]);
        // },
        return GestureDetector(
          onTap: () {
            if (!purchasedCoupons[index].used) {
              showDialog(
                context: ctx,
                builder: (ctx) => PopUpQR(ctx, purchasedCoupons[index]),
              );
            }
          },
          child: WalletCoupon(purchasedCoupon: purchasedCoupons[index]),
        );
      },
      itemCount: purchasedCoupons.length,
    );
  }
}
