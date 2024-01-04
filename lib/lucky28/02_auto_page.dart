import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/index.dart';
import '03_select_mode_sheet.dart';

class AutoPage extends StatefulWidget {
  final List<Mode> modes;

  const AutoPage(this.modes, {super.key});

  @override
  State<StatefulWidget> createState() => _StateAutoPage();
}

class _StateAutoPage extends State<AutoPage> {
  late String start;
  late Map<String, ModeRule> rules;
  late int autoIssue;

  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final modes = widget.modes;

    start = modes[Random().nextInt(modes.length)].id;
    rules = modes.asMap().map(
          (_, m) => MapEntry(
            m.id,
            ModeRule(
              Random().nextInt(3) == 1
                  ? m.id
                  : modes[Random().nextInt(modes.length)].id,
              Random().nextInt(3) == 2
                  ? m.id
                  : modes[Random().nextInt(modes.length)].id,
            ),
          ),
        );
    autoIssue = 10;

    _issueController.text = "1000";
    _minController.text = "30000000";
    _maxController.text = "0";
  }

  @override
  Widget build(BuildContext context) {
    const style16 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    labelFn(String label) {
      return SizedBox(
        width: 72,
        child: Text(
          label,
          style: style16,
          textAlign: TextAlign.right,
        ),
      );
    }

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(title: const Text("自动投注"), centerTitle: true),
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
                    labelFn("开始模式"),
                    const SizedBox(width: 16),
                    Expanded(
                      child: RectangleCircleButton(
                        label: widget.modes
                            .firstWhere((m) => m.id == start,
                                orElse: () => widget.modes.first)
                            .name,
                        icon: Icons.keyboard_arrow_down,
                        elevation: 0,
                        fontSize: 14,
                        height: 32,
                        onPressed: autoIssue <= 0 ? onSelectModeStart : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(child: SizedBox()),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    labelFn("自动期数"),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFieldBox(
                        "达到自动期数时，将停止运行",
                        _issueController,
                        keyboardType: TextInputType.number,
                        readOnly: autoIssue > 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    labelFn("最小值"),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFieldBox(
                        "低于最小值时，将停止运行",
                        _minController,
                        keyboardType: TextInputType.number,
                        readOnly: autoIssue > 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    labelFn("最大值"),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFieldBox(
                        "高于最大值时，将停止运行（0：不限制）",
                        _maxController,
                        keyboardType: TextInputType.number,
                        readOnly: autoIssue > 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                labelFn("设定规则"),
                ...widget.modes.map(
                  (mode) => Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black26)),
                    ),
                    child: Row(
                      children: [
                        labelFn(mode.name),
                        const SizedBox(width: 16),
                        Expanded(
                          child: RectangleCircleButton(
                            label: widget.modes
                                .firstWhere((m) => m.id == rules[mode.id]?.win,
                                    orElse: () => mode)
                                .name,
                            icon: Icons.keyboard_arrow_down,
                            elevation: 0,
                            fontSize: 14,
                            height: 32,
                            onPressed: autoIssue <= 0
                                ? () => onSelectModeRules(mode, true)
                                : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: RectangleCircleButton(
                            label: widget.modes
                                .firstWhere((m) => m.id == rules[mode.id]?.lose,
                                    orElse: () => mode)
                                .name,
                            icon: Icons.keyboard_arrow_down,
                            elevation: 0,
                            fontSize: 14,
                            height: 32,
                            onPressed: autoIssue <= 0
                                ? () => onSelectModeRules(mode, false)
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: autoIssue > 0
                          ? RectangleCircleButton(
                              label: "关闭自动投注",
                              onPressed: onCancel,
                            )
                          : RectangleCircleButton(
                              label: "开启自动投注",
                              onPressed: onStart,
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 开始模式
  onSelectModeStart() async {
    final String? id = await onSelectModeSheet(context, widget.modes);
    if (id != null) {
      setState(() {
        start = id;
      });
    }
  }

  // 设定规则
  onSelectModeRules(Mode mode, bool flag) async {
    final String? id = await onSelectModeSheet(context, widget.modes);
    if (id != null) {
      if (flag) {
        rules.update(mode.id, (rule) => ModeRule(id, rule.lose));
      } else {
        rules.update(mode.id, (rule) => ModeRule(rule.win, id));
      }

      setState(() {});
    }
  }

  // 开启自动投注
  void onStart() {
    debugPrint("{start:$start,issue:${_issueController.text},"
        "min:${_minController.text},max:${_maxController.text}");

    debugPrint("rules: ");
    rules.forEach((id, rule) {
      debugPrint("$id => {win:${rule.win},lose:${rule.lose}} ");
    });

    final issue = int.tryParse(_issueController.text);
    if (issue == null) {
      debugPrint("自动期数：${_issueController.text} 不合法");
    }

    autoIssue = 100;
    setState(() {});
  }

  // 关闭自动投注
  void onCancel() {
    autoIssue = 0;
    setState(() {});
  }
}

class ModeRule {
  final String win;
  final String lose;

  ModeRule(this.win, this.lose);
}
