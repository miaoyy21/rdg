import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoriesPage extends StatefulWidget {
  const HistoriesPage({super.key});

  @override
  State<StatefulWidget> createState() => _HistoriesPageState();
}

class _HistoriesPageState extends State<HistoriesPage> {
  late List<HisToriesData> histories;

  @override
  void initState() {
    super.initState();

    histories = List.generate(
      200,
      (index) => HisToriesData(
        300000000 - index,
        Random().nextInt(10) + Random().nextInt(10) + Random().nextInt(10),
        Random().nextInt(100000000) + 100000000,
        Random().nextInt(100) + 100,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const style0 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const style1 = TextStyle(fontSize: 13);

    return Scaffold(
      appBar: AppBar(title: const Text("历史分析"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 32),
        scrollDirection: Axis.vertical,
        child: Row(
          children: [
            // 左侧表格
            Table(
              border: TableBorder.all(width: 2, color: Colors.black12),
              columnWidths: const {
                0: FixedColumnWidth(72),
                1: FixedColumnWidth(48)
              },
              children: [
                const TableRow(
                  children: [
                    TableCell(
                      child: SizedBox(
                        height: 36,
                        child: Center(child: Text("期号", style: style0)),
                      ),
                    ),
                    TableCell(
                      child: SizedBox(
                        height: 36,
                        child: Center(child: Text("开奖", style: style0)),
                      ),
                    )
                  ],
                ),
                ...histories.map(
                  (v) => TableRow(
                    children: [
                      TableCell(
                        child: SizedBox(
                          height: 26,
                          child: Center(
                            child: Text("${v.issue}", style: style1),
                          ),
                        ),
                      ),
                      TableCell(
                        child: SizedBox(
                          height: 26,
                          child: Center(
                            child: Text("${v.result}", style: style1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // 右侧表格
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  border: TableBorder.all(width: 2, color: Colors.black12),
                  columnWidths: {
                    ...cells
                        .asMap()
                        .map((k, v) => MapEntry(k, const FixedColumnWidth(64))),
                    cells.length: const FixedColumnWidth(116),
                    cells.length + 1: const FixedColumnWidth(88)
                  },
                  children: [
                    TableRow(
                      children: [
                        ...cells.map(
                          (e) => TableCell(
                            child: SizedBox(
                              height: 36,
                              child: Center(child: Text(e.name, style: style0)),
                            ),
                          ),
                        ),
                        const TableCell(
                          child: SizedBox(
                            height: 36,
                            child: Center(child: Text("投注总额", style: style0)),
                          ),
                        ),
                        const TableCell(
                          child: SizedBox(
                            height: 36,
                            child: Center(child: Text("中奖人数", style: style0)),
                          ),
                        )
                      ],
                    ),
                    ...histories.map(
                      (v) => TableRow(
                        children: [
                          ...cells.map(
                            (e) => TableCell(
                              child: Container(
                                height: 26,
                                color: e.background,
                                child: Center(
                                  child: Text(
                                    e.fn(v.result) ? e.name : "",
                                    style: style1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 26,
                              child: Center(
                                child: Text(
                                  NumberFormat("#,###").format(v.total),
                                  style: style1,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: SizedBox(
                              height: 26,
                              child: Center(
                                child: Text(
                                  NumberFormat("#,###").format(v.wins),
                                  style: style1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HisToriesData {
  final int issue;
  final int result;
  final int total;
  final int wins;

  HisToriesData(this.issue, this.result, this.total, this.wins);
}

class HistoriesCell {
  final String name;
  final Color background;
  final bool Function(int) fn;

  HistoriesCell(this.name, this.background, this.fn);
}

final List<HistoriesCell> cells = [
  HistoriesCell("大", Colors.red.shade50, (v) => v >= 14),
  HistoriesCell("小", Colors.red.shade50, (v) => v <= 13),
  HistoriesCell("单", Colors.green.shade50, (v) => v.isOdd),
  HistoriesCell("双", Colors.green.shade50, (v) => v.isEven),
  HistoriesCell("中", Colors.blue.shade50, (v) => v >= 10 && v <= 17),
  HistoriesCell("边", Colors.blue.shade50, (v) => v <= 9 || v >= 18),
  HistoriesCell("大尾", Colors.purple.shade50, (v) => v % 10 >= 5),
  HistoriesCell("小尾", Colors.purple.shade50, (v) => v % 10 <= 4),
];
