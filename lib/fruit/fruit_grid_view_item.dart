import 'package:flutter/material.dart';

import 'fruit.dart';

class FruitGridViewItem extends StatelessWidget {
  final Fruit fruit;

  const FruitGridViewItem(this.fruit, {super.key});

  @override
  Widget build(BuildContext context) {
    if (!fruit.isValid) {
      return Container(color: Colors.transparent);
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.black),
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
  }
}
