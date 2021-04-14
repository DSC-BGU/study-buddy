import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_buddy/utils/Mapping.dart';
import '../../models/sharedModels/Store.dart';
import '../../models/sharedModels/Category.dart' as Cat;
import '../../models/studentModels/couponModels/Coupon.dart';

class StoreProvider with ChangeNotifier {
  final databaseReference = FirebaseFirestore.instance;
  List<Store> availableStores = [];
  List<Coupon> availableCoupons = [];
  List<Cat.Category> availableCategories = [];
  bool _loading = true;

  StoreProvider() {
    getCategoryList().then((v) {
      getCouponList().then((v) {
        storesFromDB().then((v) {
          _loading = false;
          // notifyListeners();
        });
      });
    });
  }

  Future<void> getCategoryList() async {
    databaseReference.collection('categories').snapshots().listen((event) {
      List<Cat.Category> categorylst = [];
      event.docs.forEach((element) {
        categorylst.add(
          Cat.Category(
            id: element.id,
            title: element['name'],
            icon: getIconByString(element['name']),
          ),
        );
      });
      this.availableCategories = categorylst;
      notifyListeners();
    });
  }

  List<Cat.Category> get categories {
    return [...availableCategories];
  }

  Future<void> getCouponList() async {
    databaseReference.collection('coupons').snapshots().listen((event) {
      List<Coupon> couponlst = [];
      event.docs.forEach((element) {
        couponlst.add(Coupon(
            id: element.id,
            title: element['title'],
            storeId: element['store'],
            description: element['description'],
            imageUrl: element['imageUrl'],
            points: element['points']));
      });
      this.availableCoupons = couponlst;
      notifyListeners();
    });
  }

  List<Coupon> get coupons {
    return [...availableCoupons];
  }

  Future<void> storesFromDB() async {
    databaseReference.collection('stores').snapshots().listen((snapshot) {
      List<Store> templst = [];
      snapshot.docs.forEach((doc) {
        try {
          templst.add(Store(
              id: doc.id,
              name: doc['name'],
              address: doc['address'],
              imageUrl: doc['imageUrl'],
              description: doc['description'],
              coupons: createCouponList(doc['coupons']),
              categories: createCategoryList(doc['categories'])));
        } catch (e) {
          print(e);
        }
      });
      this.availableStores = templst;
      notifyListeners();
    });
  }

  bool get loading {
    return _loading;
  }

  List<Cat.Category> createCategoryList(List<dynamic> categoryIDs) {
    List<Cat.Category> categories = [];
    List<Cat.Category> allCategories = this.categories;
    allCategories.forEach((allCat) {
      categoryIDs.contains(allCat.id) ? categories.add(allCat) : null;
    });
    return categories;
  }

  List<Coupon> createCouponList(List<dynamic> couponIDs) {
    List<Coupon> coupons = [];
    List<Coupon> allCoupons = this.coupons;
    allCoupons.forEach((allCoup) {
      couponIDs.contains(allCoup.id) ? coupons.add(allCoup) : null;
    });
    return coupons;
  }

  List<Store> get stores {
    return [...availableStores];
  }

  List<Store> filterStoresByCategory(String categoryId) {
    List<Store> storeList = this.stores;
    List<Store> filteredList = [];
    storeList.forEach((store) {
      store.categories.forEach((cat) {
        cat.id == categoryId ? filteredList.add(store) : null;
      });
    });
    return filteredList;
  }

  Coupon getCouponById(String couponId) {
    Coupon coupon;
    availableCoupons.forEach((c) {
      if (c.id == couponId) {
        coupon = c;
      }
    });
    return coupon;
  }

  void removeCoupon(String couponId) {
    databaseReference.collection('coupons').doc(couponId).delete();
  }

  Store getStoreById(String storeId) {
    Store store;
    availableStores.forEach((c) {
      if (c.id == storeId) {
        store = c;
      }
    });
    return store;
  }
}
