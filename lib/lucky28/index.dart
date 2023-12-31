import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../widgets/rectangle_circle_button.dart';
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
  int autoIssue = 0; // 自动投注中

  late int total = 1234567; // 总金额
  double radixPercent = 0; // 投注百分比
  int radix = 0; // 投注金额

  static const double initial = 8;
  static const double acceleration = -7.75;

  late AudioPlayer _player;
  late AnimationController _controller;

  void onRadix(double value) {
    setState(() {
      radixPercent = value;
      radix = ((radixPercent * total) ~/ 1000) * 1000;
    });
  }

  // 开始
  void onStart() async {
    result = Random().nextInt(28);
    debugPrint("Random Target Value is $result");

    _player.setVolume(1.0);
    _controller.reset();
    await _controller.forward();

    total -= 67890;
    onRadix(radixPercent);
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
            (28 * 3 + result.toDouble()) ~/
            (initial + 0.5 * acceleration) %
            28;
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
    final secondary = MaterialStateProperty.all<Color>(
        Theme.of(context).secondaryHeaderColor);

    return Scaffold(
      appBar: AppBar(
        title: const Text("幸运28"),
        centerTitle: true,
        actions: [
          IconButton.outlined(
            icon: const Icon(Icons.history),
            style: ButtonStyle(overlayColor: secondary),
            onPressed: () {
              debugPrint("TODO ......");
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CustomPaint(
                painter: CirclePainter(
                  selected: selected,
                  isRunning: isRunning,
                ),
              ),
            ),
            autoIssue > 0
                ? Container(
                    margin: EdgeInsets.only(top: 16, bottom: 8),
                    child: RectangleCircleButton(
                      label: "自动投注中，剩余$autoIssue期...【取消】",
                      onPressed: () {
                        debugPrint("自动投注中 ...【取消】");
                      },
                    ),
                  )
                : const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 88,
                  child: Text(
                    "投注占比",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Expanded(
                  child: Slider(
                    value: radixPercent,
                    activeColor: Colors.black,
                    inactiveColor: Colors.black38,
                    onChanged: onRadix,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 88,
                  child: Text(
                    "投注金额",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(radix <= 0
                      ? "0"
                      : "${(radixPercent * 100).toStringAsFixed(2)}% ⇰ $radix"),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 8),
                RectangleCircleButton(
                  label: "  刷新  ",
                  onPressed: () {
                    debugPrint("刷新");
                  },
                ),
                const Expanded(child: SizedBox()),
                RectangleCircleButton(
                  label: "自动投注",
                  onPressed: () {
                    debugPrint("自动投注");
                  },
                ),
                RectangleCircleButton(
                  label: "投注模式",
                  onPressed: () {
                    debugPrint("投注模式");
                  },
                ),
                RectangleCircleButton(
                  label: "我的投注",
                  onPressed: () {
                    debugPrint("我的投注");
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
            ElevatedButton(
              onPressed: onStart,
              child: const Text('开始'),
            ),
            const SizedBox(height: 16),
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
