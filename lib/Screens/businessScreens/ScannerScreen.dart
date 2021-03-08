import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannerScreen extends StatelessWidget {
  static const routeName = '/scanScreen';

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Future<String> barcodeScanRes = FlutterBarcodeScanner.scanBarcode(
    //   '#ff6666',
    //   'Cancel',
    //   true,
    //   ScanMode.QR,
    // );
    return Container(
        alignment: Alignment.center,
        child: RaisedButton(
            onPressed: () => scanBarcodeNormal(),
            child: Text("Start barcode scan")));
  }
}
