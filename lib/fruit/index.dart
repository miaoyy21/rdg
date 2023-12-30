import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rdg/fruit/categories.dart';
import 'package:rdg/fruit/fruit.dart';
import 'package:rdg/widgets/index.dart';

class FruitPage extends StatelessWidget {
  const FruitPage({super.key});

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
            SizedBox(
              width: size,
              height: size,
              child: Stack(
                children: [
                  const GridFruit(),
                  Center(child: Text("sss")),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RectangleCircleButtonWithBorder(
                  text: "⇦",
                  onPressed: () {
                    debugPrint('Button ⇦ Pressed');
                  },
                ),
                RectangleCircleButtonWithBorder(
                  text: "⇨",
                  onPressed: () {
                    debugPrint('Button ⇨ Pressed');
                  },
                ),
                const SizedBox(width: 8),
                RectangleCircleButtonWithBorder(
                  text: "大",
                  onPressed: () {
                    debugPrint('Button 大 Pressed');
                  },
                ),
                RectangleCircleButtonWithBorder(
                  text: "小",
                  onPressed: () {
                    debugPrint('Button 小 Pressed');
                  },
                ),
                const SizedBox(width: 8),
                RectangleCircleButtonWithBorder(
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
                      QtyFruit(width, 12),
                      const SizedBox(height: 4),
                      ClickFruit(width, category),
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

class GridFruit extends StatelessWidget {
  const GridFruit({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemBuilder: (BuildContext context, int index) => FruitWidget(
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

class QtyFruit extends StatelessWidget {
  final double width;
  final int qty;

  const QtyFruit(this.width, this.qty, {super.key});

  @override
  Widget build(BuildContext context) {
    final secondary = Theme.of(context).secondaryHeaderColor;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Center(
        child: Text(
          "$qty",
          style: const TextStyle(
            fontFamily: "Digital",
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class ClickFruit extends StatelessWidget {
  final double width;
  final Categories category;

  const ClickFruit(this.width, this.category, {super.key});

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
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
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
