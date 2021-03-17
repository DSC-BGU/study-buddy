import 'package:flutter/foundation.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../../app_localizations.dart';
import '../../../providers/sharedProviders/StoreProvider.dart';
import '../../../providers/studentProviders/user_provider.dart';
import '../../../models/studentModels/couponModels/Coupon.dart';
import '../../../models/studentModels/couponModels/PurchasedCoupon.dart';

class PopUpQR extends StatelessWidget {
  final BuildContext ctx;
  final PurchasedCoupon purchasedCoupon;
  PopUpQR(
    this.ctx,
    this.purchasedCoupon,
  );

  void useCoupon(BuildContext context, UserProvider userProvider) {
    Navigator.pop(context);
    userProvider.useCoupon(purchasedCoupon.id);
  }

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);
    Coupon coupon = storeProvider.getCouponById(
        this.purchasedCoupon.couponId); // attention: return value can be null
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
            Text(coupon.title,
                style: TextStyle(color: Colors.white, fontSize: 24)),
            Container(
              height: constraints.maxHeight * 0.27,
              width: constraints.maxWidth * 0.42,
              child: Card(
                child: Center(
                  child: QrImage(
                    data: this.purchasedCoupon.id,
                  ),
                ),
              ),
            ),
            kReleaseMode
                ? null
                : Container(
                    height: constraints.maxHeight * 0.07,
                    width: constraints.maxWidth * 0.48,
                    child: TextButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      child: Text(
                        t('Got it, Thanks'),
                        style: TextStyle(fontSize: 19),
                      ),
                      onPressed: () => useCoupon(context, userProvider),
                    ),
                  ),
          ],
        ),
      );
    });
  }
}
