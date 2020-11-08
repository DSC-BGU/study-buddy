import 'package:flutter/material.dart';
import 'package:study_buddy/widgets/FocusTimer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: FocusTimer(),
        ),
      ),
    );
  }
}
