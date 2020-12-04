import 'dart:async';

import 'package:flutter/material.dart';
import 'package:screen_state/screen_state.dart';
import 'package:study_buddy/widgets/MainScreen/StartButton.dart';

import '../app_localizations.dart';

class FocusTimer extends StatefulWidget {
  FocusTimer({Key key, this.child, this.onOutFocus, this.onStartFocus})
      : super(key: key);
  final void Function() onStartFocus;
  final void Function() onOutFocus;
  Widget child;
  @override
  _FocusTimerState createState() => _FocusTimerState();
}

class _FocusTimerState extends State<FocusTimer> with WidgetsBindingObserver {
  bool _focus = false;
  Screen _screen = Screen();
  bool _screenTurnedOff = false;
  StreamSubscription<ScreenStateEvent> _subscription;
  bool started = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> initPlatformState() async {
    startListening();
  }

  void onData(ScreenStateEvent event) {
    if (event == ScreenStateEvent.SCREEN_OFF) {
      setState(() {
        _screenTurnedOff = true;
      });
    }
  }

  void startListening() {
    try {
      _subscription = _screen.screenStateStream.listen(onData);
      setState(() => started = true);
    } on ScreenStateException catch (exception) {}
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && _screenTurnedOff == false) {
      this.outOfFocus();
    }
    setState(() {
      _screenTurnedOff = false;
    });
  }

  void outOfFocus() {
    if (widget.onOutFocus != null) {
      widget.onOutFocus();
    }
    setState(() {
      _focus = false;
    });
  }

  void startFocus() {
    if (widget.onStartFocus != null) {
      print('start - inside');
      widget.onStartFocus();
    }
    this.setState(() {
      _focus = true;
      _screenTurnedOff = false;
    });
  }

  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: constraints.maxHeight,
        child: RaisedButton(
          shape: new CircleBorder(),
          elevation: 2,
          child: Text(_focus ? t('Stop') : t('Start')),
          onPressed: _focus ? outOfFocus : startFocus,
          color: Theme.of(context).primaryColor,
        ),
      );
    });
  }
}
