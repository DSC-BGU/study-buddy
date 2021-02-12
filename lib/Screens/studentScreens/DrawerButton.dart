import 'package:flutter/material.dart';
import '../../app_localizations.dart';

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool rtl = AppLocalizations.of(context).isRtl();
    return Row(
      mainAxisAlignment: rtl ? MainAxisAlignment.start :  MainAxisAlignment.end,
      children: [
        IconButton(icon: Icon(Icons.menu), onPressed: (){
          if (rtl){
            Scaffold.of(context).openDrawer();
          }
          else{
            Scaffold.of(context).openEndDrawer();
          }
        }),
      ],
    );
  }
}