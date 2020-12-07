import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:study_buddy/app_localizations.dart';

class SingleCoupon extends StatelessWidget {
  final String id;
  final String title;
  final String storeId;
  final String description;
  final String imageUrl;
  final int points;
  final List<String> categories;

  SingleCoupon({
    @required this.id,
    @required this.title,
    @required this.storeId,
    @required this.description,
    @required this.imageUrl,
    @required this.points,
    @required this.categories,
  });

  // void selectCoupon(BuildContext context) {
  //   Navigator.of(context)
  //       .pushNamed(
  //     MealDetailScreen.routName,
  //     arguments: id,
  //   )
  //       .then((result) {
  //     if (result != null) {
  //       // removeItem(result);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return Container(
      height: 140,
      child: Stack(children: [
        Image.network(
          imageUrl,
          width: double.infinity,
          fit: BoxFit.fitWidth,
        ),
        Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
              width: double.infinity,
              color: Colors.black38,
              child: Text(
                this.description,
                style: TextStyle(color: Colors.white, fontSize: 26),
              )),
        ])
      ]),
      // child: Column (
      //   children: [
      //     Stack(
      //       children: [
      //         ClipRRect(
      //           borderRadius: BorderRadius.only(
      //             topLeft: Radius.circular(15),
      //             topRight: Radius.circular(15),
      //           ),
      //           child: Image.network(
      //             imageUrl,
      //             height: 250,
      //             width: double.infinity,
      //             fit: BoxFit.fill,
      //           ),
      //         ),
      //         Positioned(
      //           bottom: 20,
      //           right: 10,
      //           child: Container(
      //             width: 300,
      //             color: Colors.black54,
      //             padding: EdgeInsets.symmetric(
      //               vertical: 5,
      //               horizontal: 20,
      //             ),
      //             child: Text(
      //               title,
      //               style: TextStyle(
      //                 fontSize: 26,
      //                 color: Colors.white,
      //               ),
      //               softWrap: true,
      //               overflow: TextOverflow.fade,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [],
      //     ),
      //   ],
      // ),
    );
  }
}
