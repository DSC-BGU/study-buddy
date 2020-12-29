import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/DB.dart';
import '../models/Coupon.dart';
import '../models/PurchasedCoupon.dart';

class UserProvider with ChangeNotifier {
  final databaseReference = FirebaseFirestore.instance;
  String _id = '';
  String _name = '';
  int _points = 0;
  // List<PurchasedCoupon> _myCoupons = [];
  List<Coupon> _myCoupons = [];
  List<Coupon> _usedCoupons = [];

  // UserProvider() {
  //   // getUserName();
  //   // getUserId();
  //   // getUserCoupons();
  //   // getUserUsedCoupons();
  // }

  String get id {
    return _id;
  }

  String get name {
    return _name;
  }

  int get poins {
    return _points;
  }

  List<Coupon> get myCoupons {
    return _myCoupons;
  }

  List<Coupon> get myUsedCoupons {
    return _usedCoupons;
  }
}
//   void getUserName() {
//     databaseReference.collection('coupons').snapshots().listen((event) {
//       String name = '';
//       // event.docs.forEach((element) {
//       //   couponlst.add(Coupon(
//       //       id: element.id,
//       //       title: element['title'],
//       //       storeId: element['store'],
//       //       description: element['description'],
//       //       imageUrl: element['imageUrl'],
//       //       points: element['points']));
//       // });
//       this._name = name;
//       notifyListeners();
//     });
//   }

//   List<Coupon> availableCoupons() {
//     List<PurchasedCoupon> availableList =
//         _myCoupons.where((element) => !element.used).toList();
//     return availableList.map((e) => e.coupon).toList();
//   }

//   List<Coupon> usedCoupons() {
//     List<PurchasedCoupon> purchasedList =
//         _myCoupons.where((element) => element.used).toList();
//     return purchasedList.map((e) => e.coupon).toList();
//   }
// }

// // void addUserPoints(int points) {
// //   final db = DatabaseService();
// //   db.updateUserPoints(this._id, this._points + points);
// // }

// // void subtractUserPoints(int points) {
// //   final db = DatabaseService();
// //   db.updateUserPoints(this.id, this.points - points);
// // }

// // factory User.fromFirestore(DocumentSnapshot doc) {
// //     Map data = doc.data();
// //     return User(
// //         id: doc.id,
// //         name: data['name'] ?? '',
// //         points: data['points'] ?? 0,
// //         myCoupons: []); //DUMMY_PURCHASED_COUPONS);
// //   }

// //   factory User.fromMap(Map data) {
// //     data = data ?? {};
// //     return User(
// //         id: data['id'] ?? '',
// //         name: data['name'] ?? '',
// //         points: data['points'] ?? 0,
// //         myCoupons: []); // DUMMY_PURCHASED_COUPONS);
// //   }
