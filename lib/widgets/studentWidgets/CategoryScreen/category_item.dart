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
    // return LayoutBuilder(
    //   builder: (ctx, constraints) {
    return Container(
      width: this.width, // constraints.maxWidth * 0.24,
      height: this.height, //.maxHeight * 0.11,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: height * 0.9,
            width: height * 0.9,
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
          Padding(
            padding: EdgeInsets.only(top: this.height * 0.07),
            child: Text(
              t(this.category.title),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );

    //  Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     IconButton(
    //       icon: this.category.icon,
    //       onPressed: () => selectCategory(context),
    //       highlightColor: ,
    //     ),
    //     Text(
    //       this.category.title,
    //       style: Theme.of(context).textTheme.title,
    //     ),
    //   ],
    // );

    // return FlatButton(
    //   onPressed: () => selectCategory(context),
    //   child: Text(
    //     this.category.title,
    //     style: Theme.of(context).textTheme.title,
    //   ),
    //   minWidth: constraints.maxWidth * 0.4,
    //   color: Theme.of(context).accentColor,
    //   textColor: Colors.black,
    //   height: constraints.maxHeight * 0.11,
    //   shape:
    //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    // );
    //   },
    // );
  }
}
