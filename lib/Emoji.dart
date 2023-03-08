import 'dart:math';

import 'package:flutter/material.dart';

class EmojiPainter extends CustomPainter {
  final Color facecolor;
  EmojiPainter({required this.facecolor});
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final centreWidth = width / 2;
    final centreHeight = height / 2;

    final radius = min(width, height) / 2;
    final eyeradius = radius * 0.2;
    final mouthradius = radius * 0.4;
    final eyeDisplacementradius = radius * 0.4;
    final eyeballradius = eyeradius * 0.4;
    final mouthHeightDisplacementview = radius * 0.2;

    final facePaint = Paint()..color = facecolor;
    final eyePaint = Paint()..color = Colors.white;
    final eyeballpaint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.stroke;

    final centre = Offset(centreWidth, centreHeight);
    final lefteyeoffset = Offset(centreWidth - eyeDisplacementradius,
        centreHeight - eyeDisplacementradius);
    final righteyeoffset = Offset(centreWidth + eyeDisplacementradius,
        centreHeight - eyeDisplacementradius);

    final mouthoffset =
        Offset(centreWidth, centreHeight + mouthHeightDisplacementview);
    final mouthRect = Rect.fromCircle(center: mouthoffset, radius: mouthradius);

//DRAW SMILY FACE
    canvas.drawCircle(centre, radius, facePaint);

    //DRAW LEFT EYE
    canvas.drawCircle(lefteyeoffset, eyeradius, eyePaint);

    //DRAW RIGHT EYE
    canvas.drawCircle(righteyeoffset, eyeradius, eyePaint);

    //DRAW EYEBALL
    canvas.drawCircle(lefteyeoffset, eyeballradius, eyeballpaint);

    //DRAW EYEBALL
    canvas.drawCircle(righteyeoffset, eyeballradius, eyeballpaint);

    canvas.drawArc(
        mouthRect, degtoredian(0), degtoredian(180), false, eyeballpaint);
  }

  double degtoredian(double deg) => deg * pi / 180;

  @override
  bool shouldRepaint(EmojiPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(EmojiPainter oldDelegate) => false;
}
