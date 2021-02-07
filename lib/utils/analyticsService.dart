import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();
  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);
  Future setUserProperties({@required String userId, String userType, String name}) async {
    await _analytics.setUserId(userId);
    await _analytics.setUserProperty(name: 'userType', value: userType);
    await _analytics.setUserProperty(name: 'name', value: name);
  }
  Future logEvent({@required EventTypes eventName, parameters}) async {
    String name = eventName.toString().replaceAll("EventTypes.", "");
    await _analytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}

enum EventTypes{
  StartFocus,
  FocusFail,
  FocusSuccess,
  BuyCoupon,
}