import 'package:flutter/material.dart';

import 'fruit.dart';
import 'fruit_grid_view_item.dart';

class FruitGridView extends StatelessWidget {
  final int selected;
  final Color light;

  const FruitGridView(this.selected, this.light, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
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
        shadow: selected == index ? light : null,
      ),
      itemCount: 49,
      padding: const EdgeInsets.all(8),
    );
  }
}
