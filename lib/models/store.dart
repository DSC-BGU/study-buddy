import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Store {
  @required
  String id;
  @required
  String name;
  @required
  String adress;
  String imageURL;
  String description;
  //Cupon <Cupon>[];
  Category category;

  Store(
      {this.id,
      this.name,
      this.adress,
      this.imageURL,
      this.description,
      this.category});
}

enum Category { food, groceries }
