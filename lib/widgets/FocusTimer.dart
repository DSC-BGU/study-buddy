import 'dart:async';
import 'package:flutter/material.dart';
import 'package:is_lock_screen/is_lock_screen.dart';
import '../providers/studentProviders/FocusProvider.dart';
import 'package:provider/provider.dart';
import '../app_localizations.dart';
import 'package:screen_state/screen_state.dart';

class FocusTimer extends StatefulWidget {
  FocusTimer({Key key, this.child, this.onOutFocus, this.onStartFocus})
      : super(key: key);
  final void Function() onStartFocus;
  final void Function() onOutFocus;
  final Widget child;
  @override
  _FocusTimerState createState() => _FocusTimerState();
}

class _FocusTimerState extends State<FocusTimer> with WidgetsBindingObserver {
  Screen _screen = Screen();
  bool _screenTurnedOff = false;
  bool started = false;
  StreamSubscription<ScreenStateEvent> _subscription;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPlatformState();
  }

  @override
  void dispose() {
    try {
      WidgetsBinding.instance.removeObserver(this);
      super.dispose();
    } catch (err) {}
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    FocusProvider focusProvider =
    Provider.of<FocusProvider>(context, listen: false);
    if (focusProvider.focusStatus){
      isLockScreen().then((inLockScreen) {
        if (state == AppLifecycleState.resumed && !inLockScreen && !_screenTurnedOff) {
          focusProvider.outOfFocus(context);
        }
        setState(() {
          _screenTurnedOff = false;
        });
      });
    }
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
      setState(() {
        _subscription = _screen.screenStateStream.listen(onData);
      });
    } on ScreenStateException catch (exception) {
      print(exception);
    }
  }

  void stopListening (){
    if(_subscription!= null)
      _subscription.cancel();
  }

  void onPress (FocusProvider focusProvider){
    if (focusProvider.focusStatus){
      focusProvider.outOfFocus(context);
    }
    else{
      focusProvider.onFocus(context);
    }
  }

  Widget build(BuildContext context) {
    String t(String text) => AppLocalizations.of(context).translate(text);
    FocusProvider focusProvider = Provider.of<FocusProvider>(context);
    return WillPopScope(
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          child: RaisedButton(
            shape: new CircleBorder(),
            elevation: 2,
            child: Text(focusProvider.focusStatus ? t('Give up') : t('Start')),
            onPressed: (){this.onPress(focusProvider);},
            color: Theme.of(context).primaryColor,
          ),
        );
      }),
      onWillPop: () async {
        stopListening();
        return true;
      },
    );
  }
}
