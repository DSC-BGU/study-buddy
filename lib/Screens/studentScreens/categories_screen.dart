import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/Screens/studentScreens/DrawerMenu.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';
import 'package:study_buddy/utils/HexColor.dart';
import 'package:study_buddy/widgets/designs/Background.dart';
import 'package:study_buddy/widgets/designs/Button.dart';
import '../../app_localizations.dart';
import '../../models/sharedModels/Category.dart' as Cat;
import '../../providers/sharedProviders/StoreProvider.dart';
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
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
      endDrawer: !AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return Stack(
              children: [
                Background(),
                DrawerButton(),
                Container(
                  // width: double.infinity,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: constraints.maxHeight * 0.03,
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: constraints.maxHeight * 0.07,
                              backgroundImage: user.imageProvider,
                            ),
                            Text(
                              t("Hi") + " " + user.name,
                              style: TextStyle(fontSize: 34),
                            ),
                            Text(t("You have") +
                                " " +
                                user.points.toString() +
                                " " +
                                t("points")),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   child:
                      Container(
                        margin:
                            EdgeInsets.only(top: constraints.maxHeight * 0.014),
                        width: double.infinity,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: constraints.maxHeight * 0.7,
                              width: constraints.maxWidth * 0.8,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GridView.count(
                                crossAxisCount: 3,
                                // crossAxisSpacing: 6,
                                mainAxisSpacing: constraints.maxHeight * 0.03,
                                shrinkWrap: true,
                                children: categoriesList
                                    .map(
                                      (c) => CategoryItem(
                                        category: c,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 15,
                  ),
                  child: Button(
                    onPressed: () {
                      Navigator.of(context).pushNamed(MyCoupons.routeName);
                    },
                    child: Text(t("My coupons")),
                    icon: Icon(Ionicons.md_pricetag),
                    width: constraints.maxWidth * 0.7,
                    color: HexColor("#E1E0E0"),
                    height: constraints.maxHeight * 0.08,
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
