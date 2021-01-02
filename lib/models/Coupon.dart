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

  factory Coupon.fromJson(dynamic json) {
    return Coupon(
      id: json['id'] as String,
      title: json['title'],
      storeId: json['storeId'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      points: json['points'],
    );
  }

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'storeId': storeId,
      'description': description,
      'imageUrl': imageUrl,
      'points': points,
    };
  }
}
