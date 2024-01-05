import 'package:flutter/material.dart';

import 'categories.dart';

class FruitBetting extends StatelessWidget {
  final Categories category;
  final double width;
  final Color? background;
  final Function(Categories)? onBetting;

  const FruitBetting(this.category, this.width, this.onBetting,
      {super.key, this.background});

  @override
  Widget build(BuildContext context) {
    late Color secondary = Theme.of(context).secondaryHeaderColor;
    late Color color = Colors.black;
    if (onBetting == null) {
      secondary = Theme.of(context).scaffoldBackgroundColor;
      color = Colors.black54;
    }

    final fruit = Expanded(
      child: Text(
        category.name,
        style: const TextStyle(fontSize: 42),
      ),
    );

    final rate = Text(
      "${category.rate}",
      style: TextStyle(
        fontSize: 16,
        color: color,
        fontFamily: "Digital",
        fontStyle: FontStyle.italic,
      ),
    );

    return Material(
      elevation: 4, // 设置 Material 的阴影
      child: InkWell(
        overlayColor: MaterialStateProperty.all<Color>(secondary),
        onTap: onBetting != null ? () => onBetting!(category) : null,
        child: Container(
          width: width,
          height: width + 32,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: color),
          ),
          child: Center(
            child: Column(
              children: [fruit, rate],
            ),
          ),
        ),
      ),
    );
  }
}
