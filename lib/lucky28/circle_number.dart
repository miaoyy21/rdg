import 'package:flutter/material.dart';

class CircleNumber extends StatelessWidget {
  final int num;
  final Color background;

  const CircleNumber(this.num, {super.key, this.background = Colors.white});

  @override
  Widget build(BuildContext context) {
    late Color color = Colors.black;
    if (background != Colors.white) {
      color = Colors.white;
    }

    return Container(
      width: 36.0,
      height: 36.0,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: Border.all(
          color: color == Colors.white ? background : color,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: background.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 8,
          ),
        ],
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
