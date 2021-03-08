import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';
import './PopUpQR.dart';
import './wallet_coupon.dart';
import '../../../models/studentModels/couponModels/PurchasedCoupon.dart';

class UserWalletCoupons extends StatelessWidget {
  final List<PurchasedCoupon> purchasedCoupons;

  UserWalletCoupons(this.purchasedCoupons);

  @override
  Widget build(BuildContext context) {
    // UserProvider userProvider = Provider.of<UserProvider>(context);
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return
            // InkWell( // Omri - Roei: you can use Ink wall if you want to add animation for the tap - but it's for your opinion
            GestureDetector(
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
