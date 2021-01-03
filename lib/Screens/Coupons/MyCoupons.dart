import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/Coupons/user_available_coupons.dart';
import '../../widgets/Coupons/user_used_coupons.dart';
import '../../providers/user_provider.dart';
import '../../app_localizations.dart';

class MyCoupons extends StatelessWidget {
  MyCoupons();

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    List<String> myAvailableCoupons =
        userProvider.getAvailableCoupons(); // purchasedCoupon id's list
    List<String> myUsedCoupons =
        userProvider.getUsedCoupons(); // Coupon id's list
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
          UserAvailableCoupons(myAvailableCoupons), // ?? null,
          UserUsedCoupons(myUsedCoupons), // ?? null,
        ]),
      ),
    );
  }
}
