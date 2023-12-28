import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('幸运28'),
        ),
        body: const Center(
          child: Lucky28(),
        ),
      ),
    );
  }
}

class Lucky28 extends StatefulWidget {
  const Lucky28({super.key});

  @override
  _Lucky28State createState() => _Lucky28State();
}

class _Lucky28State extends State<Lucky28> with SingleTickerProviderStateMixin {
  int result = -1; // 目标随机数字
  int selected = -1; // 转轮选中数字
  bool isRunning = false; // 转轮正在转动中

  static const int total = 28;

  static const double initial = 8;
  static const double acceleration = -7.75;

  late AudioPlayer _player;
  late AnimationController _controller;

  void onStart() async {
    result = Random().nextInt(total);
    print("Random Target Value is $result");

    _player.setVolume(1.0);
    _controller.reset();
    _controller.forward();
  }

  @override
  void initState() {
    super.initState();

    _player = AudioPlayer()
      ..setVolume(0)
      ..setPlaybackRate(2.0)
      ..play(AssetSource("dong.wav"));

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );

    _controller
      ..addListener(() {
        final distance = initial * _controller.value +
            0.5 * acceleration * _controller.value * _controller.value;

        final newSelected = distance *
            (total * 3 + result.toDouble()) ~/
            (initial + 0.5 * acceleration) %
            total;
        if (newSelected != selected) {
          _player.resume();
          setState(() {
            selected = newSelected;
            isRunning = true;
          });
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            selected = result;
            isRunning = false;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 360,
          height: 360,
          child: CustomPaint(
            painter: CirclePainter(
              total: total,
              selected: selected,
              isRunning: isRunning,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onStart,
          child: const Text('开始'),
        ),
        const SizedBox(height: 32),
        const SizedBox(height: 32),
        const SizedBox(height: 32),
      ],
    );
  }

  @override
  void dispose() {
    _player.dispose();
    _controller.dispose();

    super.dispose();
  }
}

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
