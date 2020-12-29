import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/models/Category.dart' as cat;
import 'package:study_buddy/models/Coupon.dart';
import 'package:study_buddy/models/Store.dart';

class StoreProvider with ChangeNotifier {
  final databaseReference = FirebaseFirestore.instance;
  List<Store> availableStores = [];
  List<Coupon> availableCoupons = [];
  List<cat.Category> availableCategories = [];

  StoreProvider() {
    getCategoryList();
    getCouponList();
    storesFromDB();
  }

  void getCategoryList() {
    databaseReference.collection('categories').snapshots().listen((event) {
      List<cat.Category> categorylst = [];
      event.docs.forEach((element) {
        categorylst.add(cat.Category(id: element.id, title: element['name']));
      });
      this.availableCategories = categorylst;
      notifyListeners();
    });
  }

  List<cat.Category> get categories {
    return [...availableCategories];
  }

  void getCouponList() {
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

  void storesFromDB() {
    databaseReference.collection('stores').snapshots().listen((snapshot) {
      List<Store> templst = [];
      snapshot.docs.forEach((doc) {
        templst.add(Store(
            id: doc.id,
            name: doc['name'],
            address: doc['address'],
            imageUrl: doc['imageUrl'],
            description: doc['description'],
            coupons: createCouponList(doc['coupons']),
            categories: createCategoryList(doc['categories'])));
      });
      this.availableStores = templst;
      notifyListeners();
    });
  }

  List<cat.Category> createCategoryList(List<dynamic> categoryIDs) {
    List<cat.Category> categories = [];
    List<cat.Category> allCategories = this.categories;
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
}