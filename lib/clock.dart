import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

//THIS CODE IS LIKE A PUB PAKAGE AND BEST APPROCH FOR CODING AND 

class MyClock extends StatefulWidget {
  const MyClock({this.height = 300, this.width = 300, super.key});
  final double width, height;

  @override
  State<MyClock> createState() => _MyClockState();
}

class _MyClockState extends State<MyClock> {
  DateTime dateTime = DateTime.now();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          setState(() {
            dateTime = DateTime.now();
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(painter: ClockPainter(datetime: dateTime)),
    );
  }
}

class ClockPainter extends CustomPainter {
  DateTime datetime;
  ClockPainter({required this.datetime});
  double degToRadian(num deg) => deg * pi / 180;
  double minute = 57;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    var angle = 2 * pi / 60;
    const hourTickMarkLength = 30.0;
    const minuteTickMarkLength = 7.0;

    const hourTickMarkWidth = 6.0;
    const minuteTickMarkWidth = 3.0;
    const needleWidth = 4.0;
    double tickMarkLength;
    var needleColor = Colors.orange;
    Paint needlePaint = Paint()
      ..color = needleColor
      ..strokeWidth = 7;
    final romanNumeralList = [
      'XII',
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
      'VIII',
      'IX',
      'X',
      'XI'
    ];

    TextPainter textPainter = TextPainter();
    Paint tickPaint = Paint()..color = Colors.amber;

    canvas.drawCircle(
        center,
        radius,
        Paint()
          ..shader = const LinearGradient(colors: [Colors.black, Colors.grey])
              .createShader(Rect.fromCircle(center: center, radius: radius)));
    canvas.drawCircle(center, radius * 0.08, Paint()..color = Colors.orange);

    canvas.save();
    // drawing
    canvas.translate(radius, radius);

    canvas.drawLine(
        const Offset(-needleWidth, 0), Offset(0.0, -radius + 50), needlePaint);
    canvas.drawLine(
        const Offset(needleWidth, 0), Offset(0.0, -radius + 50), needlePaint);

    canvas.drawCircle(Offset.zero, radius * 0.04, Paint()..color = Colors.lime);
    // double angleMinute = minute - 15.0;
    // Offset handOffset = Offset(cos(degToRadian(angleMinute * 6.0)) * radius,
    //     sin(degToRadian(angle * 6.0)) * radius);

    for (var i = 0; i < 60; i++) {
      var isHour = i % 5 == 0;
      tickMarkLength = isHour ? hourTickMarkLength : minuteTickMarkLength;
      tickPaint.strokeWidth = isHour ? hourTickMarkWidth : minuteTickMarkWidth;
      tickPaint.color = isHour ? Colors.deepOrange : Colors.amber;
      canvas.drawLine(Offset(0, -radius),
          Offset(0, -radius + minuteTickMarkLength), tickPaint);

      if (minute == i) {
        var handOffset = Offset(0, -radius + tickMarkLength * 5);
        canvas.drawLine(
            const Offset(0, -needleWidth),
            handOffset, // Offset(-radius + 50, 0.0),
            Paint()
              ..color = Colors.lime
              ..strokeWidth = 5);
        canvas.drawLine(
            const Offset(0, needleWidth),
            handOffset, //Offset(-radius + 50, 0.0),
            Paint()
              ..color = Colors.lime
              ..strokeWidth = 5);
      }
      if (isHour) {
        canvas.save();
        canvas.translate(0.0, -radius + 30);
        textPainter.textDirection = TextDirection.ltr;
        textPainter.text = TextSpan(
            text: romanNumeralList[(i ~/ 5)],
            style: const TextStyle(fontSize: 20, color: Colors.white));
        canvas.rotate(-angle * i);
        textPainter.layout();

        textPainter.paint(canvas,
            Offset(-(textPainter.width / 2), -(textPainter.height / 2)));

        canvas.restore();
      }
      canvas.rotate(angle);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(ClockPainter oldDelegate) => true;
}

double degToRadian(double deg) {
  return deg * pi / 180;
}
