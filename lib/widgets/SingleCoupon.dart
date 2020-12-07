import 'dart:ui';

import 'package:flutter/material.dart';

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
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        height: constraints.maxWidth * 0.30,
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
      );
    });
  }
}
