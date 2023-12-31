import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rdg/fruit/categories.dart';
import 'package:rdg/fruit/fruit.dart';
import 'package:rdg/widgets/digital.dart';
import 'package:rdg/widgets/index.dart';

class FruitPage extends StatefulWidget {
  const FruitPage({super.key});

  @override
  State<StatefulWidget> createState() => _FruitPageState();
}

class _FruitPageState extends State<FruitPage>
    with SingleTickerProviderStateMixin {
  late int bonus;
  late int total;
  late int digital;

  final Map<Categories, int> betting = {};

  @override
  void initState() {
    super.initState();

    // TODO HTTP
    {
      bonus = 6;
      total = 10;
      digital = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double size = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    return Scaffold(
      appBar: AppBar(
        title: const Text('水果机'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 96),
                      child: Digital(bonus, fontSize: 24),
                    ),
                    const Expanded(child: SizedBox()),
                    ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 96),
                      child: Digital(total, fontSize: 24),
                    ),
                  ],
                )),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RectangleCircleButton(
                  text: "⇦",
                  onPressed: () => onBonus(1),
                ),
                RectangleCircleButton(
                  text: "⇨",
                  onPressed: () => onBonus(-1),
                ),
                const SizedBox(width: 8),
                RectangleCircleButton(
                  text: "大",
                  onPressed: () => onGuess(true),
                ),
                RectangleCircleButton(
                  text: "小",
                  onPressed: () => onGuess(false),
                ),
                const SizedBox(width: 8),
                RectangleCircleButton(
                  text: "开始",
                  border: const CircleBorder(),
                  fontSize: 24,
                  width: 64,
                  height: 64,
                  onPressed: () {
                    debugPrint('Button 开始 Pressed');
                  },
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
                      FruitBetting(category, width, onBetting),
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
    super.dispose();
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
      betting.update(category, (value) => value + 1);
      total = newTotal;
    });
  }

  // 猜测大小
  void onGuess(bool large) async {
    debugPrint("你猜测的是：${large ? "大" : "小"}");

    // TODO HTTP
    final result = Random().nextBool();
    debugPrint("随机结果是：${result ? "大" : "小"}");

    await onGuessEffect();
    setState(() {
      if (result) {
        digital = 8 + Random().nextInt(7);
      } else {
        digital = 1 + Random().nextInt(7);
      }
    });

    if (result == large) {
      debugPrint("猜测正确 >>>");
    } else {
      debugPrint("猜测错误 <<<");
    }
  }

  Future onGuessEffect() {
    final timer = Timer.periodic(
      const Duration(milliseconds: 250),
      (Timer timer) {
        setState(() {
          digital = Random().nextInt(14) + 1;
        });
      },
    );

    return Future.delayed(const Duration(seconds: 3), () => timer.cancel());
  }
}

class FruitGridView extends StatelessWidget {
  const FruitGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemBuilder: (BuildContext context, int index) => FruitGridViewItem(
        fruits.firstWhere(
          (ele) => ele.index == index,
          orElse: () => Fruit.invalid(),
        ),
      ),
      itemCount: 49,
      padding: const EdgeInsets.all(8),
    );
  }
}

class FruitBetting extends StatelessWidget {
  final Categories category;
  final double width;
  final Function(Categories) onBetting;

  const FruitBetting(this.category, this.width, this.onBetting, {super.key});

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).secondaryHeaderColor;

    final fruit = Expanded(
      child: Text(
        category.name,
        style: const TextStyle(fontSize: 42),
      ),
    );

    final rate = Text(
      "${category.rate}",
      style: const TextStyle(
        fontSize: 16,
        fontFamily: "Digital",
        fontStyle: FontStyle.italic,
      ),
    );

    return Material(
      elevation: 4, // 设置 Material 的阴影
      child: InkWell(
        overlayColor: MaterialStateProperty.all<Color>(secondary),
        child: Container(
          width: width,
          height: width + 32,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Column(
              children: [fruit, rate],
            ),
          ),
        ),
        onTap: () => onBetting(category),
      ),
    );
  }
}
