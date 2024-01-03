import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '01_edit_mode_row_page.dart';

import '../widgets/index.dart';

class EditModePage extends StatefulWidget {
  const EditModePage({super.key});

  @override
  State<StatefulWidget> createState() => _StateEditPage();
}

class _StateEditPage extends State<EditModePage> {
  late Map<int, int> stds = {}; // 1000次 对应数字出现的次数
  late List<ModeRow> rows;

  @override
  void initState() {
    super.initState();

    // 计算每个数字在1000次的标准次数
    for (var i in List.generate(10, (i) => i)) {
      for (var j in List.generate(10, (j) => j)) {
        for (var k in List.generate(10, (k) => k)) {
          stds.update(i + j + k, (v) => v + 1, ifAbsent: () => 1);
        }
      }
    }

    // 生成测试数据
    rows = List.generate(
      30,
      (index) {
        late int total = 0;
        late Map<int, int> bets = {};

        // 随机选取10个数字
        List.generate(
          10 + Random().nextInt(5),
          (index) {
            final result = Random().nextInt(28);
            final std = stds[result]! * 10000;

            total += std;
            bets.update(result, (value) => value + std, ifAbsent: () => std);
          },
        );

        return ModeRow(
          "$index-${Random().nextInt(10000)}",
          "模式 $index",
          NumberFormat("#,###").format(total),
          bets,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("编辑模式"),
        centerTitle: true,
        actions: [
          IconCircleButton(Icons.add, onPressed: onAdd),
        ],
      ),
      body: rows.isNotEmpty
          ? Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black26, width: 2),
              ),
              child: ListView.separated(
                itemCount: rows.length,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (BuildContext context, int index) {
                  final row = rows[index];

                  return ListTile(
                    dense: true,
                    title: Row(
                      children: [
                        SizedBox(width: 36, child: Text("${index + 1}")),
                        Expanded(child: Text(row.name)),
                        Expanded(
                          child: Text(row.total, textAlign: TextAlign.right),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    splashColor: Theme.of(context).primaryColor,
                    onTap: () => onEdit(row),
                  );
                },
                separatorBuilder: (context, index) => const Divider(height: 0),
              ),
            )
          : const Center(
              child: Icon(Icons.search, size: 128, color: Colors.black26),
            ),
    );
  }

  // 新增模式
  void onAdd() async {
    final bool? ok = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditModeRowPage(EditModeRowAction.add, stds),
      ),
    );

    if (ok != null && ok) {
      debugPrint("操作成功");
    }
  }

  // 编辑模式
  void onEdit(ModeRow row) async {
    final bool? ok = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditModeRowPage(
          EditModeRowAction.edit,
          stds,
          id: row.id,
          name: row.name,
          total: row.total,
          bets: row.bets,
        ),
      ),
    );

    if (ok != null && ok) {
      debugPrint("操作成功");
    }
  }
}

class ModeRow {
  final String id;
  final String name;
  final String total;
  final Map<int, int> bets;

  ModeRow(this.id, this.name, this.total, this.bets);
}
