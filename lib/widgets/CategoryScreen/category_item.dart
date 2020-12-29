import 'package:flutter/material.dart';
import '../../Screens/category_stores_screen.dart';
import '../../models/Category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  CategoryItem(this.category);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryStoresScreen.routeName,
      arguments: this.category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      // borderRadius: BorderRadius.circular(10),
      child: Container(
        child: Center(
          child: Text(
            this.category.title,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.8),
              Theme.of(context).primaryColor.withOpacity(0.7),
              // color.withOpacity(0.7),
              // color,
            ],
            // begin: Alignment.center,
            // end: Alignment.center,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
