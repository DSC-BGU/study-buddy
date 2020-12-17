import 'package:flutter/material.dart';
import 'package:study_buddy/app_localizations.dart';

import '../dummy_data.dart';
import '../widgets/CategoryScreen/category_item.dart';
import '../widgets/CategoryScreen/advertising.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories';

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
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
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 3 / 2,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return CategoryItem(
                    DUMMY_CATEGORIES[index].id,
                    DUMMY_CATEGORIES[index].title,
                  );
                },
                childCount: DUMMY_CATEGORIES.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
