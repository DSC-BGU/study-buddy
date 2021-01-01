import '../models/PurchasedCoupon.dart';

class User {
  String id;
  String name;
  int points;
  List<PurchasedCoupon> myCoupons;

  User({this.id, this.name, this.points, this.myCoupons});
}
