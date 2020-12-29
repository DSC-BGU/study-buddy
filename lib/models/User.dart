import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_buddy/models/PurchasedCoupon.dart';
import 'package:study_buddy/dummy_data.dart';
import 'package:study_buddy/models/Coupon.dart';
import 'package:study_buddy/services/DB.dart';

class User {
  String id;
  String name;
  int points;
  List<PurchasedCoupon> myCoupons;

  User({this.id, this.name, this.points, this.myCoupons});

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    return User(
      id: doc.id,
      name: data['name'] ?? '',
      points: data['points'] ?? 0,
        myCoupons: DUMMY_PURCHASED_COUPONS
    );
  }
  factory User.fromMap(Map data) {
    data = data ?? {};
    return User(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      points: data['points'] ?? 0,
        myCoupons: DUMMY_PURCHASED_COUPONS
    );
  }
  List<Coupon> availableCoupons() {
    if (myCoupons== null)
      return [];
    List<PurchasedCoupon> availableList =
    myCoupons.where((element) => !element.used).toList();
    return availableList.map((e) => e.coupon).toList();
  }

  List<Coupon> usedCoupons() {
    if (myCoupons== null)
      return [];
    List<PurchasedCoupon> purchasedList =
    myCoupons.where((element) => element.used).toList();
    return purchasedList.map((e) => e.coupon).toList();
  }

  void addUserPoints(int points) {
    final db = DatabaseService();
    db.updateUserPoints(this.id, this.points + points);
  }
  void subtractUserPoints(int points) {
    final db = DatabaseService();
    db.updateUserPoints(this.id, this.points - points);
  }
}
