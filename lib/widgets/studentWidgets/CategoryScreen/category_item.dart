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
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.005,
        bottom: MediaQuery.of(context).size.height * 0.005,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 75,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
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
            flex: 25,
            child: Container(
              height: MediaQuery.of(context).size.width * 0.15,
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
  }
}
