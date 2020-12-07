import 'package:flutter/material.dart';
import 'package:study_buddy/dummy_data.dart';
import 'package:study_buddy/models/Coupon.dart';
import 'package:study_buddy/widgets/SingleCoupon.dart';
import 'PopUpQR.dart';

class MyCoupons extends StatelessWidget {
  final List<Coupon> myCoupons = DUMMY_COUPONS;

  MyCoupons();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (ctx) => PopUpQR(ctx, myCoupons[index].title));
          },
          child: SingleCoupon(
            id: myCoupons[index].id,
            title: myCoupons[index].title,
            storeId: myCoupons[index].storeId,
            description: myCoupons[index].description,
            imageUrl: myCoupons[index].imageUrl,
            points: myCoupons[index].points,
            categories: myCoupons[index].categories,
          ),
        );
      },
      itemCount: myCoupons.length,
    );
  }
}
