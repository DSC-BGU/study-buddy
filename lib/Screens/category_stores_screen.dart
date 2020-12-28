import 'package:flutter/material.dart';
import 'package:study_buddy/app_localizations.dart';
import 'package:study_buddy/models/Category.dart' as cat;
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
  List<Store> availableStores;
  CategoryStoresScreen(this.availableStores) {
    List<Store> tmp = [];
    this.availableStores.forEach((store) {
      store.categories.forEach((category) {
        category.title == categoryTitle ? tmp.add(store) : null;
      });
    });
    print(tmp);
    availableStores = tmp;
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as cat.Category;
    categoryTitle = routeArgs.title;
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
