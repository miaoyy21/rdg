import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/index.dart';

class EditModeRowPage extends StatefulWidget {
  final EditModeRowAction action;
  final Map<int, int> stds;
  final String? id;

  final String? name;
  final String? total;
  final Map<int, int>? bets;

  const EditModeRowPage(
    this.action,
    this.stds, {
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

  final TextEditingController _controller = TextEditingController();
  late List<EditModeDefinedMode> modes;
  final List<double> rates = [0.1, 0.5, 0.8, 2, 10, 100];
  final format = NumberFormat("#,###").format;

  @override
  void initState() {
    super.initState();

    modes = [
      EditModeDefinedMode("大", (v) => v >= 14),
      EditModeDefinedMode("小", (v) => v <= 13),
      EditModeDefinedMode("单", (v) => v.isOdd),
      EditModeDefinedMode("双", (v) => v.isEven),
      EditModeDefinedMode("中", (v) => v >= 10 && v <= 17),
      EditModeDefinedMode("边", (v) => v <= 9 || v >= 18),
      EditModeDefinedMode("大尾", (v) => v % 10 >= 5),
      EditModeDefinedMode("小尾", (v) => v % 10 <= 4),
    ];

    if (widget.action == EditModeRowAction.edit) {
      name = widget.name!;
      total = widget.total!;
      bets = widget.bets!;
    }

    _controller.text = name;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const style16 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const style24 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    final primary = Theme.of(context).primaryColor;

    late String title = "新增模式";
    if (widget.action == EditModeRowAction.edit) {
      title = name;
    }

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
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
                    const Text("投注总额", style: style16),
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
                Row(
                  children: [
                    const SizedBox(width: 8),
                    const Text("模式名称", style: style16),
                    const SizedBox(width: 8),
                    Expanded(child: TextFieldBox("请输入模式名称", _controller)),
                  ],
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    SizedBox(width: 8),
                    Text("模式", style: style16),
                    Expanded(child: SizedBox()),
                  ],
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...modes.map(
                          (mode) => RectangleCircleButton(
                            label: mode.name,
                            elevation: 0,
                            fontSize: 14,
                            height: 32,
                            onPressed: () => onMode(mode),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    SizedBox(width: 8),
                    Text("倍率", style: style16),
                    Expanded(child: SizedBox()),
                  ],
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...rates.map(
                          (rate) => RectangleCircleButton(
                            label: "${rate < 1 ? rate : rate.toInt()}",
                            elevation: 0,
                            fontSize: 14,
                            height: 32,
                            onPressed: () => onRate(rate),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    SizedBox(width: 8),
                    Text("明细", style: style16),
                    Expanded(child: SizedBox()),
                  ],
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: SizedBox(
                    height: width,
                    child: GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      children: [
                        ...List.generate(
                          28,
                          (i) => InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: bets.containsKey(i)
                                    ? primary.withOpacity(0.3)
                                    : Colors.transparent,
                                border: Border.all(
                                    color: bets.containsKey(i)
                                        ? primary.withOpacity(0.3)
                                        : Colors.black26,
                                    width: 2),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    format(bets.containsKey(i) ? bets[i] : 0),
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text("$i", style: style24),
                                    ),
                                  ),
                                  Text(
                                    "${widget.stds[i]}",
                                    style: const TextStyle(
                                      fontSize: 9,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onTap: () => onCheck(i),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RectangleCircleButton(
                        label: "清空",
                        onPressed: onClean,
                      ),
                    ),
                    Expanded(
                      child: RectangleCircleButton(
                        label: "删除",
                        onPressed: onDelete,
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

  // 模式
  void onMode(EditModeDefinedMode mode) {
    var summary = int.parse(total.replaceAll(",", ""));
    if ((summary + 1000) > 1 << 52) {
      debugPrint("$summary + 1000 超过设定上限，不进行处理");
      return;
    }

    List.generate(28, (i) {
      if (!mode.fn(i)) {
        return;
      }

      final std = widget.stds[i]!;
      bets.update(i, (v) => v + std, ifAbsent: () => std);
    });

    total = format(bets.values.reduce((v, e) => v + e));
    setState(() {});
  }

  // 倍率
  void onRate(double rate) {
    var summary = int.parse(total.replaceAll(",", ""));
    if ((summary * rate) > 1 << 52) {
      debugPrint("$summary * $rate 超过设定上限，不进行处理");
      return;
    }

    bets.updateAll((k, v) => (v * rate).floor());
    bets.removeWhere((k, v) => v == 0); // 倍数小于1时，可能产生0

    summary = 0;
    if (bets.values.isNotEmpty) {
      summary = bets.values.reduce((v, e) => v + e);
    }

    total = format(summary);
    setState(() {});
  }

  // 选择数字或取消数字选择
  void onCheck(int i) {
    if (bets.containsKey(i)) {
      // 取消选择
      bets.remove(i);

      var summary = 0;
      if (bets.values.isNotEmpty) {
        summary = bets.values.reduce((v, e) => v + e);
      }

      total = format(summary);
    } else {
      // 选中数字
      var summary = int.parse(total.replaceAll(",", ""));
      if ((summary + 1000) > 1 << 52) {
        debugPrint("$summary + 1000 超过设定上限，不进行处理");
        return;
      }

      bets[i] = widget.stds[i]!;
      total = format(bets.values.reduce((v, e) => v + e));
    }

    setState(() {});
  }

  // 清空
  void onClean() {
    bets.clear();
    total = "0";
    setState(() {});
  }

  // 删除
  void onDelete() {
    if (widget.action == EditModeRowAction.add) {
      Navigator.of(context).pop(); // 注意：不返回任何值
      return;
    }

    debugPrint("删除模式ID ${widget.id}");
    Navigator.of(context).pop(true);
  }

  // 保存
  void onSave() {
    final action = widget.action;
    final id = widget.id;
    final name = _controller.text;

    debugPrint("{action:${action.name}, id:$id, "
        "name:$name, total:$total, bets:$bets}");
    Navigator.of(context).pop(true);
  }
}

enum EditModeRowAction { add, edit }

class EditModeDefinedMode {
  final String name;
  final bool Function(int) fn;

  EditModeDefinedMode(this.name, this.fn);
}
