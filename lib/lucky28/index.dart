import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rdg/lucky28/circle_number.dart';

import '../widgets/index.dart';
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
  int autoIssue = 1; // 自动投注剩余期数
  List<int> opened = [0, 2, 3, 4, 4, 2, 12, 26, 25, 1, 3]; // 最新8期开奖结果

  late int total = 1234567; // 总金额
  double radixPercent = 0; // 投注百分比
  int radix = 0; // 投注金额

  static const double initial = 8;
  static const double acceleration = -7.75;

  late AssetSource _source;
  late AudioPlayer _player;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _player = AudioPlayer()..setPlaybackRate(2.0);
    _source = AssetSource("dong.wav");

    const duration = Duration(seconds: 6);

    _controller = AnimationController(vsync: this, duration: duration);
    _controller.addListener(onOpen);
    _controller.addStatusListener(onOpenFinish);
  }

  @override
  Widget build(BuildContext context) {
    final double size = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    return Scaffold(
      appBar: AppBar(title: const Text("幸运28"), centerTitle: true),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 8),
                ...opened.take(8).map((i) => CircleNumber(i)).toList(),
                const Expanded(child: SizedBox()),
                IconCircleButton(
                  Icons.keyboard_double_arrow_right,
                  onPressed: () {
                    debugPrint("查看开奖历史");
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
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
                    margin: const EdgeInsets.only(top: 16, bottom: 8),
                    child: RectangleCircleButton(
                      label: "自动投注中，剩余$autoIssue期...【取消】",
                      onPressed: onCancelAutoIssue,
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
                    onChanged: onRadixPercentChange,
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

  // 虚拟开始开奖
  void onStart() async {
    result = Random().nextInt(28);
    debugPrint("Random Target Value is $result");

    _controller.reset();
    await _controller.forward();

    total -= 67890;
    onRadixPercentChange(radixPercent);
  }

  // 修改投注占比
  void onRadixPercentChange(double value) {
    setState(() {
      radixPercent = value;
      radix = ((radixPercent * total) ~/ 1000) * 1000;
    });
  }

  // 取消自动投注
  void onCancelAutoIssue() {
    setState(() {
      autoIssue = 0;
    });
  }

  // 开奖
  void onOpen() {
    final distance = initial * _controller.value +
        0.5 * acceleration * _controller.value * _controller.value;

    final newSelected = distance *
        (28 * 3 + result.toDouble()) ~/
        (initial + 0.5 * acceleration) %
        28;
    if (newSelected != selected) {
      _player.play(_source);
      setState(() {
        selected = newSelected;
        isRunning = true;
      });
    }
  }

  // 开奖结束
  void onOpenFinish(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        selected = result;
        isRunning = false;
      });
    }
  }
}
