import 'package:flutter/material.dart';
import 'package:study_buddy/widgets/SingleCupon.dart';

class Cupons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("My Cupons"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'My Cupons',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SingleCupon()
          ],
        ),
      ),
    );
  }
}
