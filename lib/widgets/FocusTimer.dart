import 'package:flutter/material.dart';
import 'package:is_lock_screen/is_lock_screen.dart';
import 'package:wakelock/wakelock.dart';
import '../app_localizations.dart';

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
  bool _focus = false;
  bool started = false;
  bool _screenTurnedOff = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }


  @override
  void dispose() {
    try {
      WidgetsBinding.instance.removeObserver(this);
      super.dispose();
    } catch (err) {}
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive && await isLockScreen()) {
      _screenTurnedOff = true;
    }
    if (state == AppLifecycleState.resumed && !_screenTurnedOff) {
      this.outOfFocus();
    }
  }

  void outOfFocus() {
    if (widget.onOutFocus != null) {
      widget.onOutFocus();
    }
    setState(() {
      _focus = false;
      // Wakelock.toggle(enable: false);
    });
    print("out of focus!");
  }

  void startFocus() {
    if (widget.onStartFocus != null) {
      widget.onStartFocus();
    }
    this.setState(() {
      _focus = true;
      // Wakelock.toggle(enable: true);
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
