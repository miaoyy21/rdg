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

    // 投注名称
    if (widget.name != null) {
      name = widget.name!;
    }

    // 累计投注
    if (widget.total != null) {
      total = widget.total!;
    }

    // 数字及其对应的投注额
    if (widget.bets != null) {
      bets = widget.bets!;
    }
  }

  @override
  Widget build(BuildContext context) {
    late String title = "编辑模式";
    if (widget.action == EditModeRowAction.add) {
      title = "新增模式";
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

  void onSave() {
    Navigator.of(context).pop(true);
  }
}

enum EditModeRowAction { add, edit }
