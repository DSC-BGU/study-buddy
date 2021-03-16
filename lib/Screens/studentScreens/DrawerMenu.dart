import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';

import '../../app_localizations.dart';
import 'MyCoupons.dart';
import 'categories_screen.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ListView(padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: <Widget>[
              DrawerHeader(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height *0.1,
                            width: MediaQuery.of(context).size.height *0.1,
                            margin: EdgeInsets.only(left:10),
                            child: CircleAvatar(
                              backgroundImage: userProvider.image == null
                                  ? AssetImage("assets/avatar_temp.jpg")
                                  : NetworkImage(userProvider.image),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                                  Text(userProvider.name),
                                  Text(userProvider.points.toString() +
                                      " " +
                                      t("points")),
                                ],
                              ))
                        ],
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text(t("Home Screen")),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/');
                  },
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  leading: Icon(MaterialCommunityIcons.wallet),
                  title: Text(t("My Coupons")),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(MyCoupons.routeName);
                  },
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  leading: Icon(Icons.shopping_bag),
                  title: Text(t("Coupons Store")),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(CategoriesScreen.routeName);
                  },
                ),
              ),
            ]),
          ),
          Column(children: [
            Divider(),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(t("Logout")),
                onTap: () {
                  Navigator.pop(context);
                  UserProvider userProvider =
                  Provider.of<UserProvider>(context, listen: false);
                  userProvider.logout();
                },
              ),
            ),
          ],)
        ],
      ),
    );
  }
}
