import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';
import '../../app_localizations.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    bool rtl = AppLocalizations.of(context).isRtl();
    return LayoutBuilder(builder: (ctx, constraints) {
      return Row(
        mainAxisAlignment:
            rtl ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Container(
            height: constraints.maxHeight * 0.09,
            decoration: BoxDecoration(
                color: userProvider.business
                    ? Theme.of(context).primaryColor
                    : Theme.of(context)
                        .accentColor, // @TODO: change for primaryColor when used at business part
                borderRadius: new BorderRadius.only(
                    bottomLeft: const Radius.circular(10))),
            child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  if (rtl) {
                    Scaffold.of(context).openDrawer();
                  } else {
                    Scaffold.of(context).openEndDrawer();
                  }
                }),
          ),
        ],
      );
    });
  }
}
