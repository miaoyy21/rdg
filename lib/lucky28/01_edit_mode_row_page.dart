import 'package:flutter/material.dart';

import '../widgets/icon_circle_button.dart';

class EditModeRowPage extends StatefulWidget {
  final EditModeRowAction action;
  final String? id;

  final String? name;
  final String? total;
  final Map<int, int>? bets;

  const EditModeRowPage(
    this.action, {
    super.key,
    this.id,
    this.name,
    this.total,
    this.bets,
  });

  @override
  State<StatefulWidget> createState() => _StateEditModeRowPage();
}

class _StateEditModeRowPage extends State<EditModeRowPage> {
  late String name = "";
  late String total = "";
  late Map<int, int> bets = {};

  @override
  void initState() {
    super.initState();

    if (widget.action == EditModeRowAction.edit) {
      name = widget.name!;
      total = widget.total!;
      bets = widget.bets!;
    }
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle style16 =
        TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
    final primary = Theme.of(context).primaryColor;

    late String title = "新增模式";
    if (widget.action == EditModeRowAction.edit) {
      title = name;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [
          IconCircleButton(Icons.save, onPressed: onSave),
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
              Row(
                children: [
                  const SizedBox(width: 8),
                  const Text(
                    "投注总额",
                    textAlign: TextAlign.right,
                    style: style16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      total,
                      style: style16.copyWith(color: primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Flexible(
                fit: FlexFit.loose,
                child: Container(color: Colors.red, height: 200),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(color: Colors.green, height: 900),
              ),
              Text("111111"),
            ],
          ),
        ),
      ),
    );
  }

  void onSave() {
    Navigator.of(context).pop(true);
  }
}

enum EditModeRowAction { add, edit }
