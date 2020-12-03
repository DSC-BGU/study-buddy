import 'package:flutter/material.dart';
import 'package:study_buddy/models/my_cupon.dart';
import '../widgets/my_cupon_item.dart';
import '../models/my_cupon.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routName = '/category-cupones';

  final List<MyCupon> relevantCupons;

  CategoryMealsScreen(this.relevantCupons);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<MyCupon> relevantCupons;
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
          return CuponItem(
            id: relevantCupons[index].id,
            title: relevantCupons[index].title,
            storeId: relevantCupons[index].storeId,
            description: relevantCupons[index].description,
            imageUrl: relevantCupons[index].imageUrl,
            points: relevantCupons[index].points,
            categories: relevantCupons[index].categories,
          );
        },
        itemCount: relevantCupons.length,
      ),
    );
  }
}
