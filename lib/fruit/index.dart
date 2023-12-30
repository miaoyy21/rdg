import 'dart:math';

import 'package:flutter/material.dart';
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
              child: const FruitGrid(),
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
                  fontSize: 20,
                  width: 64,
                  height: 64,
                  onPressed: () {
                    debugPrint('Button 开始 Pressed');
                  },
                ),
                const SizedBox(height: 32),
                const SizedBox(height: 32),
                const SizedBox(height: 32),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FruitGrid extends StatelessWidget {
  const FruitGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        final fruit = fruits.firstWhere(
          (ele) => ele.index == index,
          orElse: () => Fruit.invalid(),
        );

        if (!fruit.isValid) {
          return Container(color: Colors.transparent);
        }

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: Center(
            child: fruit.isLarge || fruit.rate <= 0
                ? Text(
                    fruit.name,
                    style: TextStyle(fontSize: fruit.isLarge ? 40 : 30),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: Text(
                          fruit.name,
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                      Text(
                        "×${fruit.rate}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
          ),
        );
      },
      itemCount: 49,
      padding: const EdgeInsets.all(8),
    );
  }
}
