import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rdg/lucky28/circle_ring.dart';

import '01_edit_mode_page.dart';
import '02_auto_page.dart';
import '03_select_mode_sheet.dart';
import '04_mine_page.dart';
import 'circle_number.dart';
import 'histories.dart';
import '../widgets/index.dart';

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
  List<int> opened = List.generate(10, (i) => Random().nextInt(28)); // 最新8期开奖结果
  List<Mode> modes = List.generate(
    30,
    (i) => Mode(
      "${i + 1}-${Random().nextInt(10000)}",
      "模式 ${i + 1}",
      NumberFormat("#,###").format(Random().nextInt(10000)),
    ),
  ); // 投注模式

  late int total = 1234567; // 总金额
  late int base = 500; // 投注基数

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
    _controller.addListener(onOpenListener);
    _controller.addStatusListener(onOpenStatusListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("幸运28"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Center(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(flex: 2, child: SizedBox()),
                  ...opened
                      .take(8)
                      .map((i) => Expanded(flex: 2, child: CircleNumber(i)))
                      .toList(),
                  const Expanded(child: SizedBox()),
                  IconCircleButton(
                    Icons.keyboard_double_arrow_right,
                    onPressed: onHistories,
                  ),
                ],
              ),
              CircleRing(selected: selected, isRunning: isRunning),
              autoIssue > 0
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: RectangleCircleButton(
                        label: "自动投注中，剩余$autoIssue期...【取消】",
                        onPressed: onCancelAutoIssue,
                      ),
                    )
                  : StepLine(base, StepLineSteps().lucky28, onBase),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: RectangleCircleButton(
                      label: "编辑模式",
                      onPressed: onEditMode,
                    ),
                  ),
                  Expanded(
                    child: RectangleCircleButton(
                      label: "自动投注",
                      onPressed: onAuto,
                    ),
                  ),
                  Expanded(
                    child: RectangleCircleButton(
                      label: "投注模式",
                      onPressed: onSelectMode,
                    ),
                  ),
                  Expanded(
                    child: RectangleCircleButton(
                      label: "我的投注",
                      onPressed: onMine,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RectangleCircleButton(
                label: "开始",
                onPressed: onStart,
              ),
            ],
          ),
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
  }

  // 调整投注基数
  void onBase(int num) {
    base = num;
    setState(() {});
  }

  // 取消自动投注
  void onCancelAutoIssue() {
    setState(() {
      autoIssue = 0;
    });
  }

  // 开奖
  void onOpenListener() {
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
  void onOpenStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        selected = result;
        isRunning = false;
      });
    }
  }

  // 历史分析
  void onHistories() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const HistoriesPage()),
    );
  }

  // 1. 编辑模式
  void onEditMode() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const EditModePage()),
    );
  }

  // 2. 自动投注
  void onAuto() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AutoPage(modes)),
    );
  }

  // 3. 投注模式
  void onSelectMode() async {
    final String? id = await onSelectModeSheet(context, modes);
    debugPrint("选择的模式ID $id");
  }

  // 4. 我的投注
  void onMine() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const MinePage()),
    );
  }
}
