import 'package:flutter/material.dart';

class SingleCupon extends StatelessWidget {
  SingleCupon();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(15),
            leading: Icon(Icons.article_rounded),
            trailing: Column(
              children: [
                Text(
                  'Navigate',
                ),
                Text('Phone Number')
              ],
            ),
            title: Text(
              'Store Name',
              style: TextStyle(fontSize: 25),
            ),
            subtitle: Text(
              'Store Description',
              style: TextStyle(fontSize: 20),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('Use Cupon'),
                onPressed: () {/* ... */},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
