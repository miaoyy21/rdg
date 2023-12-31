import 'package:flutter/material.dart';

import 'categories.dart';

class Fruit {
  final int index;
  final Categories category;
  final bool isLarge;

  final String name;
  final int rate;

  Fruit({required this.index, required this.category, required this.isLarge})
      : name = category.name,
        rate = isLarge
            ? category.rate
            : category == Categories.king
                ? 50
                : category != Categories.candy
                    ? 3
                    : 0;

  Fruit.invalid()
      : index = -1,
        category = Categories.invalid,
        isLarge = false,
        name = "🕳️",
        rate = 0;

  bool get isValid => category != Categories.invalid;
}

List<Fruit> fruits = [
  // 第1行
  Fruit(index: 0, category: Categories.orange, isLarge: true),
  Fruit(index: 1, category: Categories.grape, isLarge: true),
  Fruit(index: 2, category: Categories.king, isLarge: false),
  Fruit(index: 3, category: Categories.king, isLarge: true),
  Fruit(index: 4, category: Categories.apple, isLarge: true),
  Fruit(index: 5, category: Categories.apple, isLarge: false),
  Fruit(index: 6, category: Categories.blueberry, isLarge: true),

  // 第2行
  Fruit(index: 7, category: Categories.grape, isLarge: false),
  Fruit(index: 13, category: Categories.watermelon, isLarge: true),

  // 第3行
  Fruit(index: 14, category: Categories.apple, isLarge: true),
  Fruit(index: 20, category: Categories.watermelon, isLarge: false),

  // 第4行
  Fruit(index: 21, category: Categories.candy, isLarge: true),
  Fruit(index: 27, category: Categories.candy, isLarge: false),

  // 第5行
  Fruit(index: 28, category: Categories.salad, isLarge: true),
  Fruit(index: 34, category: Categories.apple, isLarge: true),

  // 第6行
  Fruit(index: 35, category: Categories.salad, isLarge: false),
  Fruit(index: 41, category: Categories.orange, isLarge: false),

  // 第7行
  Fruit(index: 42, category: Categories.blueberry, isLarge: true),
  Fruit(index: 43, category: Categories.blueberry, isLarge: false),
  Fruit(index: 44, category: Categories.apple, isLarge: true),
  Fruit(index: 45, category: Categories.hamburger, isLarge: true),
  Fruit(index: 46, category: Categories.hamburger, isLarge: false),
  Fruit(index: 47, category: Categories.grape, isLarge: true),
  Fruit(index: 48, category: Categories.orange, isLarge: true),
];
