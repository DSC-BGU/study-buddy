import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:study_buddy/Screens/businessScreens/ScanDetailsScreen.dart';

class ScanButton extends StatelessWidget {
  Widget child;

  ScanButton({this.child});

  Future<void> scanBarcode(BuildContext ctx) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      Navigator.of(ctx).pushNamed(
        ScanDetailsScreen.routeName,
        arguments: barcodeScanRes,
      );
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: this.child,
      onTap: () {
        scanBarcode(context);
      },
    );
  }
}
