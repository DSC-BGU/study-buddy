import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:study_buddy/Screens/businessScreens/ScannerScreen.dart';
import 'package:study_buddy/providers/studentProviders/user_provider.dart';
import 'package:study_buddy/widgets/sharedWidgets/auth/logout.dart';
import 'package:provider/provider.dart';

import '../../app_localizations.dart';

class BusinessMainScreen extends StatelessWidget {
  static const String routeName = '/businessMainScreen';
  void toScan(BuildContext context){
    Navigator.pushNamed(context, ScannerScreen.routeName);
  }
  @override
  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(userProvider.name),
        actions: <Widget>[
          Logout()
        ],
      ),
      floatingActionButton: FloatingActionButton(child: Icon(AntDesign.barcode),onPressed: (){toScan(context);},),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              leading: Icon(AntDesign.barcode),
              title: Text(t("Scan Barcode")),
              onTap: (){
                toScan(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
