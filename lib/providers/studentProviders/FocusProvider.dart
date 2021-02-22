import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_buddy/Screens/studentScreens/FocusScreen/ResultScreen.dart';
import 'package:study_buddy/main.dart';
import 'package:study_buddy/utils/analyticsService.dart';
import 'dart:async';

import './user_provider.dart';

enum FocusMode { solo, coop }

class FocusProvider with ChangeNotifier {
  Duration _remainTime = Duration(minutes: 60);
  Duration _targetTime = Duration(minutes: 60);
  Timer _timer;
  bool _focus = false;
  String _sessionId;
  String _joinCode;
  FocusMode _mode = FocusMode.solo;
  bool _sessionAdmin = false;
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

  String get joinCode {
    return _joinCode;
  }

  String get sessionId{
    return _sessionId;
  }

  bool get isAdmin{
    return _sessionAdmin;
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

  void onFocus(BuildContext context) {
    const oneMinutes = const Duration(seconds: 1);
    if (_mode == FocusMode.coop) {
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
        // TODO: fix what happend if you are not the host and try to start the session
        leaveSession();
      }
    }
    _timer = new Timer.periodic(oneMinutes, (Timer timer) {
      int points = _targetTime.inMinutes;
      if (_remainTime.inMinutes < 1) {
        Navigator.of(context).pushNamed(ResultScreen.routeName,
            arguments: ResultScreenArguments(success: true, points: points));
        timer.cancel();
        UserProvider userProvider =
            Provider.of<UserProvider>(context, listen: false);
        userProvider.addUserPoints(points);
        locator<AnalyticsService>()
            .logEvent(eventName: EventTypes.FocusSuccess, parameters: {
          "mode": _mode.toString(),
          'targetTime': _targetTime.inMinutes.toString(),
          "pointsEarned":points,
        });
        _focus = false;
      } else {
        _remainTime = Duration(minutes: _remainTime.inMinutes - 1);
      }
      notifyListeners();
    });
    _focus = true;
    locator<AnalyticsService>()
        .logEvent(eventName: EventTypes.StartFocus, parameters: {
      "mode": _mode.toString(),
      'targetTime': _targetTime.inMinutes.toString(),
    });
    notifyListeners();
  }

  void outOfFocus(BuildContext context) {
    int points = _targetTime.inMinutes;
    Navigator.of(context).pushNamed(ResultScreen.routeName,
        arguments: ResultScreenArguments(success: false, points: points));
    _focus = false;
    _timer.cancel();
    if (_mode == FocusMode.coop) {
      FirebaseFirestore.instance
          .collection('friendSessions')
          .doc(_sessionId)
          .update({
        'inFocus': false,
      });
      leaveSession();
    }
    locator<AnalyticsService>()
        .logEvent(eventName: EventTypes.FocusFail, parameters: {
      "mode": _mode.toString(),
      'targetTime': _targetTime.inMinutes.toString(),
      "pointsMissed":points,
    });
    if (_subscription != null) _subscription.cancel();
    notifyListeners();
  }

  void leaveSession() {
    _mode = FocusMode.solo;
    if (_sessionAdmin) {
      deleteSession();
    }
    _sessionAdmin = true;
    _sessionId = null;
    if (_subscription != null) _subscription.cancel();
    notifyListeners();
  }

  void createSession(BuildContext context) async {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    DocumentReference ref =
    await FirebaseFirestore.instance.collection('friendSessions').add({
      'inFocus': false,
      "createTime": DateTime.now(),
      "creator":userProvider.id,
      "targetTime": _targetTime.inMinutes
    });
    _sessionId = ref.id;
    _mode = FocusMode.coop;
    _sessionAdmin = true;
    notifyListeners();
  }

  void joinSession(String sessionId, context) {
    _subscription = FirebaseFirestore.instance
        .collection("friendSessions")
        .doc(sessionId)
        .snapshots()
        .listen((doc) {
      if (doc.exists) {
        var session = doc.data();
        _sessionId = sessionId;
        _targetTime = Duration(minutes: session['targetTime']);
        _remainTime = Duration(minutes: session['targetTime']);
        _mode = FocusMode.coop;
        if (session['inFocus'] && !_focus && mode == FocusMode.coop) {
          this.onFocus(context);
        } else if (_focus && !session['inFocus'] && mode == FocusMode.coop) {
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
