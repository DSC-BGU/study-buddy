import 'package:flutter/material.dart';
import '../../../app_localizations.dart';
import '../../../models/sharedModels/Category.dart' as Cat;
import '../../../Screens/studentScreens/category_stores_screen.dart';

class CategoryItem extends StatelessWidget {
  final Cat.Category category;

  CategoryItem(this.category);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryStoresScreen.routeName,
      arguments: this.category,
    );
  }

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return FlatButton(
          onPressed: () => selectCategory(context),
          child: Column(
            children: [
              // Icon(category.icon),
              Center(
                child: Text(
                  this.category.title,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ],
          ),
          minWidth: constraints.maxWidth * 0.4,
          color: Theme.of(context).accentColor,
          textColor: Colors.black,
          height: constraints.maxHeight * 0.11,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );
      },
    );

    // InkWell(
    //   onTap: () => selectCategory(context),
    //   splashColor: Theme.of(context).primaryColor,
    //   // borderRadius: BorderRadius.circular(10),
    //   child: Container(
    //     child: Center(
    //       child: Text(
    //         this.category.title,
    //         style: Theme.of(context).textTheme.title,
    //       ),
    //     ),
    //     decoration: BoxDecoration(
    //       gradient: LinearGradient(
    //         colors: [
    //           Theme.of(context).primaryColor.withOpacity(0.8),
    //           Theme.of(context).primaryColor.withOpacity(0.7),
    //           // color.withOpacity(0.7),
    //           // color,
    //         ],
    //         // begin: Alignment.center,
    //         // end: Alignment.center,
    //       ),
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //   ),
    // );
  }
}
