import 'package:flutter/material.dart';
import 'package:study_buddy/models/Coupon.dart';

class PopUpBuy extends StatelessWidget {
  final BuildContext contex;
  final Coupon coupon;

  PopUpBuy(
    this.contex,
    this.coupon,
  );

  void buyCoupon(Coupon coupon) {}

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        backgroundColor: Colors.black45,
        insetPadding: EdgeInsets.fromLTRB(0, 200, 0, 200),
        title: Center(
            child: Text(
          'You are buying Coupon',
          style: TextStyle(color: Colors.white),
        )),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('${this.coupon.title}',
                style: TextStyle(color: Colors.white, fontSize: 24)),
            Container(
              height: constraints.maxHeight * 0.07,
              width: constraints.maxWidth * 0.48,
              child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(Colors.grey)),
                  onPressed: () => buyCoupon(coupon),
                  child: Text(
                    'Are you sure?',
                    style: TextStyle(fontSize: 19),
                  )),
            )
          ],
        ),
      );
    });
  }
}
