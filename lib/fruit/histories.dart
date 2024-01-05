import 'package:flutter/material.dart';

import 'categories.dart';

class Histories extends StatelessWidget {
  final List<Categories> opened;

  const Histories(this.opened, {super.key});

  Widget _builder(String name) {
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.only(left: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black54),
      ),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    late List<Widget> children = [];
    if (opened.isNotEmpty) {
      children.add(_builder(opened[0].name));
      children.add(const SizedBox(width: 8));

      if (opened.length > 1) {
        children.addAll(
          opened.getRange(1, opened.length - 1).map((v) => _builder(v.name)),
        );
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
