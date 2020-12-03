import 'package:flutter/material.dart';
import 'package:study_buddy/models/store.dart';
import '../models/store.dart';

List<Store> DUMMY_STORES = [
  Store(
      adress: 'Derech Metzada 17',
      category: Category.food,
      description: 'Agadir resturant',
      id: 'b1',
      imageURL:
          'https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg',
      name: 'Agadir'),
  Store(
      adress: 'Shlomo Hamelech 9',
      category: Category.food,
      description: 'MiniMarket Shani',
      id: 'b2',
      imageURL:
          'https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg',
      name: 'MiniMarket Shani')
];
