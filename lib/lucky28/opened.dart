import 'package:flutter/material.dart';

class OpenedPage extends StatefulWidget {
  const OpenedPage({super.key});

  @override
  State<StatefulWidget> createState() => _OpenedPageState();
}

class _OpenedPageState extends State<OpenedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("往期分析"), centerTitle: true),
      body: Center(
        child: Text("aaaa"),
      ),
    );
  }
}
