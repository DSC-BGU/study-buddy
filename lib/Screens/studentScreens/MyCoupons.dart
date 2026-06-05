import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/widgets/designs/Background.dart';

import '../../widgets/designs/Background.dart';
import '../../widgets/studentWidgets/Coupons/user_wallet_coupons.dart';
import '../../models/studentModels/couponModels/PurchasedCoupon.dart';
import '../../providers/studentProviders/user_provider.dart';
import '../../app_localizations.dart';
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

    // return Scaffold(
    //   backgroundColor: Theme.of(context).backgroundColor,
    //   drawer: AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
    //   endDrawer: !AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
    //   body: SafeArea(
    //     child: LayoutBuilder(
    //       builder: (ctx, constraints) {
    //         return Stack(
    //           children: [
    //             Background(),
    //             Column(
    //               children: [
    //                 Container(
    //                   child: Center(
    //                       child: Text(
    //                     t('My Coupons'),
    //                     style: TextStyle(fontSize: 25),
    //                   )),
    //                   height: constraints.maxHeight * 0.09,
    //                 ),
    //                 Expanded(
    //                     child: UserWalletCoupons(myAvailablePurchasedCoupons)),
    //               ],
    //             ),
    //             DrawerButton(),
    //           ],
    //         );
    //       },
    //     ),
    //   ),
    // );
    return Scaffold(
      drawer: AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
      endDrawer: !AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        title: Text(
          t('My Coupons'),
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
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
          body: Stack(children: [
            Background(),
            TabBarView(children: [
              UserWalletCoupons(myAvailablePurchasedCoupons),
              UserWalletCoupons(myUsedPurchasedCoupons),
            ]),
          ]),
        ),
      ),
    );
  }
}
