import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../app_localizations.dart';

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return DropdownButton(
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).primaryIconTheme.color,
      ),
      items: [
        DropdownMenuItem(
          child: Container(
            child: Row(
              children: <Widget>[
                Icon(Icons.exit_to_app),
                SizedBox(width: 8),
                Text(t('Logout')),
              ],
            ),
          ),
          value: 'logout',
        ),
      ],
      onChanged: (itemIdentifier) {
        if (itemIdentifier == 'logout') {
          UserProvider userProvider =
              Provider.of<UserProvider>(context, listen: false);
          userProvider.logout();
        }
      },
    );
  }
}
