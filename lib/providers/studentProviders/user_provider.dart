import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_buddy/main.dart';
import 'package:study_buddy/models/sharedModels/store.dart';
import 'package:study_buddy/utils/analyticsService.dart';
import '../../models/studentModels/couponModels/PurchasedCoupon.dart';
import '../../models/studentModels/couponModels/Coupon.dart';

class UserProvider with ChangeNotifier {
  String _id = FirebaseAuth.instance.currentUser != null
      ? FirebaseAuth.instance.currentUser.uid
      : "";
  String _name = '';
  int _points = 500;
  bool _business = false;
  String _image;

  List<String> _purchasedCouponsId = [];
  List<PurchasedCoupon> _purchasedCoupons = [];
  StreamSubscription _subscription;
  StreamSubscription _couponsSubscription;
  bool _loading = true;

  // Bussiness fields
  String storeId;
  Store currStore;
  List<Coupon> bussinessCoupons = [];

  UserProvider() {
    FirebaseAuth.instance.authStateChanges().listen((userSnapshot) {
      if (userSnapshot != null) {
        this._id = userSnapshot.uid;
        getUserData().then((val) {
          _loading = false;
          // notifyListeners();
        });
      }
    });
  }

  Future<void> getUserData() async {
    this._subscription = FirebaseFirestore.instance
        .collection('users')
        .doc(this._id)
        .snapshots()
        .listen((event) {
      final userData = event.data();
      if (userData != null) {
        List<dynamic> myPurchasedCoupons = userData['purchased_coupons'];
        this._name = userData['username'];
        this._points = userData['points'];
        if (userData['photoURL'] != null) {
          this._image = userData['photoURL'];
        }
        try {
          if (userData['business'] != null) {
            this._business = userData['business'];
            this.storeId = userData['storeId'];
          }
        } catch (err) {
          this._business = false;
        }
        try {
          this._purchasedCouponsId =
              myPurchasedCoupons.map((c) => c.toString()).toList();
        } catch (err) {
          myPurchasedCoupons = [];
        }
      }
      AnalyticsService analyticsService = locator.get<AnalyticsService>();
      analyticsService.setUserProperties(
          userId: this._id,
          name: this._name,
          userType: this.business ? "business" : "student");
      notifyListeners();
      getPurchasedCoupons();
    });
  }

  bool get loading {
    return _loading;
  }

  void logout() {
    this._id = null;
    if (this._subscription != null) {
      this._subscription.cancel();
    }
    if (this._couponsSubscription != null) {
      this._couponsSubscription.cancel();
    }
    FirebaseAuth.instance.signOut();
  }

  void addUserPoints(int points) {
    this._points = this._points + points;
    FirebaseFirestore.instance
        .collection('users')
        .doc(this._id)
        .update({'points': this._points}).then((value) => notifyListeners());
    // notifyListeners();
  }

  void buyCoupon(Coupon coupon) {
    if (_points >= coupon.points) {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('purchasedCoupons').doc();
      docRef
          .set({
            'couponId': coupon.id,
            'userId': this._id,
            'datePurhcased': new DateTime.now(),
            'used': false,
          })
          .then((value) => this._points = this._points - coupon.points)
          .then((value) => this._purchasedCouponsId.add(docRef.id))
          .then((value) => FirebaseFirestore.instance
                  .collection('users')
                  .doc(this._id)
                  .update({
                'points': this._points,
                'purchased_coupons': this._purchasedCouponsId,
              }))
          .then((value) => locator<AnalyticsService>()
                  .logEvent(eventName: EventTypes.BuyCoupon, parameters: {
                "title": coupon.title,
                'storeId': coupon.storeId,
                "couponId": coupon.id,
              }));
    }
    notifyListeners();
    getPurchasedCoupons();
  }

  void useCoupon(String purchasedCouponId) {
    FirebaseFirestore.instance
        .collection('purchasedCoupons')
        .doc(purchasedCouponId)
        .update({
          'used': true,
        })
        .then((value) =>
            // FirebaseFirestore.instance.collection('users').doc(this._id).update({
            //   'purchased_coupons': this._purchasedCouponsId,
            // });
            notifyListeners())
        .then((value) => getPurchasedCoupons());
  }

  void getPurchasedCoupons() {
    if (_couponsSubscription != null) {
      this._couponsSubscription.cancel();
    }
    List<PurchasedCoupon> purchasedCoupons = [];
    if (_purchasedCouponsId.isNotEmpty) {
      _couponsSubscription = FirebaseFirestore.instance
          .collection('purchasedCoupons')
          .where('userId', isEqualTo: this._id)
          .snapshots()
          .listen((event) {
        event.docs.forEach((doc) {
          Map<String, dynamic> json = doc.data();
          purchasedCoupons.add(PurchasedCoupon.fromJson(json, doc.id));
        });
        this._purchasedCoupons = purchasedCoupons;
        notifyListeners();
      });
    }
  }

  String get id {
    return _id;
  }

  String get name {
    return _name;
  }

  String get image {
    return _image;
  }

  ImageProvider get imageProvider {
    return _image == null
        ? AssetImage("assets/avatar_temp.jpg")
        : NetworkImage(this._image);
  }

  int get points {
    return _points;
  }

  bool get isAuth {
    return _name != '';
  }

  bool get business {
    return this._business;
  }

  List<String> get myCouponsID {
    return [..._purchasedCouponsId];
  }

  List<PurchasedCoupon> get myPurchasedCoupons {
    return [..._purchasedCoupons];
  }

  List<PurchasedCoupon> getMyAvailablePurchasedCoupons() {
    List<PurchasedCoupon> availablePurchasedCoupons = [];
    _purchasedCoupons.forEach((c) {
      if (!c.used) {
        availablePurchasedCoupons.add(c);
      }
    });
    availablePurchasedCoupons
        .sort((a, b) => b.datePurhcased.compareTo(a.datePurhcased));
    return availablePurchasedCoupons;
  }

  List<PurchasedCoupon> getMyUsedPurchasedCoupons() {
    List<PurchasedCoupon> usedPurchasedCoupons = [];
    _purchasedCoupons.forEach((c) {
      if (c.used) {
        usedPurchasedCoupons.add(c);
      }
    });
    return usedPurchasedCoupons;
  }

  List<Coupon> getBussinessCoupons(String storeId) {
    FirebaseFirestore.instance
        .collection('coupons')
        .snapshots()
        .listen((event) {
      List<Coupon> couponlst = [];
      event.docs.forEach((element) {
        if (storeId == element['store']) {
          couponlst.add(Coupon(
              id: element.id,
              title: element['title'],
              storeId: element['store'],
              description: element['description'],
              imageUrl: element['imageUrl'],
              points: element['points']));
        }
      });
      this.bussinessCoupons = couponlst;
      notifyListeners();
    });
    return this.bussinessCoupons;
  }
}
