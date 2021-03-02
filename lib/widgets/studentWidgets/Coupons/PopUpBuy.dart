import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app_localizations.dart';
import '../../../models/studentModels/couponModels/Coupon.dart';
import '../../../providers/studentProviders/user_provider.dart';

class PopUpBuy extends StatelessWidget {
  final BuildContext contex;
  final Coupon coupon;

  PopUpBuy(
    this.contex,
    this.coupon,
  );

  void buyCoupon(BuildContext context, UserProvider userProvider) {
    Navigator.pop(context);
    if (userProvider.points >= coupon.points) {
      // Fluttertoast.showToast(
      //     msg: "Coupon Added",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1);
      userProvider.buyCoupon(coupon);
    } else {
      // Fluttertoast.showToast(
      //     msg: "You don't have enough points",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
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
            Text(this.coupon.title,
                style: TextStyle(color: Colors.white, fontSize: 24)),
            Text(
              this.coupon.points.toString() + " pts",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            Text(
              t('Are you sure?'),
              style: TextStyle(color: Colors.white, fontSize: 19),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: TextButton(
                      onPressed: () => buyCoupon(context, userProvider),
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.black),
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.black),
                      )),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
