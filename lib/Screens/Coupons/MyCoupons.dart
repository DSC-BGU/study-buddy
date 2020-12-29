import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Coupon.dart';
import '../../providers/user_provider.dart';
import '../../widgets/Coupons/CouponStatus.dart';

class MyCoupons extends StatelessWidget {
  MyCoupons();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    List<Coupon> usedCoupons = userProvider.myUsedCoupons;
    List<Coupon> availableCoupons = userProvider.myCoupons;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: [
              Tab(
                text: 'Used',
              ),
              Tab(
                text: 'Available',
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          CouponStatus(usedCoupons, true),
          CouponStatus(availableCoupons, false)
        ]),
      ),
    );
  }
}
