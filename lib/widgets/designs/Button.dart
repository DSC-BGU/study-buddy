import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Function onPressed;
  Widget child;
  double width;
  bool pink;
  bool black;
  Color color;
  double height;
  Icon icon;

  Button(
      {@required this.onPressed,
      @required this.child,
      this.width,
      this.color,
      this.black = false,
      this.pink = false,
      this.height,
      this.icon});

  @override
  Widget build(BuildContext context) {
    Color color;
    if (this.color != null) {
      color = this.color;
    } else if (this.pink) {
      color = Theme.of(context).accentColor;
    } else if (this.black) {
      color = Theme.of(context).hintColor;
    } else {
      color = Theme.of(context).primaryColor;
    }
    if (icon == null)
      return FlatButton(
        minWidth: this.width != null
            ? this.width
            : MediaQuery.of(context).size.width * 0.5,
        onPressed: onPressed,
        child: child,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textColor: this.black ? Colors.white : Colors.black,
        height: this.height != null
            ? this.height
            : MediaQuery.of(context).size.height * 0.045,
      );
    else {
      return FlatButton.icon(
        minWidth: this.width != null
            ? this.width
            : MediaQuery.of(context).size.width * 0.5,
        onPressed: onPressed,
        label: child,
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        textColor: this.black ? Colors.white : Colors.black,
        height: this.height != null
            ? this.height
            : MediaQuery.of(context).size.height * 0.045,
        icon: icon,
      );
    }
  }
}
