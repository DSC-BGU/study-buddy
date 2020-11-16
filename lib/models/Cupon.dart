import 'package:flutter/material.dart';

class Cupon {
  final String cuponId;
  final String storeId;
  final String storeName;
  final String storeDescription;
  final String phoneNumber;
  final int points;

  Cupon(
      {@required this.cuponId,
      @required this.storeId,
      @required this.storeName,
      @required this.storeDescription,
      @required this.phoneNumber,
      @required this.points});
}
