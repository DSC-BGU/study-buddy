import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/Screens/studentScreens/DrawerButton.dart';
import 'package:study_buddy/Screens/studentScreens/DrawerMenu.dart';
import 'package:study_buddy/widgets/designs/Background.dart';
import '../../app_localizations.dart';
import '../../models/sharedModels/Category.dart' as Cat;
import '../../models/sharedModels/Store.dart';
import '../../providers/sharedProviders/StoreProvider.dart';
import '../../widgets/studentWidgets/CategoryScreen/store_item.dart';

class AllStoresScreen extends StatelessWidget {
  static const routeName = '/stores';

  AllStoresScreen();

  @override
  Widget build(BuildContext context) {
    StoreProvider storeProvider = Provider.of<StoreProvider>(context);
    List<Store> availableStores = storeProvider.availableStores;
    String t(String text) => AppLocalizations.of(context).translate(text);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
      endDrawer: !AppLocalizations.of(context).isRtl() ? DrawerMenu() : null,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return Stack(children: [
              Background(),
              Column(children: [
                Container(
                  height: constraints.maxHeight * 0.16,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: constraints.maxHeight * 0.03,
                          bottom: constraints.maxHeight * 0.03),
                      child: Text(
                        t("All Coupons"),
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverFixedExtentList(
                        itemExtent: constraints.maxWidth * 0.6,
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return StoreItem(
                              store: availableStores[index],
                            );
                          },
                          childCount: availableStores.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              DrawerButton(),
            ]);
          },
        ),
      ),
    );
  }
}
