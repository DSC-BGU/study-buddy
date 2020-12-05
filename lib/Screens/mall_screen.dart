import 'package:flutter/material.dart';
import 'package:study_buddy/app_localizations.dart';
import 'package:study_buddy/dummy_data.dart';
import '../widgets/store_item.dart';
import '../models/store.dart';

class MallScreen extends StatefulWidget {
  static const routeName = '/category-stores';
  List<Store> availableStores = DUMMY_STORES;

  @override
  _MallScreenState createState() => _MallScreenState();
}

class _MallScreenState extends State<MallScreen> {
  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return
        // Scaffold(
        //   appBar: AppBar(
        //     title: Text(categoryTitle),
        //   ),
        //   body:
        ListView.builder(
      itemBuilder: (ctx, index) {
        return StoreItem(
          id: widget.availableStores[index].id,
          name: widget.availableStores[index].name,
          adress: widget.availableStores[index].adress,
          imageURL: widget.availableStores[index].imageUrl,
          description: widget.availableStores[index].description,
          cupons: widget.availableStores[index].cupons,
          categories: widget.availableStores[index].categories,
        );
      },
      itemCount: widget.availableStores.length,
      // ),
    );
  }
}
