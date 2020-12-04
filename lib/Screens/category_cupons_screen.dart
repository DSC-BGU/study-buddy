import 'package:flutter/material.dart';
import '../widgets/my_coupon_item.dart';
import '../models/my_coupon.dart';

class CategoryCuponsScreen extends StatefulWidget {
  static const routName = '/category-coupones';

  final List<MyCoupon> availableCoupons;

  CategoryCuponsScreen(this.availableCoupons);

  @override
  _CategoryCuponsScreenState createState() => _CategoryCuponsScreenState();
}

class _CategoryCuponsScreenState extends State<CategoryCuponsScreen> {
  String categoryTitle;
  List<MyCoupon> displayedCoupons;
  var _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedCoupons = widget.availableCoupons.where((coupon) {
        return coupon.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return CouponItem(
            id: displayedCoupons[index].id,
            title: displayedCoupons[index].title,
            storeId: displayedCoupons[index].storeId,
            description: displayedCoupons[index].description,
            imageUrl: displayedCoupons[index].imageUrl,
            points: displayedCoupons[index].points,
            categories: displayedCoupons[index].categories,
          );
        },
        itemCount: displayedCoupons.length,
      ),
    );
  }
}