import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:study_buddy/Screens/businessScreens/ScanDetailsScreen.dart';

class ScanButton extends StatelessWidget {
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
    return FloatingActionButton(
      child: Icon(AntDesign.barcode),
      onPressed: () {
        scanBarcode(context);
      },
    );
  }
}
