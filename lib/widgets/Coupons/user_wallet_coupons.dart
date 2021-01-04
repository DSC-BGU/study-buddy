import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Coupon.dart';
import '../../models/PurchasedCoupon.dart';
import '../../providers/StoreProvider.dart';
import '../../Screens/Coupons/PopUpQR.dart';
import './wallet_coupon.dart';

class UserWalletCoupons extends StatelessWidget {
  final List<PurchasedCoupon> purchasedCouponsId;

  UserWalletCoupons(this.purchasedCouponsId);

  @override
  Widget build(BuildContext context) {
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);

    ListView.builder(
      itemBuilder: (ctx, index) {
        Coupon coupon = storeProvider.getCouponById(purchasedCouponsId[index]
            .couponId); // attention: return value can be null
        if (coupon != null) {
          return GestureDetector(
            onTap: () {
              if (!purchasedCouponsId[index].used) {
                showDialog(
                  context: ctx,
                  builder: (ctx) => PopUpQR(ctx, purchasedCouponsId[index]),
                );
              }
            },
            child: WalletCoupon(coupon: coupon),
          );
        }
      },
      itemCount: purchasedCouponsId.length,
    );
  }
}
