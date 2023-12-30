import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rdg/fruit/categories.dart';
import 'package:rdg/fruit/fruit.dart';
import 'package:rdg/widgets/digital.dart';
import 'package:rdg/widgets/index.dart';

class FruitPage extends StatelessWidget {
  const FruitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double size = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    int win = 890;
    int total = 12345678901234567;

    return Scaffold(
      appBar: AppBar(
        title: const Text('水果机'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 96),
                      child: Digital(win, fontSize: 24),
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
              child: const Stack(
                children: [
                  FruitGridView(),
                  Center(
                    child: Digital(12, fontSize: 24, width: 54, height: 36),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RectangleCircleButton(
                  text: "⇦",
                  onPressed: () {
                    debugPrint('Button ⇦ Pressed');
                  },
                ),
                RectangleCircleButton(
                  text: "⇨",
                  onPressed: () {
                    debugPrint('Button ⇨ Pressed');
                  },
                ),
                const SizedBox(width: 8),
                RectangleCircleButton(
                  text: "大",
                  onPressed: () {
                    debugPrint('Button 大 Pressed');
                  },
                ),
                RectangleCircleButton(
                  text: "小",
                  onPressed: () {
                    debugPrint('Button 小 Pressed');
                  },
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
                      Digital(category.rate - 3, width: width),
                      const SizedBox(height: 4),
                      FruitBetting(category, width),
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

  const FruitBetting(this.category, this.width, {super.key});

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
      elevation: 5, // 设置 Material 的阴影
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
        onTap: () {
          debugPrint("Pressed ${category.name}");
        },
      ),
    );
  }
}
