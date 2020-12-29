import 'package:flutter/material.dart';

class Coupon {
  final String id;
  final String title;
  final String storeId;
  final String description;
  final String imageUrl;
  final int points;

  const Coupon({
    @required this.id,
    @required this.title,
    @required this.storeId,
    @required this.description,
    @required this.imageUrl,
    @required this.points,
  });
}
