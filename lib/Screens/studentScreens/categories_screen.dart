import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';
import 'package:study_buddy/utils/HexColor.dart';
import 'package:study_buddy/widgets/designs/Background.dart';
import 'package:study_buddy/widgets/designs/Button.dart';
import 'package:study_buddy/widgets/designs/TopCurve.dart';
import '../../app_localizations.dart';
import '../../models/sharedModels/Category.dart' as Cat;
import '../../providers/sharedProviders/StoreProvider.dart';
import '../../widgets/studentWidgets/CategoryScreen/advertising.dart';
import '../../widgets/studentWidgets/CategoryScreen/category_item.dart';
import 'DrawerButton.dart';
import 'MyCoupons.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories';

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    UserProvider user = Provider.of<UserProvider>(context);
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);
    List<Cat.Category> categoriesList = storeProvider.categories;
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return Stack(
              children: [
                Background(),
                DrawerButton(),
                Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: constraints.maxHeight * 0.03,
                            bottom: constraints.maxHeight * 0.03),
                        child: Container(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: constraints.maxHeight * 0.07,
                                backgroundImage:
                                    AssetImage("assets/avatar_temp.jpg"),
                              ),
                              Text(
                                t("Hii") + " " + user.name,
                                style: TextStyle(fontSize: 34),
                              ),
                              Text("You have" +
                                  " " +
                                  user.points.toString() +
                                  " " +
                                  "points"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              // child: Flexible(
                              child: GridView.count(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(15),
                                children: categoriesList
                                    .map((c) => CategoryItem(c))
                                    .toList(),
                              ),
                              // ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Button(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(MyCoupons.routeName);
                                  },
                                  child: Text(t("My coupons")),
                                  icon: Icon(Ionicons.md_pricetag),
                                  width: constraints.maxWidth * 0.7,
                                  color: HexColor("#E1E0E0"),
                                  height: constraints.maxHeight * 0.08,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
