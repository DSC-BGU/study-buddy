import 'package:flutter/material.dart';
import 'package:study_buddy/app_localizations.dart';
import 'package:study_buddy/widgets/SingleCoupon.dart';
import '../models/Coupon.dart';

class CategoryCuponsScreen extends StatefulWidget {
  static const routeName = '/category-coupones';

  final List<Coupon> availableCoupons;

  CategoryCuponsScreen(this.availableCoupons);

  @override
  _CategoryCuponsScreenState createState() => _CategoryCuponsScreenState();
}

class _CategoryCuponsScreenState extends State<CategoryCuponsScreen> {
  String categoryTitle;
  List<Coupon> displayedCoupons;
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
    String t(String text) => AppLocalizations.of(context).translate(text);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return SingleCoupon(
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
