import 'e2xtension.dart';

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
            : category == Categories.bar
                ? 50
                : category != Categories.lucky
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
  Fruit(index: 1, category: Categories.bell, isLarge: true),
  Fruit(index: 2, category: Categories.bar, isLarge: false),
  Fruit(index: 3, category: Categories.bar, isLarge: true),
  Fruit(index: 4, category: Categories.apple, isLarge: true),
  Fruit(index: 5, category: Categories.apple, isLarge: false),
  Fruit(index: 6, category: Categories.lemon, isLarge: true),

  // 第2行
  Fruit(index: 7, category: Categories.bell, isLarge: false),
  Fruit(index: 13, category: Categories.watermelon, isLarge: true),

  // 第3行
  Fruit(index: 14, category: Categories.apple, isLarge: true),
  Fruit(index: 20, category: Categories.watermelon, isLarge: false),

  // 第4行
  Fruit(index: 21, category: Categories.lucky, isLarge: true),
  Fruit(index: 27, category: Categories.lucky, isLarge: false),

  // 第5行
  Fruit(index: 28, category: Categories.star, isLarge: true),
  Fruit(index: 34, category: Categories.apple, isLarge: true),

  // 第6行
  Fruit(index: 35, category: Categories.star, isLarge: false),
  Fruit(index: 41, category: Categories.orange, isLarge: false),

  // 第7行
  Fruit(index: 42, category: Categories.lemon, isLarge: true),
  Fruit(index: 43, category: Categories.lemon, isLarge: false),
  Fruit(index: 44, category: Categories.apple, isLarge: true),
  Fruit(index: 45, category: Categories.seven, isLarge: true),
  Fruit(index: 46, category: Categories.seven, isLarge: false),
  Fruit(index: 47, category: Categories.bell, isLarge: true),
  Fruit(index: 48, category: Categories.orange, isLarge: true),
];
