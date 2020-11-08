import 'dart:async';

import 'package:flutter/material.dart';
import 'package:screen_state/screen_state.dart';

class FocusTimer extends StatefulWidget {
  FocusTimer({Key key, this.onOutFocus, this.onStartFocus}) : super(key: key);
  final void Function() onStartFocus;
  final void Function() onOutFocus;
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
    if (event == ScreenStateEvent.SCREEN_OFF){
      setState(() {
        _screenTurnedOff=true;
      });
    }
  }
  void startListening() {
    try {
      _subscription = _screen.screenStateStream.listen(onData);
      setState(() => started = true);
    } on ScreenStateException catch (exception) {
      print(exception);
    }
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
    if (state == AppLifecycleState.resumed && _screenTurnedOff == false){
      if (widget.onOutFocus != null){
        widget.onOutFocus();
      }
      setState(() {
        _focus=false;
      });
    }
    setState(() {
      _screenTurnedOff = false;
    });
  }

  void startFocus() {
    if (widget.onStartFocus != null){
      widget.onStartFocus();
    }
    this.setState(() {
      _focus = true;
      _screenTurnedOff = false;
    });
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(_focus ? 'You are in focus 😊' : 'you are not in focus 😢', style: TextStyle(fontSize: 30),),
        RaisedButton(
          onPressed: this.startFocus,
          child: Text('Start Focus'),
        ),
      ],
    );
  }
}
