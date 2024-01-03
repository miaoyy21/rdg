import 'package:flutter/material.dart';

import '../widgets/index.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<StatefulWidget> createState() => _StateEditPage();
}

class _StateEditPage extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("编辑模式"),
        centerTitle: true,
        actions: [
          IconCircleButton(
            Icons.add,
            onPressed: () {
              debugPrint("添加模式");
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Container(color: Colors.red, height: 200),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(color: Colors.green, height: 400),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(color: Colors.yellow, height: 800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
