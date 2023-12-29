enum Categories {
  invalid,
  apple,
  orange,
  blueberry,
  grape,
  watermelon,
  salad,
  hamburger,
  bar,
  lucky
}

extension FruitCategoryExtension on Categories {
  static final Map<Categories, String> _names = {
    // 苹果
    Categories.apple: "🍎",

    // 橘子
    Categories.orange: "🍊",

    // 橄榄 => 蓝莓
    Categories.blueberry: "🫐",

    // 铃铛 => 葡萄
    Categories.grape: "🍇",

    // 西瓜
    Categories.watermelon: "🍉",

    // 双星 => 沙拉
    Categories.salad: "🥗",

    // 双7 => 汉堡
    Categories.hamburger: "🍔",

    // BAR => 龙王
    Categories.bar: "🐲",

    // Lucky => 糖果
    Categories.lucky: "🍬"
  };

  static final Map<Categories, int> _rates = {
    Categories.apple: 5,
    Categories.orange: 10,
    Categories.blueberry: 15,
    Categories.grape: 20,
    Categories.watermelon: 25,
    Categories.salad: 30,
    Categories.hamburger: 40,
    Categories.bar: 120,
    Categories.lucky: 0
  };

  String get name => _names[this]!;

  int get rate => _rates[this]!;
}
