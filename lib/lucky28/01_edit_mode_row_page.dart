import 'package:flutter/material.dart';

import '../widgets/icon_circle_button.dart';
import '../widgets/rectangle_circle_button.dart';

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
  late String total = "0";
  late Map<int, int> bets = {};

  late List<EditModeMode> modes;

  @override
  void initState() {
    super.initState();

    modes = [
      EditModeMode("大", (v) => v >= 14),
      EditModeMode("小", (v) => v <= 13),
      EditModeMode("单", (v) => v.isOdd),
      EditModeMode("双", (v) => v.isEven),
      EditModeMode("中", (v) => v >= 10 && v <= 17),
      EditModeMode("边", (v) => v <= 9 || v >= 18),
      EditModeMode("大尾", (v) => v % 10 >= 5),
      EditModeMode("小尾", (v) => v % 10 <= 4),
    ];

    if (widget.action == EditModeRowAction.edit) {
      name = widget.name!;
      total = widget.total!;
      bets = widget.bets!;
    }
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle style16 =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(width: 8),
                  const Text(
                    "投注总额",
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
              const Row(
                children: [
                  SizedBox(width: 8),
                  Text(
                    "模式",
                    style: style16,
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...modes.map(
                          (mode) => RectangleCircleButton(
                            label: mode.name,
                            fontSize: 14,
                            width: 48,
                            height: 32,
                            onPressed: () => onMode(mode),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  SizedBox(width: 8),
                  Text(
                    "倍率",
                    style: style16,
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...modes.map(
                          (q) => RectangleCircleButton(
                            label: q.name,
                            fontSize: 14,
                            width: 48,
                            height: 32,
                            onPressed: () => onMode(q),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Container(color: Colors.green, height: 900),
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

  // 快捷模式
  onMode(EditModeMode quick) {}

  // 保存
  void onSave() {
    Navigator.of(context).pop(true);
  }
}

enum EditModeRowAction { add, edit }

class EditModeMode {
  final String name;
  final bool Function(int) fn;

  EditModeMode(this.name, this.fn);
}
