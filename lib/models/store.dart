import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import './Cupon.dart';

enum Category {
  food,
  groceries,
}

class Store {
  @required
  String id;
  @required
  String name;
  @required
  String adress;
  String imageURL;
  String description;
  //<Cupon>[] cupons;
  Category category;
  // List infoList;

  Store({
    this.id,
    this.name,
    this.adress,
    this.imageURL,
    this.description,
    this.category,
    //infoList=[adress, category, description],
  });

  String get categoryText {
    switch (this.category) {
      case Category.food:
        return 'food';
        break;
      case Category.groceries:
        return 'groceries';
        break;
      default:
        return 'Other';
    }
  }
}
