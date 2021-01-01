import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import './user_provider.dart';

class FocusProvider with ChangeNotifier {
  Duration _remainTime = Duration(minutes: 60);
  Duration _targetTime = Duration(minutes: 60);
  Timer _timer;
  bool _focus = false;

  Duration get remainTime {
    return Duration(seconds: _remainTime.inSeconds);
  }

  Duration get targetTime {
    return Duration(seconds: _targetTime.inSeconds);
  }

  bool get focusStatus {
    return _focus == true;
  }

  void setTime(newDuration) {
    _remainTime = newDuration;
    _targetTime = newDuration;
    notifyListeners();
  }

  void onFocus(context) {
    const oneMinutes = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneMinutes, (Timer timer) {
      if (_remainTime.inMinutes < 1) {
        timer.cancel();
        UserProvider userProvider =
            Provider.of<UserProvider>(context /*, listen: false*/);
        userProvider.addUserPoints(_targetTime.inMinutes);
        _focus = false;
      } else {
        _remainTime = Duration(minutes: _remainTime.inMinutes - 1);
      }
      notifyListeners();
    });
    _focus = true;
    notifyListeners();
  }

  void outOfFocus() {
    _focus = false;
    _timer.cancel();
    notifyListeners();
  }
}
