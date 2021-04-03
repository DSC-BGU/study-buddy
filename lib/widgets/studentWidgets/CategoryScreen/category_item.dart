import 'package:flutter/material.dart';
import '../../../app_localizations.dart';
import '../../../models/sharedModels/Category.dart' as Cat;
import '../../../Screens/studentScreens/category_stores_screen.dart';

class CategoryItem extends StatelessWidget {
  final Cat.Category category;
  final double width;
  final double height;

  CategoryItem({
    this.category,
    this.width,
    this.height,
  });

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryStoresScreen.routeName,
      arguments: this.category,
    );
  }

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    // return LayoutBuilder(builder: (ctx, constraints) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 8,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              // height: constraints.maxHeight * 0.8,
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Theme.of(context).primaryColor,
              ),
              child: IconButton(
                icon: this.category.icon,
                iconSize: MediaQuery.of(context).size.width * 0.12,
                color: Colors.white,
                onPressed: () => selectCategory(context),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              // margin: EdgeInsets.only(top: constraints.maxHeight * 0.01),
              // height: constraints.maxHeight * 0.18,
              child: Text(
                t(this.category.title),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // }
    // );
  }
}
