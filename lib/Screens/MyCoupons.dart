import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/Coupons/user_wallet_coupons.dart';
import '../providers/user_provider.dart';
import '../models/PurchasedCoupon.dart';
import '../app_localizations.dart';

class MyCoupons extends StatelessWidget {
  MyCoupons();

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    List<PurchasedCoupon> myAvailablePurchasedCoupons =
        userProvider.getMyAvailablePurchasedCoupons();
    List<PurchasedCoupon> myUsedPurchasedCoupons =
        userProvider.getMyUsedPurchasedCoupons();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: [
              Tab(
                text: t('Available'),
              ),
              Tab(
                text: t('Used'),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          UserWalletCoupons(myAvailablePurchasedCoupons),
          UserWalletCoupons(myUsedPurchasedCoupons),
        ]),
      ),
    );
  }
}
