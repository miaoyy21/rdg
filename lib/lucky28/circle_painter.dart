import 'dart:math';

import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final int total;
  final bool isRunning;
  final int selected;

  CirclePainter(
      {required this.total, required this.selected, required this.isRunning});

  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()..strokeWidth = 2.0;

    double maxRadius = size.width / 2;
    double angleStep = 2 * pi / total;

    for (int i = 0; i < total; i++) {
      double angle = i * angleStep - pi / 2;
      double radius = 16;

      var lineStyle = PaintingStyle.stroke;
      var lineColor = Colors.black;
      var textColor = Colors.black;

      if (selected == i) {
        lineStyle = PaintingStyle.fill;
        lineColor = Colors.black;
        textColor = Colors.white;
      }

      // 跟随数字的渐变色
      if (isRunning && selected >= 0) {
        if (selected % total == (i + 1) % total) {
          lineStyle = PaintingStyle.fill;
          lineColor = Colors.black54;
          textColor = Colors.white;
        }

        if (selected % total == (i + 2) % total) {
          lineStyle = PaintingStyle.fill;
          lineColor = Colors.black26;
          textColor = Colors.white;
        }
      }

      linePaint.style = lineStyle;
      linePaint.color = lineColor;

      // 绘制圆形背景
      double x = maxRadius * cos(angle) + size.width / 2;
      double y = maxRadius * sin(angle) + size.height / 2;
      canvas.drawCircle(Offset(x, y), radius, linePaint);

      // 绘制数字
      TextSpan span = TextSpan(
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
        text: '$i',
      );

      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      tp.layout();

      double textX = x - tp.width / 2;
      double textY = y - tp.height / 2;
      tp.paint(canvas, Offset(textX, textY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
