import 'package:flutter/material.dart';
import 'package:study_buddy/widgets/SingleCupon.dart';

class Cupons extends StatelessWidget {
  final List<SingleCupon> cuponsList = [
    SingleCupon('Hamburger', '1+1 on all Hamburgers'),
    SingleCupon('Beer', '20% of all beers'),
    SingleCupon('Beer', '20% of all beers'),
    SingleCupon('Beer', '20% of all beers'),
    SingleCupon('Beer', '20% of all beers'),
    SingleCupon('Beer', '20% of all beers'),
    SingleCupon('Beer', '20% of all beers'),
    SingleCupon('Beer', '20% of all beers'),
    SingleCupon('Beer', '20% of all beers')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("My Cupons"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 8),
              child: Text(
                'My Cupons',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SingleCupon('Hamburger', '1+1 on all Hamburgers'),
            SingleCupon('Beer', '20% of all beers'),
          ],
        ),
      ),
    );
  }
}
