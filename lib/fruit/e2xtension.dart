enum Categories {
  invalid,
  apple,
  orange,
  lemon,
  bell,
  watermelon,
  star,
  seven,
  bar,
  lucky
}

extension FruitCategoryExtension on Categories {
  static final Map<Categories, String> _names = {
    Categories.apple: "🍎",
    Categories.orange: "🍇",
    Categories.lemon: "🍋",
    Categories.bell: "🍑",
    Categories.watermelon: "🍉",
    Categories.star: "🌽",
    Categories.seven: "🥒",
    Categories.bar: "🐲",
    Categories.lucky: "🍭"
  };

  static final Map<Categories, int> _rates = {
    Categories.apple: 5,
    Categories.orange: 10,
    Categories.lemon: 15,
    Categories.bell: 20,
    Categories.watermelon: 25,
    Categories.star: 30,
    Categories.seven: 40,
    Categories.bar: 120,
    Categories.lucky: 0
  };

  String get name => _names[this]!;

  int get rate => _rates[this]!;
}
