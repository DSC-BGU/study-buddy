import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/SingleCupon.dart';

class StoreScreen extends StatelessWidget {
  static const routName = '/store-detail';
  StoreScreen();

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final storeId = ModalRoute.of(context).settings.arguments as String;
    final selectedStore = DUMMY_STORES[0];
    //.firstWhere((store) => store.id == storeId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedStore.name}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedStore.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Information'),
            Container(
              color: Colors.white38,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 300,
                    child: Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text('Adress:  ${selectedStore.adress}'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child:
                            Text('Description: ${selectedStore.description}'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        // TODO
                        child: Text('Category: ${selectedStore.categories}'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            buildSectionTitle(context, 'Cupons'),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 8),
                  ),
                  SingleCupon('Hamburger', '1+1 on all Hamburgers'),
                  SingleCupon('Beer', '20% of all beers'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
