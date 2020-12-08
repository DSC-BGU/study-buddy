import 'package:flutter/material.dart';

class PopUpQR extends StatelessWidget {
  final BuildContext ctx;
  final String cuponTitle;
  PopUpQR(this.ctx, this.cuponTitle);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
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
              height: constraints.maxHeight * 0.27,
              width: constraints.maxWidth * 0.42,
              child: Card(
                child: Center(
                  child: Text(
                    'QR',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
            ),
            Container(
              height: constraints.maxHeight * 0.07,
              width: constraints.maxWidth * 0.48,
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
    });
  }
}
