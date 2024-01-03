import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/index.dart';

class EditModePage extends StatefulWidget {
  const EditModePage({super.key});

  @override
  State<StatefulWidget> createState() => _StateEditPage();
}

class _StateEditPage extends State<EditModePage> {
  late List<ModeRow> rows;

  @override
  void initState() {
    super.initState();

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
            final std = stds[result]! * 10;

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
          IconCircleButton(
            Icons.add,
            onPressed: () {
              debugPrint("添加模式");
            },
          ),
        ],
      ),
      body: rows.isNotEmpty
          ? Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black12, width: 2),
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
                            child: Text(row.total, textAlign: TextAlign.right)),
                      ],
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    splashColor: Theme.of(context).primaryColor,
                    onTap: () {
                      debugPrint('Selected: ${rows[index]}');
                      Navigator.pop(context, rows[index]);
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(height: 0),
              ),
            )
          : const Center(
              child: Icon(Icons.search, size: 128, color: Colors.black12),
            ),
    );
  }
}

class ModeRow {
  final String id;
  final String name;
  final String total;
  final Map<int, int> bets;

  ModeRow(this.id, this.name, this.total, this.bets);
}

// 1000次 对应数字出现的次数
final Map<int, int> stds = {
  0: 1,
  1: 3,
  2: 6,
  3: 10,
  4: 15,
  5: 21,
  6: 28,
  7: 36,
  8: 45,
  9: 55,
  10: 63,
  11: 69,
  12: 73,
  13: 75,
  14: 75,
  15: 73,
  16: 69,
  17: 63,
  18: 55,
  19: 45,
  20: 36,
  21: 28,
  22: 21,
  23: 15,
  24: 10,
  25: 6,
  26: 3,
  27: 1
};

// Container(
//   padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
//   child: SingleChildScrollView(
//     scrollDirection: Axis.vertical,
//     child: Flex(
//       direction: Axis.vertical,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Flexible(
//           fit: FlexFit.loose,
//           child: Container(color: Colors.red, height: 200),
//         ),
//         Flexible(
//           fit: FlexFit.loose,
//           child: Container(color: Colors.green, height: 400),
//         ),
//         Flexible(
//           fit: FlexFit.loose,
//           child: Container(color: Colors.yellow, height: 800),
//         ),
//       ],
//     ),
//   ),
// ),
