import 'dart:ui';

import 'package:flutter/material.dart';
import '../../Screens/Coupons/PopUpBuy.dart';
import '../../models/Coupon.dart';

class StoreCoupon extends StatelessWidget {
  final Coupon coupon;

  StoreCoupon({@required this.coupon});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return GestureDetector(
          child: Container(
            margin: EdgeInsets.only(bottom: 8),
            height: constraints.maxWidth * 0.30,
            child: Stack(children: [
              Image.network(
                this.coupon.imageUrl,
                width: double.infinity,
                fit: BoxFit.fitWidth,
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
                        width: double.infinity,
                        color: Colors.black38,
                        child: Text(
                          this.coupon.description,
                          style: TextStyle(color: Colors.white, fontSize: 26),
                        )),
                  ])
            ]),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (ctx) => PopUpBuy(
                      ctx,
                      coupon,
                    ));
          });
    });
  }
}
