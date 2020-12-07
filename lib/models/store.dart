import 'package:flutter/foundation.dart';

class Store {
  final String id;
  final String name;
  final String adress;
  final String imageUrl;
  final String description;
  final List<String> cupons;
  final List<String> categories;

  const Store({
    @required this.id,
    @required this.name,
    @required this.adress,
    @required this.imageUrl,
    @required this.description,
    @required this.cupons,
    @required this.categories,
  });
}
