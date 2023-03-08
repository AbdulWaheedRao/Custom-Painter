import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0.4, 0.4, size.width - 0.8, size.height - 0.8);
    Paint paint = Paint()
      ..color = Colors.amber
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.bevel
      //STROKECAP IS USED IN DRAWLINE
      ..strokeCap = StrokeCap.square
      ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.indigo,
            Color.fromARGB(255, 82, 83, 83),
            Color.fromARGB(255, 230, 89, 89)
          ]).createShader(rect);
    canvas.drawRect(rect, paint);
    canvas.drawLine(Offset(80, 80), Offset(size.width - 80, 80), paint);
    canvas.drawLine(Offset(80, 85), Offset(80, 200), paint);
    canvas.drawLine(Offset(size.width * 0.27, size.height * 0.68),
        Offset(size.width * 0.75, size.height * 0.68), paint);
    canvas.drawLine(Offset(size.width * 0.75, size.height * 0.27),
        Offset(size.width * 0.75, size.height * 0.67), paint);
    canvas.drawLine(Offset(size.width * 0.29, size.height * 0.3),
        Offset(size.width * 0.74, size.height * 0.67), paint);
    canvas.drawLine(Offset(size.width * 0.29, size.height * 0.65),
        Offset(size.width * 0.73, size.height * 0.3), paint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(MyPainter oldDelegate) => false;
}

