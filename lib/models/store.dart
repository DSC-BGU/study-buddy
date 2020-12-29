import 'package:flutter/material.dart';
import 'package:study_buddy/models/Coupon.dart';
import 'package:study_buddy/models/Category.dart';

class Store {
  final String id;
  final String name;
  final String address;
  final String imageUrl;
  final String description;
  final List<Coupon> coupons;
  final List<Category> categories;

  const Store({
    @required this.id,
    @required this.name,
    @required this.address,
    @required this.imageUrl,
    @required this.description,
    @required this.coupons,
    @required this.categories,
  });
}
