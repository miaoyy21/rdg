import 'package:flutter/material.dart';

import 'fruit.dart';

class FruitGridViewItem extends StatelessWidget {
  final Fruit fruit;
  final Color? shadow;

  const FruitGridViewItem(this.fruit, {super.key, this.shadow});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    if (!fruit.isValid) {
      return Container(color: Colors.transparent);
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.black),
        boxShadow: shadow != null
            ? [
                BoxShadow(
                  color: shadow!,
                  spreadRadius: 4,
                  blurRadius: 8,
                )
              ]
            : null,
      ),
      child: Center(
        child: fruit.isLarge || fruit.rate <= 0
            ? Text(
                fruit.name,
                style: TextStyle(fontSize: fruit.isLarge ? 36 : 24),
              )
            : Column(
                children: [
                  Expanded(
                    child: Text(
                      fruit.name,
                      style: const TextStyle(fontSize: 24),
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
  }
}
