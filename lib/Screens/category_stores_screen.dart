import 'package:flutter/material.dart';
import '../widgets/store_item.dart';
import '../models/store.dart';

class CategoryStoresScreen extends StatefulWidget {
  static const routeName = '/category-stores';

  final List<Store> availableStores;

  CategoryStoresScreen(this.availableStores);

  @override
  _CategoryStoresScreenState createState() => _CategoryStoresScreenState();
}

class _CategoryStoresScreenState extends State<CategoryStoresScreen> {
  String categoryTitle;
  List<Store> displayedStores;
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
      displayedStores = widget.availableStores.where((store) {
        return store.categories.contains(categoryId);
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
          return StoreItem(
            id: displayedStores[index].id,
            name: displayedStores[index].name,
            adress: displayedStores[index].adress,
            imageURL: displayedStores[index].imageUrl,
            description: displayedStores[index].description,
            cupons: displayedStores[index].cupons,
            categories: displayedStores[index].categories,
          );
        },
        itemCount: displayedStores.length,
      ),
    );
  }
}
