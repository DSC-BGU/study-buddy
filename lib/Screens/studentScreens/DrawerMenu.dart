import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/Screens/studentScreens/storeScreen.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';
import 'package:study_buddy/widgets/sharedWidgets/auth/logout.dart';

import '../../app_localizations.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Paid Attention", style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black
                    ),),
                  ),
                  ListTile(
                    leading: Icon(Icons.storefront),
                    title: Text(t("Tab Screen")),
                    onTap: (){
                      Navigator.of(context).pushNamed("tabScreen");
                    },
                  ),
                ],
              ),

              Column(
                children: [
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text(t("Logout")),
                    onTap: (){
                      UserProvider userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                      userProvider.logout();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}