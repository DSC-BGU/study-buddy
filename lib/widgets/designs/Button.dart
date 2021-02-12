import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Function onPressed;
  Widget child;
  double width;
  bool yellow;
  bool black;
  Color color;
  Button({@required this.onPressed, @required this.child, this.width, this.color, this.black = false, this.yellow = false});
  @override
  Widget build(BuildContext context) {
    Color color;
    if(this.color != null){
      color = this.color;
    }
    else if (this.yellow) {
      color = Theme.of(context).accentColor;
    }
    else if(this.black){
      color = Theme.of(context).hintColor;
    }
    else{
      color = Theme.of(context).primaryColor;
    }
    return FlatButton(
      minWidth: this.width!=null ? this.width :  MediaQuery.of(context).size.width * 0.5,
      onPressed: onPressed,
      child: child,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      textColor: this.black ? Colors.white : Colors.black,
      height: MediaQuery.of(context).size.height * 0.045,
    );
  }
}
