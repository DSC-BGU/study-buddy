import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/widgets/designs/Background.dart';

import '../../widgets/studentWidgets/Coupons/user_wallet_coupons.dart';
import '../../models/studentModels/couponModels/PurchasedCoupon.dart';
import '../../providers/studentProviders/user_provider.dart';
import '../../app_localizations.dart';
import 'DrawerButton.dart';
import 'DrawerMenu.dart';

class MyCoupons extends StatelessWidget {
  static const routeName = '/wallet';
  MyCoupons();

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    List<PurchasedCoupon> myAvailablePurchasedCoupons =
        userProvider.getMyAvailablePurchasedCoupons();
    List<PurchasedCoupon> myUsedPurchasedCoupons =
        userProvider.getMyUsedPurchasedCoupons();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
      endDrawer: !AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
      // body: Scaffold(
      body: Stack(children: [
        Background(),
        Scaffold(
          body: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
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
          ),
        ),
      ]),
      // ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [Text('My Wallet '), Icon(Icons.wallet_giftcard)]),
    //   ),
    //   body: Scaffold(
    //     body: DefaultTabController(
    //       length: 2,
    //       child: Scaffold(
    //         backgroundColor: Theme.of(context).backgroundColor,
    //         appBar: AppBar(
    //           automaticallyImplyLeading: false,
    //           title: TabBar(
    //             tabs: [
    //               Tab(
    //                 text: t('Available'),
    //               ),
    //               Tab(
    //                 text: t('Used'),
    //               ),
    //             ],
    //           ),
    //         ),
    //         body: TabBarView(children: [
    //           UserWalletCoupons(myAvailablePurchasedCoupons),
    //           UserWalletCoupons(myUsedPurchasedCoupons),
    //         ]),
    //       ),
    //     ),
    //   ),
    // );
  }
}
