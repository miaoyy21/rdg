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
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

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

    return Scaffold(
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
                  labelFn("初始模式"),
                  const SizedBox(width: 16),
                  Expanded(
                    child: RectangleCircleButton(
                      label: "mode.name",
                      icon: Icons.keyboard_arrow_down,
                      elevation: 0,
                      fontSize: 14,
                      height: 32,
                      onPressed: () {},
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
                    child: TextFieldBox("达到自动期数时，将停止运行", _issueController),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  labelFn("最小值"),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFieldBox("低于最小值时，将停止运行", _minController),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  labelFn("最大值"),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFieldBox("高于最大值时，将停止运行（0：不限制）", _maxController),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              labelFn("设定规则"),
              ...widget.modes.map(
                (mode) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      labelFn(mode.name),
                      const SizedBox(width: 16),
                      Expanded(
                        child: RectangleCircleButton(
                          label: "Setting 1",
                          icon: Icons.keyboard_arrow_down,
                          elevation: 0,
                          fontSize: 14,
                          height: 32,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: RectangleCircleButton(
                          label: "Setting 2",
                          icon: Icons.keyboard_arrow_down,
                          elevation: 0,
                          fontSize: 14,
                          height: 32,
                          onPressed: () {},
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
                    child: RectangleCircleButton(
                      label: "开启自动投注",
                      onPressed: onSave,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 开启或关闭 自动投注
  void onSave() {}
}