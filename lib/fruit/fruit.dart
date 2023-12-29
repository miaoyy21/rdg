import 'package:flutter/material.dart';

class FruitPage extends StatelessWidget {
  const FruitPage.FruitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('水果机'),
        ),
        body: const Center(
          child: FruitGrid(),
        ),
      ),
    );
  }
}

class FruitGrid extends StatelessWidget {
  const FruitGrid({super.key});

  // final List<int,>
  bool isSkip(int index) {
    if ((index >= 8 && index <= 12) ||
        (index >= 15 && index <= 19) ||
        (index >= 22 && index <= 26) ||
        (index >= 29 && index <= 33) ||
        (index >= 36 && index <= 40)) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        if (isSkip(index)) {
          return Container(
            color: Colors.transparent,
          );
        } else {
          return Container(
            color: Colors.blue,
            child: Center(
              child: Text(
                '${index}',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            ),
          );
        }
      },
      itemCount: 49,
      padding: const EdgeInsets.all(4.0),
    );
  }
}
