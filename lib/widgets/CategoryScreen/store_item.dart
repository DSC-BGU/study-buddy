import 'dart:ui';
import 'package:flutter/material.dart';
import '../../models/Store.dart';
import '../../screens/storeScreen.dart';
import '../../app_localizations.dart';

class StoreItem extends StatelessWidget {
  final Store store;

  StoreItem({@required this.store});

  void selectStore(BuildContext context) {
    Navigator.of(context)
        .pushNamed(StoreScreen.routeName, arguments: this.store)
        .then((result) {
      if (result != null) {
        // removeItem(result);
      }
    });
  }

  void showMore() {}

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return InkWell(
      onTap: () => selectStore(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    store.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    width: 250,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      t(store.name),
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_pin),
                      SizedBox(width: 6),
                      Text(t(store.address)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(width: 6),
                      // Text(affordabilityText),
                    ],
                  ),
                  InkWell(
                    onTap: showMore,
                    child: Row(
                      children: [
                        Icon(Icons.keyboard_arrow_down_sharp),
                        SizedBox(width: 6),
                        // Text(affordabilityText),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
