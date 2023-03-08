import 'dart:math';

import 'package:flutter/material.dart';

class namePainter extends CustomPainter {
  final DateTime dateTime;
  namePainter({required this.dateTime});
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final centreWidth = width / 2;
    final centreHeight = height / 2;
    final centre = Offset(centreWidth, centreHeight);

    final radius = min(width, height) / 2;
    final minuteticklength = radius * 0.05;
    final hourticklength = radius * 0.1;
    final angle = 2 * pi / 60;

    final paint = Paint()..color = Colors.amber;
    final hourtickpaint = Paint()
      ..color = Colors.black
      ..strokeWidth = radius * 0.025;
    final minutetickpaint = Paint()
      ..color = Colors.black
      ..strokeWidth = radius * 0.015;
//DRAW BACKGROUND CIRCLE FOR CLOCK FACE
    canvas.drawCircle(centre, radius, paint);
    //NEEDLE BASE
    canvas.drawCircle(centre, radius * 0.2, Paint()..color = Colors.blue);
    canvas.save();
    canvas.translate(centreWidth, centreHeight);
    for (var i = 0; i < 60; i++) {
      bool isHour = i % 5 == 0;
      var tickpaint = isHour ? hourtickpaint : minutetickpaint;
      var ticklength = isHour ? hourticklength : minuteticklength;
      int hour;
      if (dateTime.hour <= 12) {
        hour = dateTime.hour;
      } else {
        hour = dateTime.hour - 12;
      }
      //DRAW HOURS NEEDLE
      if (hour == i ~/ 5) {
        canvas.drawLine(
            Offset.zero,
            Offset(0, -radius * 0.6),
            Paint()
              ..color = Colors.green
              ..strokeWidth = radius * 0.13);
      }
      //DRAW MINUTE NEEDLE
      if (dateTime.second == i) {
        canvas.drawLine(
            Offset.zero,
            Offset(0, -radius * 0.8),
            Paint()
              ..color = Colors.blue
              ..strokeWidth = radius * 0.1);
      }
      //DRAW TICK
      canvas.drawLine(
          Offset(0, -radius), Offset(0, -radius + ticklength), tickpaint);
      //ROTATE CANVAS TO DRAW NEXT TICK
      canvas.rotate(angle);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(namePainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(namePainter oldDelegate) => true;
}
