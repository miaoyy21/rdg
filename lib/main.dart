import 'package:flutter/material.dart';
import 'widgets/index.dart';

import 'fruit/index.dart';
import 'lucky28/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
        fontFamily: "HYXiaoLiShu",
      ),
      home: AppPage(),
    );
  }
}

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('移动应用'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RectangleCircleButton(
              label: "幸运28",
              width: 128,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Lucky28Page(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            RectangleCircleButton(
              label: "水果机",
              width: 128,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FruitPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
