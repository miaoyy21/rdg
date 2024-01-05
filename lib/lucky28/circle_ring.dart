import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rdg/lucky28/circle_number.dart';

class CircleRing extends StatelessWidget {
  final bool isRunning;
  final int selected;

  CircleRing({super.key, required this.selected, required this.isRunning});

  final List<int> numbers = List.generate(28, (i) => i);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: width,
        height: width,
        child: Stack(
          children: _buildNumberCircles(width),
        ),
      ),
    );
  }

  List<Widget> _buildNumberCircles(double width) {
    final List<Widget> circles = [];

    final double radius = (width) / 2 - 24;
    final double centerX = width / 2;
    final double centerY = width / 2;
    final double angle = 2 * pi / numbers.length;

    for (int i = 0; i < numbers.length; i++) {
      final double x = centerX + radius * cos(-pi / 2 + i * angle);
      final double y = centerY + radius * sin(-pi / 2 + i * angle);

      circles.add(
        Positioned(
          left: x - 22,
          top: y - 18,
          child: InkWell(
            onTap: () {
              _onNumberTap(i);
            },
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            child: CircleNumber(
              i,
              background: selected == i ? Colors.purple : Colors.white,
            ),
          ),
        ),
      );
    }

    return circles;
  }

  void _onNumberTap(int number) {
    debugPrint('Clicked number: $number');
  }
}
