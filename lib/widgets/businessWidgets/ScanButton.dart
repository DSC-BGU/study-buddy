// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:study_buddy/Screens/businessScreens/ScanDetailsScreen.dart';

// import '../../app_localizations.dart';

// class ScanButton extends StatelessWidget {
//   Future<void> scanBarcode(BuildContext ctx) async {
//     String barcodeScanRes;
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666',
//         'Cancel',
//         true,
//         ScanMode.QR,
//       );
//       Navigator.of(ctx).pushNamed(
//         ScanDetailsScreen.routeName,
//         arguments: barcodeScanRes,
//       );
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     String t(String text) => AppLocalizations.of(context).translate(text);
//     Container(
//         width: constraints.maxWidth * 0.24,
//         child: FlatButton(
//           onPressed: () {
//             scanBarcode(context);
//           },
//           child: Text(
//             t("Scan barcode"),
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 15),
//           ),
//           minWidth: constraints.maxWidth * 0.4,
//           color: Theme.of(context).accentColor,
//           height: constraints.maxHeight * 0.11,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       );
//   }
// }
