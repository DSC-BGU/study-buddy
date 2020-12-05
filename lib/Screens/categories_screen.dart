import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/category_item.dart';
import '../widgets/advertising.dart';

class CategoriesScreen extends StatelessWidget {
  static const routName = '/categories';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
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
                children: DUMMY_CATEGORIES
                    .map(
                      (catData) => CategoryItem(
                        catData.id,
                        catData.title,
                        // Theme.of(context).primaryColor.withOpacity(0.6)),
                        // catData.color,
                      ),
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
      ),
    );
  }
}