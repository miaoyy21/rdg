import 'package:flutter/material.dart';

import 'fruit.dart';

class Histories extends StatelessWidget {
  final List<int> opened;

  const Histories(this.opened, {super.key});

  Widget _builder(Fruit fruit) {
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.only(left: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black54),
      ),
      child: Center(
        child: fruit.isLarge || fruit.rate <= 0
            ? Text(
                fruit.name,
                style: TextStyle(fontSize: fruit.isLarge ? 20 : 14),
              )
            : Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        fruit.name,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 2,
                    bottom: 0,
                    child: Text(
                      "${fruit.rate}",
                      style: const TextStyle(fontSize: 8),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    late List<Widget> children = [];
    if (opened.isNotEmpty) {
      children.add(_builder(fruits.firstWhere((e) => e.index == opened.first)));
      children.add(const SizedBox(width: 8));

      if (opened.length > 1) {
        children.addAll(
          opened.getRange(1, opened.length - 1).map(
                (v) => _builder(
                  fruits.firstWhere((e) => e.index == v),
                ),
              ),
        );
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
