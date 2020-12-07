import 'package:flutter/material.dart';

class PopUpBuy extends StatelessWidget {
  final BuildContext ctx;
  final String cuponTitle;
  PopUpBuy(this.ctx, this.cuponTitle);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: Colors.black45,
      insetPadding: EdgeInsets.fromLTRB(0, 100, 0, 120),
      title: Center(
          child: Text(
        'Present This Code',
        style: TextStyle(color: Colors.white),
      )),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('$cuponTitle',
              style: TextStyle(color: Colors.white, fontSize: 24)),
          Container(
            height: 170,
            width: 170,
            child: Card(
              child: Center(
                child: Text(
                  'Buy This Coupon',
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
          ),
          Container(
            height: 45,
            width: 200,
            child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.grey)),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Got it, Thanks',
                  style: TextStyle(fontSize: 19),
                )),
          )
        ],
      ),
    );
  }
}
