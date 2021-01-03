import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Coupon.dart';
import '../../providers/user_provider.dart';
import '../../app_localizations.dart';

class PopUpBuy extends StatelessWidget {
  final BuildContext contex;
  final Coupon coupon;
  // String couponTitle;
  // int couponPoints;

  PopUpBuy(
    this.contex,
    this.coupon,
  );
  // {
  //   getCouponData();
  // }

  // Future<void> getCouponData() async {
  //   FirebaseFirestore.instance
  //       .collection('coupons')
  //       .doc(coupon)
  //       .snapshots()
  //       .listen((event) {
  //     final couponData = event.data();
  //     this.couponTitle = couponData['title'];
  //     this.couponPoints = couponData['points'];
  //   });
  // }

  void buyCoupon(BuildContext context, UserProvider userProvider) {
    Navigator.pop(context);
    if (userProvider.points >= coupon.points /*this.couponPoints*/) {
      userProvider.buyCoupon(coupon);
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String t(String text) => AppLocalizations.of(context).translate(text);
    return LayoutBuilder(builder: (ctx, constraints) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        backgroundColor: Colors.black45,
        insetPadding: EdgeInsets.fromLTRB(0, 200, 0, 200),
        title: Center(
            child: Text(
          t('You are buying Coupon'),
          style: TextStyle(color: Colors.white),
        )),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(this.coupon.title, //couponTitle,
                style: TextStyle(color: Colors.white, fontSize: 24)),
            Container(
              height: constraints.maxHeight * 0.07,
              width: constraints.maxWidth * 0.48,
              child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.grey)),
                child: Text(
                  t('Are you sure?'),
                  style: TextStyle(fontSize: 19),
                ),
                onPressed: () => buyCoupon(context, userProvider),
              ),
            ),
          ],
        ),
      );
    });
  }
}
