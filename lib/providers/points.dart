import 'package:flutter/material.dart';
import 'package:study_buddy/models/PointsHistory.dart';

// ignore: non_constant_identifier_names
List<PointsHistory> DUMMY_HISTORY = [
  PointsHistory(DateTime.now(), 35),
  PointsHistory(
      DateTime.now().subtract(
        Duration(days: 1),
      ),
      10),
  PointsHistory(
      DateTime.now().subtract(
        Duration(days: 2),
      ),
      30),
  PointsHistory(
      DateTime.now().subtract(
        Duration(days: 3),
      ),
      17),
  PointsHistory(
      DateTime.now().subtract(
        Duration(days: 4),
      ),
      17),
];

class Points with ChangeNotifier {
  List<PointsHistory> _history =
      DUMMY_HISTORY; // TODO: replace it with real data

  int _currentPoints = 520;

  List<PointsHistory> get history {
    return [..._history];
  }

  int get currentPoints {
    return _currentPoints;
  }

  void updatePoints(newPoints) {
    _currentPoints = newPoints;
    notifyListeners();
  }

  void addPoints(newPoints) {
    _currentPoints = _currentPoints + newPoints;
    notifyListeners();
  }

  void substructPoints(newPoints) {
    _currentPoints = _currentPoints - newPoints;
    notifyListeners();
  }

  void addNewHistory(PointsHistory historyData) {
    _history.add(historyData);
    notifyListeners();
  }

  void focusSuccesss(int minutes) {
    this.addPoints(minutes * 3);
  }
}
