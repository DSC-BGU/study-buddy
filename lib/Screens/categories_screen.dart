import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/app_localizations.dart';
import 'package:study_buddy/models/Category.dart' as cat;
import 'package:study_buddy/providers/StoreProvider.dart';

import '../widgets/category_item.dart';
import '../widgets/advertising.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories';
  List<cat.Category> categoriesList;

  CategoriesScreen();

  @override
  Widget build(BuildContext context) {
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);
    categoriesList = storeProvider.categories;
    String t(String text) => AppLocalizations.of(context).translate(text);
    return
        // Scaffold(
        //   appBar: AppBar(),
        //   body:
        Container(
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: Advertising(),
          ),
          Flexible(
            child: GridView(
              padding: const EdgeInsets.all(15),
              children: categoriesList
                  .map(
                    (c) => CategoryItem(c),
                  )
                  .toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
