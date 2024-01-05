import 'package:flutter/material.dart';

class RectangleText extends StatelessWidget {
  final String label;
  final double height;

  const RectangleText(this.label, {super.key, this.height = 32});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black26),
      ),
      child: Center(
        child: Text(label, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
