import 'package:flutter/material.dart';

class CircleNumber extends StatelessWidget {
  final int num;
  final Color background;
  final Color border;
  final Color color;
  final Color? shadow;

  const CircleNumber(
    this.num, {
    super.key,
    this.background = Colors.white,
    this.border = Colors.black,
    this.color = Colors.black,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.0,
      height: 36.0,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: Border.all(
          color: border,
          width: 2.0,
        ),
        boxShadow: shadow != null
            ? [
                BoxShadow(
                  color: shadow!.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 8,
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          '$num',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
