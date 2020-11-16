import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  StoreScreen();
  static const routhName = "/store";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store"),
      ),
      body: Card(
        child: Text("myStore"),
      ),
    );
  }
}
