import 'package:flutter/material.dart';

class Coupon {
  final String id;
  final String title;
  final String storeId;
  final String description;
  final String imageUrl;
  final int points;
  final List<String> categories;

  const Coupon({
    @required this.id,
    @required this.title,
    @required this.storeId,
    @required this.description,
    @required this.imageUrl,
    @required this.points,
    @required this.categories,
  });
}
