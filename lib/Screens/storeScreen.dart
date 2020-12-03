import 'package:flutter/material.dart';
import 'package:study_buddy/widgets/dummy_data.dart';
import 'package:study_buddy/widgets/SingleCupon.dart';

class StoreScreen extends StatelessWidget {
  StoreScreen();

  static const routhName = "/store";

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
                selectedStore.imageURL,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Information'),
            buildContainer(Container(
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
                        child: Text('Category: ${selectedStore.categoryText}'),
                      ),
                    ),
                  ),
                ],
              ),
            )),
            buildSectionTitle(context, 'Cupons'),
            buildContainer(
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 8),
                      child: Text(
                        'My Cupons',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SingleCupon('Hamburger', '1+1 on all Hamburgers'),
                    SingleCupon('Beer', '20% of all beers'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
