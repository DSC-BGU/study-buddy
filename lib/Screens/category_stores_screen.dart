import 'package:flutter/material.dart';
import '../widgets/store_item.dart';
import '../models/store.dart';

class CategoryStoresScreen extends StatefulWidget {
  static const routName = '/category-stores';

  final List<Store> relevantStores;

  CategoryStoresScreen(this.relevantStores);

  @override
  _CategoryStoresScreenState createState() => _CategoryStoresScreenState();
}

class _CategoryStoresScreenState extends State<CategoryStoresScreen> {
  String categoryTitle;
  List<Store> relevantStores;
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
      // displayedMeals = widget.availableMeals.where((meal) {
      //   return meal.categories.contains(categoryId);
      // }).toList();
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
          return StoreItem(
            id: relevantStores[index].id,
            name: relevantStores[index].name,
            adress: relevantStores[index].adress,
            imageURL: relevantStores[index].imageUrl,
            description: relevantStores[index].description,
            cupons: relevantStores[index].cupons,
            categories: relevantStores[index].categories,
          );
        },
        itemCount: relevantStores.length,
      ),
    );
  }
}
