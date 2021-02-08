import 'package:flutter/material.dart';

class TopCurve extends StatelessWidget {
  int startPercent;

  int endPercent;

  Color color;

  TopCurve({this.startPercent = 80, this.endPercent = 100, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: CurvePainter(
          color:
              this.color == null ? Theme.of(context).primaryColor : this.color,
          endPercent: this.endPercent,
          startPercent: this.startPercent,
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  int startPercent;
  int endPercent;
  Color color;
  CurvePainter(
      {@required this.startPercent,
      @required this.endPercent,
      @required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = this.color;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;

    var path = Path();

    path.moveTo(0, size.height * (startPercent / 100));
    path.quadraticBezierTo(size.width * 0.5, size.height * (endPercent / 100),
        size.width, size.height * (startPercent / 100));
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
