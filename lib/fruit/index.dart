import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rdg/fruit/histories.dart';

import '../widgets/index.dart';
import 'fruit.dart';
import 'categories.dart';
import 'fruit_bet.dart';
import 'fruit_grid_view.dart';

class FruitPage extends StatefulWidget {
  const FruitPage({super.key});

  @override
  State<StatefulWidget> createState() => _FruitPageState();
}

class _FruitPageState extends State<FruitPage>
    with SingleTickerProviderStateMixin {
  int result = -1; // 目标随机数字
  List<int> selected = []; // 转轮选中数字

  late int bonus = 0; // 奖金
  late int total = 10000; // 持有总额
  late List<int> opened; // 最新8期开奖结果
  late int digital = 0; // 提示数字
  late bool enable = true; // 是否可操作

  final Map<Categories, int> bets = {};

  late AssetSource _source;
  late AudioPlayer _player;

  static const double initial = 7;
  static const double acceleration = -6.75;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // 最新开奖结果
    opened = List.generate(
      20,
      (i) => fruits[Random().nextInt(fruits.length)].index,
    );

    _player = AudioPlayer();
    _source = AssetSource("dong.wav");

    const duration = Duration(seconds: 6);

    _controller = AnimationController(vsync: this, duration: duration);
    _controller.addListener(onStartListener);
    _controller.addStatusListener(onStartStatusListener);
  }

  @override
  Widget build(BuildContext context) {
    final light = Colors.orange.withOpacity(0.8);
    final double size = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('水果机'), centerTitle: true),
      body: Center(
        child: ListView(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 88),
                    child: DigitalDisplay(bonus, fontSize: 24),
                  ),
                  const Expanded(child: SizedBox()),
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 88),
                    child: DigitalDisplay(total, fontSize: 24),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size,
              height: size,
              child: Stack(
                children: [
                  FruitGridView(selected, light),
                  Positioned(
                    top: (size + 88) / 7,
                    left: 0,
                    right: 0,
                    child: Histories(opened.take(8).toList()),
                  ),
                  Center(
                    child: DigitalDisplay(
                      digital,
                      fontSize: 48,
                      width: 80,
                      height: 72,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 4),
                RectangleCircleButton(
                  label: "⇦",
                  onPressed: enable && total > 0 ? () => onBonus(1) : null,
                ),
                RectangleCircleButton(
                  label: "⇨",
                  onPressed: enable && bonus > 0 ? () => onBonus(-1) : null,
                ),
                const Expanded(child: SizedBox()),
                RectangleCircleButton(
                  label: "1-7",
                  onPressed: enable && bonus > 0 ? () => onGuess(false) : null,
                ),
                RectangleCircleButton(
                  label: "8-14",
                  onPressed: enable && bonus > 0 ? () => onGuess(true) : null,
                ),
                const Expanded(child: SizedBox()),
                RectangleCircleButton(
                  label: "Go",
                  border: const CircleBorder(),
                  fontSize: 24,
                  width: 64,
                  height: 64,
                  onPressed:
                      enable && bets.values.any((v) => v > 0) ? onStart : null,
                ),
                const SizedBox(width: 4),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: categories.map(
                (category) {
                  final width = (size - 10 * 4) / 8;

                  return Column(
                    children: [
                      DigitalDisplay(
                        bets.putIfAbsent(category, () => 0),
                        background: bets[category]! > 0 ? light : null,
                        width: width,
                      ),
                      const SizedBox(height: 4),
                      FruitBet(
                        category,
                        width,
                        enable ? onBetting : null,
                        background: bets[category]! > 0 ? light : null,
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RectangleCircleButton(
                    label: "送灯",
                    onPressed: () {},
                  ),
                  RectangleCircleButton(
                    label: "大三元",
                    onPressed: () {},
                  ),
                  RectangleCircleButton(
                    label: "大三元",
                    onPressed: () {},
                  ),
                  RectangleCircleButton(
                    label: "大四喜",
                    onPressed: () {},
                  ),
                  RectangleCircleButton(
                    label: "小四喜",
                    onPressed: () {},
                  ),
                  RectangleCircleButton(
                    label: "纵横四海",
                    onPressed: () {},
                  ),
                  RectangleCircleButton(
                    label: "仙女散花",
                    onPressed: () {},
                  ),
                  RectangleCircleButton(
                    label: "天龙八部",
                    onPressed: () {},
                  ),
                  RectangleCircleButton(
                    label: "九莲宝灯",
                    onPressed: () {},
                  ),
                  RectangleCircleButton(
                    label: "开火车",
                    onPressed: () {},
                  ),
                  RectangleCircleButton(
                    label: "大满贯",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
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

  // 调整奖金
  void onBonus(int step) {
    final newBonus = bonus + step, newTotal = total - step;
    if (newBonus < 0 || newTotal < 0) {
      return;
    }

    setState(() {
      result = -1;
      selected.clear();

      bonus = newBonus;
      total = newTotal;
    });
  }

  // 水果押注
  void onBetting(Categories category) {
    final newTotal = total - 1;
    if (newTotal < 0) {
      return;
    }

    setState(() {
      result = -1;
      selected.clear();

      total = newTotal;
      bets.update(category, (value) => value + 1);
    });
  }

  // 猜测大小
  void onGuess(bool large) async {
    if (bonus <= 0) {
      return;
    }

    debugPrint("你猜测的是：${large ? "大" : "小"}");

    // TODO HTTP
    var target = Random().nextBool();
    debugPrint("随机结果是：${target ? "大" : "小"}");

    result = -1;
    selected.clear();
    enable = false;
    setState(() {});

    callback(Timer t) {
      digital = Random().nextInt(14) + 1;
      setState(() {});
    }

    await onDelayed(255, 3, callback);

    enable = true;
    if (target) {
      digital = 8 + Random().nextInt(7);
    } else {
      digital = 1 + Random().nextInt(7);
    }
    setState(() {});

    if (target == large) {
      debugPrint("猜测正确 >>>");
    } else {
      debugPrint("猜测错误 <<<");
    }
  }

  // 开始押注
  void onStart() async {
    if (bonus > 0) {
      setState(() {
        total = total + bonus;
        bonus = 0;
      });
    }

    final fruit = fruits[Random().nextInt(fruits.length)];
    result = fruit.index;
    debugPrint("Random Target Value is $result");

    _controller.reset();
    await _controller.forward();

    opened.insert(0, fruit.index);
    setState(() {});
  }

  // 开奖
  void onStartListener() {
    final distance = initial * _controller.value +
        0.5 * acceleration * _controller.value * _controller.value;

    final target = fruits.indexWhere((fruit) => fruit.index == result);

    final newSelected = distance *
        (24 * 3 + target.toDouble()) ~/
        (initial + 0.5 * acceleration) %
        24;

    final newIndex = fruits[newSelected].index;
    if (selected.isEmpty || newIndex != selected.first) {
      _player.play(_source);
      setState(() {
        selected
          ..clear()
          ..add(newIndex);
        enable = false;
      });
    }
  }

  // 开奖结束
  void onStartStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        selected
          ..clear()
          ..add(result);
        enable = true;
      });
    }
  }

  // 延迟执行
  Future onDelayed(int ms, int s, Function(Timer timer) callback) {
    final timer = Timer.periodic(Duration(milliseconds: ms), callback);

    return Future.delayed(Duration(seconds: s), () => timer.cancel());
  }
}
