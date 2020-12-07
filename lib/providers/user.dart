import 'package:flutter/material.dart';
import 'package:study_buddy/models/PointsHistory.dart';
import 'package:study_buddy/models/my_coupon.dart';
import './points.dart';

class User with ChangeNotifier {
  final String id;
  final String name;
  final List<MyCoupon> myCoupons;
  final List<MyCoupon> favoriteCoupons;

  User({
    @required this.id,
    @required this.name,
    @required this.myCoupons,
    @required this.favoriteCoupons,
  });

  List<PointsHistory> _history =
      DUMMY_HISTORY; // TODO: replace it with real data

  int _currentPoints = 520;

  List<PointsHistory> get history {
    return [..._history];
  }

  int get currentPoints {
    return _currentPoints;
  }

  void updatePoints(newPoints) {
    _currentPoints = newPoints;
    notifyListeners();
  }

  void addPoints(newPoints) {
    _currentPoints = _currentPoints + newPoints;
    notifyListeners();
  }

  void substructPoints(newPoints) {
    _currentPoints = _currentPoints - newPoints;
    notifyListeners();
  }

  void addNewHistory(PointsHistory historyData) {
    _history.add(historyData);
    notifyListeners();
  }

  void focusSuccesss(int minutes) {
    this.addPoints(minutes * 3);
  }

//   void addItem(
//     String productId,
//     double price,
//     String title,
//   ) {
//     if (_items.containsKey(productId)) {
//       // change quantity...
//       _items.update(
//         productId,
//         (existingCartItem) => CartItem(
//               id: existingCartItem.id,
//               title: existingCartItem.title,
//               price: existingCartItem.price,
//               quantity: existingCartItem.quantity + 1,
//             ),
//       );
//     } else {
//       _items.putIfAbsent(
//         productId,
//         () => CartItem(
//               id: DateTime.now().toString(),
//               title: title,
//               price: price,
//               quantity: 1,
//             ),
//       );
//     }
//     notifyListeners();
//   }

//   void removeItem(String productId) {
//     _items.remove(productId);
//     notifyListeners();
//   }

//   void clear() {
//     _items = {};
//     notifyListeners();
//   }
// }

}
