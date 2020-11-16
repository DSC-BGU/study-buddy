import 'package:flutter/material.dart';
import 'package:study_buddy/widgets/SingleCupon.dart';

class Cupons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cupons"),
      ),
      body: Container(
        child: Column(
          children: [SingleCupon(), SingleCupon(), SingleCupon()],
        ),
      ),
    );
  }
}
