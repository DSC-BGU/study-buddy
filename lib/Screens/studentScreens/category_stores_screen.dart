import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';
import '../../models/sharedModels/Category.dart' as Cat;
import '../../models/sharedModels/Store.dart';
import '../../providers/sharedProviders/StoreProvider.dart';
import '../../widgets/studentWidgets/CategoryScreen/store_item.dart';

class CategoryStoresScreen extends StatelessWidget {
  static const routeName = '/category-stores';

  CategoryStoresScreen();

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Cat.Category;
    String categoryTitle = routeArgs.title;
    String categoryId = routeArgs.id;
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);
    List<Store> availableStores =
        storeProvider.filterStoresByCategory(categoryId);
    String t(String text) => AppLocalizations.of(context).translate(text);
    return Scaffold(
      appBar: AppBar(
        title: Text(t(categoryTitle)),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return StoreItem(
            store: availableStores[index],
          );
        },
        itemCount: availableStores.length,
      ),
    );
  }
}
