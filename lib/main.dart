import 'package:flutter/material.dart';
import 'package:rdg/lucky28/lucky28.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppPage(),
    );
  }
}

class AppPage extends StatelessWidget {
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
            const SizedBox(),
            MaterialButton(
              color: Colors.purple,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Lucky28(),
                  ),
                );
              },
              child: const Text(
                "幸运28",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
