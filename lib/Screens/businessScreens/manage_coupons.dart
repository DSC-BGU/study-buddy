import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/models/sharedModels/store.dart';
import 'package:study_buddy/models/studentModels/couponModels/Coupon.dart';
import 'package:study_buddy/widgets/businessWidgets/business_coupon.dart';

class ManageCoupons extends StatelessWidget {
  static const String routeName = '/manageCoupons';
  final databaseReference = FirebaseFirestore.instance;
  final Store currStore = null;
  List<Coupon> availableCoupons = [
    Coupon(
        id: "1",
        title: "חלב",
        storeId: "2",
        description: "1+1 Milk",
        imageUrl:
            "https://chriskresser.com/wp-content/uploads/raw-milk-1-e1563894986431.jpg",
        points: 100),
    Coupon(
        id: "1",
        title: "Milk2",
        storeId: "2",
        description: "1+1 Milk",
        imageUrl:
            "https://chriskresser.com/wp-content/uploads/raw-milk-1-e1563894986431.jpg",
        points: 100),
    Coupon(
        id: "1",
        title: "Milk3",
        storeId: "2",
        description: "1+1 Milk",
        imageUrl:
            "https://chriskresser.com/wp-content/uploads/raw-milk-1-e1563894986431.jpg",
        points: 100),
    Coupon(
        id: "1",
        title: "Milk4",
        storeId: "2",
        description: "1+1 Milk",
        imageUrl:
            "https://chriskresser.com/wp-content/uploads/raw-milk-1-e1563894986431.jpg",
        points: 100),
    Coupon(
        id: "1",
        title: "Milk5",
        storeId: "2",
        description: "1+1 Milk",
        imageUrl:
            "https://chriskresser.com/wp-content/uploads/raw-milk-1-e1563894986431.jpg",
        points: 100),
    Coupon(
        id: "1",
        title: "Milk6",
        storeId: "2",
        description: "1+1 Milk",
        imageUrl:
            "https://chriskresser.com/wp-content/uploads/raw-milk-1-e1563894986431.jpg",
        points: 100)
  ];
  ManageCoupons();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            elevation: 0.0,
            centerTitle: true,
            leading: Icon(
              Icons.face,
              size: 45,
            ),
            actions: [
              Container(
                width: 60,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(20))),
                child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    onPressed: null),
              )
            ],
          ),
          body: Column(
            children: [
              Stack(children: [
                Card(
                  color: Theme.of(context).hintColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.fromLTRB(25, 8, 25, 8),
                  child: Container(
                      height: constraints.maxHeight * 0.1,
                      width: double.infinity,
                      margin: EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          'ניהול קופונים',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 35),
                        ),
                      )),
                ),
                Center(
                    child: Icon(Icons.face_rounded,
                        size: 80, color: Theme.of(context).accentColor))
              ]),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return BusinessCoupon(coupon: availableCoupons[index]);
                  },
                  itemCount: availableCoupons.length,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    child: FlatButton(
                      height: constraints.maxHeight * 0.10,
                      color: Theme.of(context).hintColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          'חזרה',
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: FlatButton(
                      height: constraints.maxHeight * 0.10,
                      color: Theme.of(context).hintColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          'יצירת קופון',
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ));
    });
  }
}
