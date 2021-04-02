import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../app_localizations.dart';
import '../../../models/sharedModels/Store.dart';
import '../../../screens/studentScreens/storeScreen.dart';

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

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return LayoutBuilder(builder: (ctx, constraints) {
      return InkWell(
        onTap: () => selectStore(context),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 3,
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
                      height: constraints.maxHeight * 0.74,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      width: constraints.maxWidth * 0.8,
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
              Container(
                margin: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Icon(Icons.location_pin),
                    SizedBox(width: 6),
                    Text(t(store.address)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
