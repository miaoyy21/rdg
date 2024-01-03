import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<StatefulWidget> createState() => _StateEditPage();
}

class _StateEditPage extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("编辑模式"), centerTitle: true),
      body: const Center(child: Text("编辑模式")),
    );
  }
}
