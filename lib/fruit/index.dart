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
            SizedBox(
              height: 64,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  RectangleCircleButtonWithBorder(
                    text: "⇦",
                    margin: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                    onPressed: () {
                      debugPrint('Button ⇦ Pressed');
                    },
                  ),
                  RectangleCircleButtonWithBorder(
                    text: "⇨",
                    margin: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                    onPressed: () {
                      debugPrint('Button ⇨ Pressed');
                    },
                  ),
                  const SizedBox(width: 8),
                  RectangleCircleButtonWithBorder(
                    text: "大",
                    margin: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                    onPressed: () {
                      debugPrint('Button 大 Pressed');
                    },
                  ),
                  RectangleCircleButtonWithBorder(
                    text: "小",
                    margin: const EdgeInsets.fromLTRB(4, 10, 4, 10),
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
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: List.generate(
            //     8,
            //     (index) => RectangleCircleButtonWithBorder(
            //       text: "大",
            //       onPressed: () {
            //         debugPrint('Button 大 Pressed');
            //       },
            //     ),
            //   ),
            // ),
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
