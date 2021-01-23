import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/Screens/studentScreens/FocusScreen/ResultScreen.dart';
import 'dart:async';

import './user_provider.dart';

enum FocusMode { solo, coop }

class FocusProvider with ChangeNotifier {
  Duration _remainTime = Duration(minutes: 60);
  Duration _targetTime = Duration(minutes: 60);
  Timer _timer;
  bool _focus = false;
  String _sessionId;
  int _joinCode;
  FocusMode _mode = FocusMode.solo;
  bool _sessionAdmin = true;
  StreamSubscription _subscription;

  Duration get remainTime {
    return Duration(seconds: _remainTime.inSeconds);
  }

  Duration get targetTime {
    return Duration(seconds: _targetTime.inSeconds);
  }

  bool get focusStatus {
    return _focus == true;
  }

  int get joinCode {
    return _joinCode;
  }

  FocusMode get mode {
    return _mode;
  }

  void setTime(newDuration) {
    if (!this._focus) {
      _remainTime = newDuration;
      _targetTime = newDuration;
      notifyListeners();
    }
  }

  void onFocus(context) {
    const oneMinutes = const Duration(seconds: 1);
    if (_sessionAdmin) {
      FirebaseFirestore.instance
          .collection('friendSessions')
          .doc(_sessionId)
          .update({
        'inFocus': true,
        'startTime': DateTime.now(),
        'targetTime': _targetTime.inMinutes,
      });
      _subscription = FirebaseFirestore.instance
          .collection("friendSessions")
          .where("JoinCode", isEqualTo: joinCode)
          .snapshots()
          .listen((event) {
        if (event.docs.isNotEmpty) {
          var session = event.docs[0];
          if (_focus && !session['inFocus']) {
            this.outOfFocus(context);
          }
        }
      });
    }
    if (!_sessionAdmin) {
      deleteSession();
    }
    _timer = new Timer.periodic(oneMinutes, (Timer timer) {
      int points = _targetTime.inMinutes;
      if (_remainTime.inMinutes < 1) {
        Navigator.of(context).pushReplacementNamed(ResultScreen.routeName,
            arguments: ResultScreenArguments(success: true, points: points));
        timer.cancel();
        UserProvider userProvider =
            Provider.of<UserProvider>(context, listen: false);
        userProvider.addUserPoints(points);
        _focus = false;
      } else {
        _remainTime = Duration(minutes: _remainTime.inMinutes - 1);
      }
      notifyListeners();
    });
    _focus = true;
    notifyListeners();
  }

  void outOfFocus(context) {
    int points = _targetTime.inMinutes;
    Navigator.of(context).pushReplacementNamed(ResultScreen.routeName,
        arguments: ResultScreenArguments(success: false, points: points));
    _focus = false;
    _timer.cancel();
    print(_mode);
    if (_mode == FocusMode.coop) {
      FirebaseFirestore.instance
          .collection('friendSessions')
          .doc(_sessionId)
          .update({
        'inFocus': false,
      });
      changeMode();
    }
    if (_subscription != null) _subscription.cancel();
    notifyListeners();
  }

  void changeMode() {
    if (_mode == FocusMode.solo) {
      _mode = FocusMode.coop;
      createSession();
      notifyListeners();
    } else {
      _mode = FocusMode.solo;
      if (_sessionAdmin) {
        deleteSession();
      }
      _sessionAdmin = true;
      _sessionId = null;
      _joinCode = null;
      notifyListeners();
    }
  }

  void createSession() async {
    _joinCode = 100000 + Random().nextInt(999999 - 100000);
    DocumentReference ref =
        await FirebaseFirestore.instance.collection('friendSessions').add({
      'inFocus': false,
      "createTime": DateTime.now(),
      "JoinCode": _joinCode,
    });
    _sessionId = ref.id;
    _mode = FocusMode.coop;
    notifyListeners();
  }

  void joinSession(int joinCode, context) {
    if (joinCode.toString().length != 6) {
      _sessionAdmin = true;
      _subscription.cancel();
    }
    _sessionAdmin = false;
    _subscription = FirebaseFirestore.instance
        .collection("friendSessions")
        .where("JoinCode", isEqualTo: joinCode)
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        var session = event.docs[0];
        print(session.id);
        _sessionId = session.id;
        _targetTime = Duration(minutes: session['targetTime']);
        _remainTime = Duration(minutes: session['targetTime']);
        print(session['targetTime']);
        if (session['inFocus'] && !_focus) {
          this.onFocus(context);
        } else if (_focus && !session['inFocus']) {
          this.outOfFocus(context);
        }
        notifyListeners();
      }
    });
  }

  void deleteSession() {
    FirebaseFirestore.instance
        .collection("friendSessions")
        .doc(_sessionId)
        .delete();
  }
}
