import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      // onTap: () {
      //     context.read<AuthenticationProvider>().signOut();
      // },
      onChanged: (itemIdentifier) {
        if (itemIdentifier == 'logout') {
          FirebaseAuth.instance.signOut();
        }
      },
    );
  }
}
