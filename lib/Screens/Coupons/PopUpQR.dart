import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/models/PurchasedCoupon.dart';
import 'package:study_buddy/providers/user_provider.dart';

import '../../app_localizations.dart';

class PopUpQR extends StatelessWidget {
  final BuildContext ctx;
  final PurchasedCoupon coupon;
  PopUpQR(this.ctx, this.coupon);

  void useCoupon(BuildContext context) {
    Navigator.pop(context);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.useCoupon(coupon);
  }

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
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
            Text('${this.coupon.coupon.title}',
                style: TextStyle(color: Colors.white, fontSize: 24)),
            Container(
              height: constraints.maxHeight * 0.27,
              width: constraints.maxWidth * 0.42,
              child: Card(
                child: Center(
                  child: Text(
                    'QR',
                    style: TextStyle(fontSize: 40),
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
