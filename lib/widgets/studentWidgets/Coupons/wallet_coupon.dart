import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/app_localizations.dart';
import '../../../providers/sharedProviders/StoreProvider.dart';
import '../../../models/studentModels/couponModels/Coupon.dart';
import '../../../models/studentModels/couponModels/PurchasedCoupon.dart';
import 'package:intl/intl.dart';

class WalletCoupon extends StatelessWidget {
  final PurchasedCoupon purchasedCoupon;

  WalletCoupon({
    @required this.purchasedCoupon,
  });

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);
    Coupon coupon = storeProvider.getCouponById(purchasedCoupon.couponId);
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.white, width: 5)),
        margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
        height: constraints.maxWidth * 0.5,
        child: Stack(
          children: [
            ClipRRect(
              child: Image.network(
                coupon.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: constraints.maxWidth * 0.45,
              height: constraints.maxWidth * 0.5,
              color: Colors.black54,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5, left: 5),
                      child: Text(
                        t(storeProvider.getStoreById(coupon.storeId).name) +
                            '\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5, left: 5),
                      child: Text(
                        t(coupon.title),
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5, left: 5),
                      child: Text(
                        t(coupon.description),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5, left: 5),
                      child: Text(
                        t('points: ') + coupon.points.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5, left: 5),
                      child: Text(
                        DateFormat('dd/MM/yyyy')
                            .format(purchasedCoupon.datePurhcased),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      );
    });
  }
}
