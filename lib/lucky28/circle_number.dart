import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleNumber extends StatelessWidget {
  final int num;

  const CircleNumber(this.num, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 2),
      ),
      child: Center(
        child: Text(
          "$num",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
