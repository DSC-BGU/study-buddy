import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_localizations.dart';
import '../models/Category.dart' as cat;
import '../providers/StoreProvider.dart';

import '../widgets/CategoryScreen/category_item.dart';
import '../widgets/CategoryScreen/advertising.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories';
  List<cat.Category> categoriesList;

  CategoriesScreen();

  @override
  Widget build(BuildContext context) {
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);
    categoriesList = storeProvider.categories;
    String t(String text) => AppLocalizations.of(context).translate(text);
//     // return Container(
//     //   child: Padding(
//     //     padding: const EdgeInsets.symmetric(horizontal: 10),
//     //     child: CustomScrollView(
//     //       slivers: <Widget>[
//     //         SliverGrid(
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
              // delegate: SliverChildBuilderDelegate(
              //   (BuildContext context, int index) {
              //     return Advertising();
              //   },
              //   childCount: 1,
              // ),
              // SliverGrid(
              // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //   maxCrossAxisExtent: 200.0,
              //   mainAxisSpacing: 10.0,
              //   crossAxisSpacing: 10.0,
              //   childAspectRatio: 3 / 2,
              // ),
              // delegate: SliverChildBuilderDelegate(
              //   (BuildContext context, int index) {
              //     return CategoryItem(
              //       DUMMY_CATEGORIES[index].id,
              //       DUMMY_CATEGORIES[index].title,
              //     );
              //   },
              //   childCount: DUMMY_CATEGORIES.length,
              // ),
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
