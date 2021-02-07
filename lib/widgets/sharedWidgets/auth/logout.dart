import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../app_localizations.dart';
import '../../../providers/studentProviders/user_provider.dart';

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return FlatButton.icon(
        icon: Icon(Icons.exit_to_app),
        label: Text(t("logout")),
        onPressed: (){
          UserProvider userProvider =
              Provider.of<UserProvider>(context, listen: false);
          userProvider.logout();
        });
    //   DropdownButton(
    //   icon: Icon(
    //     Icons.more_vert,
    //     color: Theme.of(context).primaryIconTheme.color,
    //   ),
    //   items: [
    //     DropdownMenuItem(
    //       child: Container(
    //         child: Row(
    //           children: <Widget>[
    //             Icon(Icons.exit_to_app),
    //             SizedBox(width: 8),
    //             Text(t('Logout')),
    //           ],
    //         ),
    //       ),
    //       value: 'logout',
    //     ),
    //   ],
    //   onChanged: (itemIdentifier) {
    //     if (itemIdentifier == 'logout') {
    //       UserProvider userProvider =
    //           Provider.of<UserProvider>(context, listen: false);
    //       userProvider.logout();
    //     }
    //   },
    // );
  }
}
