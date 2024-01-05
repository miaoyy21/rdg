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
          children: _buildNumberCircles(context, width),
        ),
      ),
    );
  }

  List<Widget> _buildNumberCircles(BuildContext context, double width) {
    final List<Widget> circles = [];

    final double radius = (width) / 2 - 24;
    final double centerX = width / 2;
    final double centerY = width / 2;
    final double angle = 2 * pi / numbers.length;
    final primary = Theme.of(context).primaryColor;

    for (int i = 0; i < numbers.length; i++) {
      final double x = centerX + radius * cos(-pi / 2 + i * angle);
      final double y = centerY + radius * sin(-pi / 2 + i * angle);

      final Color background = selected == i ? primary : Colors.white;
      final Color border = selected == i ? primary : Colors.black;
      final Color color = selected == i ? Colors.white : Colors.black;
      final Color? shadow = selected == i ? primary : null;

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
              background: background,
              border: border,
              color: color,
              shadow: shadow,
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
