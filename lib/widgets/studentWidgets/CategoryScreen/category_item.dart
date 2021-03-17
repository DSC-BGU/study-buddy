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
    return
      LayoutBuilder(builder:(ctx, constraints) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: constraints.maxHeight * 0.80,
                width: constraints.maxHeight * 0.80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
                child: IconButton(
                  icon: this.category.icon,
                  iconSize: 48,
                  color: Colors.white,
                  onPressed: () => selectCategory(context),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: constraints.maxHeight * 0.01),
                child: Text(
                  t(this.category.title),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      });
  }
}
