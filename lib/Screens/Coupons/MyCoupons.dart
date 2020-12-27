import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/models/Coupon.dart';
import 'package:study_buddy/models/User.dart';
import 'package:study_buddy/widgets/Coupons/CouponStatus.dart';

class MyCoupons extends StatelessWidget {
  MyCoupons();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    List<Coupon> usedCoupons = user.usedCoupons();
    List<Coupon> availableCoupons = user.availableCoupons();
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
