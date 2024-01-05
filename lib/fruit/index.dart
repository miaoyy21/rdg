import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../widgets/index.dart';
import 'fruit.dart';
import 'categories.dart';
import 'fruit_betting.dart';
import 'fruit_grid_view.dart';

class FruitPage extends StatefulWidget {
  const FruitPage({super.key});

  @override
  State<StatefulWidget> createState() => _FruitPageState();
}

class _FruitPageState extends State<FruitPage>
    with SingleTickerProviderStateMixin {
  int result = -1; // 目标随机数字
  int selected = -1; // 转轮选中数字

  late int bonus = 0; // 奖金
  late int total = 10000; // 持有总额
  late List<Categories> opened; // 最新8期开奖结果
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
    final vs = Categories.values.where((v) => v != Categories.invalid).toList();
    opened = List.generate(10, (i) => vs[Random().nextInt(vs.length)]);

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
                    top: size / 6,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: opened
                          .take(8)
                          .map(
                            (v) => Container(
                              width: 30,
                              height: 30,
                              margin: const EdgeInsets.only(left: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.black54),
                              ),
                              child: Center(
                                child: Text(
                                  v.name,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Center(
                    child: DigitalDisplay(digital,
                        fontSize: 48, width: 80, height: 72),
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
                      FruitBetting(
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
      selected = -1;

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
      selected = -1;

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
    selected = -1;
    enable = false;
    setState(() {});

    await onGuessEffect();
    setState(() {
      if (target) {
        digital = 8 + Random().nextInt(7);
      } else {
        digital = 1 + Random().nextInt(7);
      }

      enable = true;
    });

    if (target == large) {
      debugPrint("猜测正确 >>>");
    } else {
      debugPrint("猜测错误 <<<");
    }
  }

  // 猜测特效
  Future onGuessEffect() {
    final timer = Timer.periodic(
      const Duration(milliseconds: 255),
      (Timer timer) {
        digital = Random().nextInt(14) + 1;
        setState(() {});
      },
    );

    return Future.delayed(const Duration(seconds: 3), () => timer.cancel());
  }

  // 开始押注
  void onStart() async {
    if (bonus > 0) {
      setState(() {
        total = total + bonus;
        bonus = 0;
      });
    }

    result = fruits[Random().nextInt(fruits.length)].index;
    debugPrint("Random Target Value is $result");

    _controller.reset();
    await _controller.forward();
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
    if (fruits[newSelected].index != selected) {
      _player.play(_source);
      setState(() {
        selected = fruits[newSelected].index;
        enable = false;
      });
    }
  }

  // 开奖结束
  void onStartStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        selected = result;
        enable = true;
      });
    }
  }
}
