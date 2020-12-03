import 'package:flutter/material.dart';
import 'package:study_buddy/Screens/PopUpQR.dart';

class SingleCupon extends StatelessWidget {
  final String cuponTitle;
  final String cuponDescription;
  SingleCupon(this.cuponTitle, this.cuponDescription);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      height: 125,
      child: Card(
        color: Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$cuponTitle',
                  style: TextStyle(fontSize: 36),
                ),
                Text(
                  '$cuponDescription',
                  style: TextStyle(fontSize: 22),
                )
              ]),
          SizedBox(
            height: 85,
            width: 85,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              icon: Icon(Icons.qr_code),
              label: Text(
                'QR',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => PopUpQR(ctx, cuponTitle));
              },
            ),
          ),
        ]),
      ),
    );
  }
}
