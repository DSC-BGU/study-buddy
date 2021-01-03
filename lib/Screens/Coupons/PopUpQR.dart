import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../app_localizations.dart';
import '../../providers/user_provider.dart';
import '../../providers/Coupon_provider.dart';
import '../../providers/purchased_coupon_provider.dart';

class PopUpQR extends StatelessWidget {
  final BuildContext ctx;
  final String couponId;
  // String couponTitle;
  PopUpQR(
    this.ctx,
    this.couponId,
  );
  //  {
  //   getCouponData();
  // // }
  // Future<void> getCouponData() async {
  //   FirebaseFirestore.instance
  //       .collection('coupons')
  //       .doc(purchasedCouponId)
  //       .snapshots()
  //       .listen((event) {
  //     final couponData = event.data();
  //     this.couponTitle = couponData['title'];
  //   });
  // }

  void useCoupon(BuildContext context) {
    Navigator.pop(context);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.useCoupon(couponId);
  }

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    PurchasedCouponProvider purchasedCouponProvider =
        PurchasedCouponProvider(this.couponId);
    //   Provider.of<PurchasedCouponProvider>(context);
    // purchasedCouponProvider.getCouponData(this.couponId);
    String couponId = purchasedCouponProvider.couponId;
    print('couponId: ' + couponId);
    CouponProvider couponProvider =
        CouponProvider(couponId); // Provider.of<CouponProvider>(context);
    // couponProvider.getCouponData(couponId);
    String couponTitle = couponProvider.title;
    return LayoutBuilder(builder: (ctx, constraints) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        backgroundColor: Colors.black45,
        insetPadding: EdgeInsets.fromLTRB(0, 100, 0, 120),
        title: Center(
            child: Text(
          t('Present This Code'),
          style: TextStyle(color: Colors.white),
        )),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(couponTitle,
                style: TextStyle(color: Colors.white, fontSize: 24)),
            Container(
              height: constraints.maxHeight * 0.27,
              width: constraints.maxWidth * 0.42,
              child: Card(
                child: Center(
                  child: QrImage(
                    data: this.couponId,
                  ),
                ),
              ),
            ),
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
                  t('Got it, Thanks'),
                  style: TextStyle(fontSize: 19),
                ),
                onPressed: () => useCoupon(context),
              ),
            )
          ],
        ),
      );
    });
  }
}
