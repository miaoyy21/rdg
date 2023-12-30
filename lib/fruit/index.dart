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
              child: const GridFruit(),
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
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: categories
                  .map(
                    (ele) => Column(
                      children: [
                        Container(
                          width: (size - 10 * 4) / 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "0",
                              style: TextStyle(
                                fontFamily: "Digital",
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          width: (size - 10 * 4) / 8,
                          height: (size - 10 * 4) / 8 + 24,
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Text(
                                    ele.name,
                                    style: const TextStyle(
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${ele.rate}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Digital",
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                  .toList(),
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
