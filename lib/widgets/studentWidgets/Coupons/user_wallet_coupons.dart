import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/Screens/studentScreens/DrawerButton.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';
import 'package:study_buddy/widgets/designs/Background.dart';
import '../../../app_localizations.dart';
import './PopUpQR.dart';
import './wallet_coupon.dart';
import '../../../models/studentModels/couponModels/PurchasedCoupon.dart';

class UserWalletCoupons extends StatelessWidget {
  final List<PurchasedCoupon> purchasedCoupons;

  UserWalletCoupons(this.purchasedCoupons);

  @override
  Widget build(BuildContext context) {
    // UserProvider userProvider = Provider.of<UserProvider>(context);
    String t(String text) => AppLocalizations.of(context).translate(text);

    return Stack(children: [
      LayoutBuilder(
        builder: (ctx, constraints) {
          return Stack(
            children: [
              Background(),
              Column(
                children: [
                  Container(
                    child: Center(
                        child: Text(
                      t('My Coupons'),
                      style: TextStyle(fontSize: 25),
                    )),
                    height: constraints.maxHeight * 0.09,
                  ),
                  Expanded(
                      child: UserWalletCoupons(myAvailablePurchasedCoupons)),
                ],
              ),
              DrawerButton(),
            ],
          );
        },
      )
    ]);

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
