import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rdg/fruit/categories.dart';
import 'package:rdg/fruit/fruit.dart';
import 'package:rdg/widgets/digital.dart';
import 'package:rdg/widgets/index.dart';

import 'fruit_betting.dart';
import 'fruit_grid_view.dart';

class FruitPage extends StatefulWidget {
  const FruitPage({super.key});

  @override
  State<StatefulWidget> createState() => _FruitPageState();
}

class _FruitPageState extends State<FruitPage>
    with SingleTickerProviderStateMixin {
  late int bonus = 0;
  late int total = 10000;
  late int digital = 0;
  late bool enable = true;

  final Map<Categories, int> betting = {};

  @override
  Widget build(BuildContext context) {
    final double size = min(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
    final secondary = MaterialStateProperty.all<Color>(
        Theme.of(context).secondaryHeaderColor);

    return Scaffold(
      appBar: AppBar(
        title: const Text('水果机'),
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
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 88),
                    child: Digital(bonus, fontSize: 24),
                  ),
                  const Expanded(child: SizedBox()),
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 88),
                    child: Digital(total, fontSize: 24),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size,
              height: size,
              child: Stack(
                children: [
                  const FruitGridView(),
                  Center(
                    child:
                        Digital(digital, fontSize: 48, width: 80, height: 72),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RectangleCircleButton(
                  text: "⇦",
                  onPressed: enable && total > 0 ? () => onBonus(1) : null,
                ),
                RectangleCircleButton(
                  text: "⇨",
                  onPressed: enable && bonus > 0 ? () => onBonus(-1) : null,
                ),
                const SizedBox(width: 8),
                RectangleCircleButton(
                  text: "大",
                  onPressed: enable && bonus > 0 ? () => onGuess(true) : null,
                ),
                RectangleCircleButton(
                  text: "小",
                  onPressed: enable && bonus > 0 ? () => onGuess(false) : null,
                ),
                const SizedBox(width: 8),
                RectangleCircleButton(
                  text: "开始",
                  border: const CircleBorder(),
                  fontSize: 24,
                  width: 64,
                  height: 64,
                  onPressed: enable && betting.values.any((v) => v > 0)
                      ? onStart
                      : null,
                ),
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
                      Digital(
                        betting.putIfAbsent(category, () => 0),
                        width: width,
                      ),
                      const SizedBox(height: 4),
                      FruitBetting(
                        category,
                        width,
                        enable ? onBetting : null,
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

  // 调整奖金
  void onBonus(int step) {
    final newBonus = bonus + step, newTotal = total - step;
    if (newBonus < 0 || newTotal < 0) {
      return;
    }

    setState(() {
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
      total = newTotal;
      betting.update(category, (value) => value + 1);
    });
  }

  // 猜测大小
  void onGuess(bool large) async {
    if (bonus <= 0) {
      return;
    }

    debugPrint("你猜测的是：${large ? "大" : "小"}");

    // TODO HTTP
    final result = Random().nextBool();
    debugPrint("随机结果是：${result ? "大" : "小"}");

    enable = false;
    await onGuessEffect();
    setState(() {
      if (result) {
        digital = 8 + Random().nextInt(7);
      } else {
        digital = 1 + Random().nextInt(7);
      }

      enable = true;
    });

    if (result == large) {
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
        setState(() {
          digital = Random().nextInt(14) + 1;
        });
      },
    );

    return Future.delayed(const Duration(seconds: 3), () => timer.cancel());
  }

  // 开始押注
  void onStart() {
    if (bonus > 0) {
      setState(() {
        total = total + bonus;
        bonus = 0;
      });
    }

    // TODO HTTP
    debugPrint('Button 开始 Pressed');
  }
}
