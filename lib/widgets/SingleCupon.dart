import 'package:flutter/material.dart';

class SingleCupon extends StatelessWidget {
  SingleCupon();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 133,
        child: Container(
          margin: EdgeInsets.only(right: 15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    icon: Icon(Icons.qr_code),
                    label: Text('QR'),
                    onPressed: () {},
                  ),
                ),
              ]),
        ));
  }
}
