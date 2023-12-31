import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'circle_painter.dart';

class Lucky28Page extends StatefulWidget {
  const Lucky28Page({super.key});

  @override
  State<Lucky28Page> createState() => _Lucky28PageState();
}

class _Lucky28PageState extends State<Lucky28Page>
    with SingleTickerProviderStateMixin {
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
    debugPrint("Random Target Value is $result");

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
    final double size = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    return Scaffold(
      appBar: AppBar(title: const Text("幸运28")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: size - 48,
              height: size - 48,
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    _player.dispose();
    _controller.dispose();

    super.dispose();
  }
}
