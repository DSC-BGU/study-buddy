import 'package:flutter/material.dart';
import 'package:study_buddy/widgets/SingleBarcode.dart';

class Barcodes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Avital"),
      ),
      body: Container(
        child: SingleBarcode(),
      ),
    );
  }
}
