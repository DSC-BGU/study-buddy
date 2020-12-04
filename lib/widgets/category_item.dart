import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  // final Color color;

  CategoryItem(
    this.id,
    this.title,
    /* this.color*/
  );

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      '/category-stores',
      // '/category-coupones',
      arguments: {'id': id, 'title': title},
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
            title,
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
