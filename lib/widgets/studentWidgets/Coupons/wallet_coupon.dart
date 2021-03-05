import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);
    Coupon coupon = storeProvider.getCouponById(purchasedCoupon.couponId);
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        margin: EdgeInsets.all(8),
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
                    Text(
                      '  ' +
                          storeProvider.getStoreById(coupon.storeId).name +
                          '\n',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '  ' + coupon.title,
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    Text(
                      '  ' + coupon.description,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      '  points: ' + coupon.points.toString() + ' ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '  ' +
                          DateFormat('dd/MM/yyyy')
                              .format(purchasedCoupon.datePurhcased),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ]),
            ),
          ],
        ),
      );
    });
  }
}
