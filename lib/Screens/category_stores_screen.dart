import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/app_localizations.dart';
import 'package:study_buddy/models/Category.dart' as cat;
import 'package:study_buddy/providers/StoreProvider.dart';
import '../widgets/store_item.dart';
import '../models/Store.dart';

// class CategoryStoresScreen extends StatefulWidget {
//   static const routeName = '/category-stores';

//   final List<Store> availableStores;

//   CategoryStoresScreen(this.availableStores);

//   @override
//   _CategoryStoresScreenState createState() => _CategoryStoresScreenState();
// }

// class _CategoryStoresScreenState extends State<CategoryStoresScreen> {
//   String categoryTitle;
//   List<Store> displayedStores;
//   var _loadedInitData = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     if (!_loadedInitData) {
//       final routeArgs =
//           ModalRoute.of(context).settings.arguments as Map<String, String>;
//       categoryTitle = routeArgs['title'];
//       final categoryId = routeArgs['id'];
//       displayedStores = widget.availableStores.where((store) {
//         return store.categories.contains(categoryId);
//       }).toList();
//       _loadedInitData = true;
//     }
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String t(String text) => AppLocalizations.of(context).translate(text);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(categoryTitle),
//       ),
//       body: ListView.builder(
//         itemBuilder: (ctx, index) {
//           return StoreItem(
//             store: displayedStores[index],
//           );
//         },
//         itemCount: displayedStores.length,
//       ),
//     );
//   }
// }

class CategoryStoresScreen extends StatelessWidget {
  static const routeName = '/category-stores';
  String categoryTitle;
  String categoryId;
  List<Store> availableStores;

  CategoryStoresScreen();

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as cat.Category;
    categoryTitle = routeArgs.title;
    categoryId = routeArgs.id;
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);
    availableStores = storeProvider.filterStoresByCategory(categoryId);
    String t(String text) => AppLocalizations.of(context).translate(text);
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
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
