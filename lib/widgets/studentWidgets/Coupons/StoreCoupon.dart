import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';
import '../../../app_localizations.dart';
import './PopUpBuy.dart';
import '../../../models/studentModels/couponModels/Coupon.dart';

class StoreCoupon extends StatelessWidget {
  final Coupon coupon;

  StoreCoupon({@required this.coupon});

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        height: constraints.maxWidth * 0.5,
        margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.white, width: 5)),
          child: Stack(children: [
            ClipRRect(
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
                  Container(
                    width: constraints.maxWidth * 0.45,
                    height: constraints.maxWidth * 0.48,
                    color: Colors.black54,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '  ' + coupon.title,
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          Text(
                            coupon.description,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            t('points') + ':' + coupon.points.toString() + ' ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Center(
                            child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0))),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Theme.of(context).accentColor)),
                                onPressed: () {
                                  if (!userProvider.business) {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => PopUpBuy(
                                              ctx,
                                              coupon,
                                            ));
                                  } else {}
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  t('Buy Coupon'),
                                  style: TextStyle(color: Colors.black),
                                )),
                          )
                        ]),
                  ),
                ])
          ]),
        ),
      );
    });
  }
}
