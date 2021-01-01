import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Category.dart' as Cat;
import '../providers/StoreProvider.dart';

import '../widgets/CategoryScreen/category_item.dart';
import '../widgets/CategoryScreen/advertising.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories';

  @override
  Widget build(BuildContext context) {
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);
    List<Cat.Category> categoriesList = storeProvider.categories;
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 3 / 2,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Advertising();
                },
                childCount: 1,
              ),
            ),
            // GridView(
            //   padding: const EdgeInsets.all(15),
            //   children: categoriesList.map((c) => CategoryItem(c)).toList(),
            //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //     maxCrossAxisExtent: 200,
            //     childAspectRatio: 3 / 2,
            //     crossAxisSpacing: 10,
            //     mainAxisSpacing: 10,
            //   ),
            // ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 3 / 2,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return CategoryItem(categoriesList[index]);
                },
                childCount: categoriesList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
