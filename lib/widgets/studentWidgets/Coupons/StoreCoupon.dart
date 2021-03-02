import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';
import './PopUpBuy.dart';
import '../../../models/studentModels/couponModels/Coupon.dart';

class StoreCoupon extends StatelessWidget {
  final Coupon coupon;

  StoreCoupon({@required this.coupon});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return LayoutBuilder(builder: (ctx, constraints) {
      return GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            margin: EdgeInsets.all(6),
            child: Container(
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.network(
                    this.coupon.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                          onPressed: null,
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor)),
                          icon: Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                          label: Text(
                            '${coupon.points}',
                            style: TextStyle(color: Colors.white),
                          )),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          width: double.infinity,
                          child: Text(
                            "  " + this.coupon.description,
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          )),
                    ])
              ]),
            ),
          ),
          onTap: () {
            if (!userProvider.business) {
              showDialog(
                  context: context,
                  builder: (ctx) => PopUpBuy(
                        ctx,
                        coupon,
                      ));
            } else {}
          });
    });
  }
}
