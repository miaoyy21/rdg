import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoriesPage extends StatefulWidget {
  const HistoriesPage({super.key});

  @override
  State<StatefulWidget> createState() => _StateHistoriesPage();
}

class _StateHistoriesPage extends State<HistoriesPage> {
  late List<HistoriesCell> cells;
  late List<HistoriesRow> rows;

  final format = NumberFormat("#,###").format;

  @override
  void initState() {
    super.initState();

    cells = [
      HistoriesCell("大", Colors.red.shade50, (v) => v >= 14),
      HistoriesCell("小", Colors.red.shade50, (v) => v <= 13),
      HistoriesCell("单", Colors.green.shade50, (v) => v.isOdd),
      HistoriesCell("双", Colors.green.shade50, (v) => v.isEven),
      HistoriesCell("中", Colors.blue.shade50, (v) => v >= 10 && v <= 17),
      HistoriesCell("边", Colors.blue.shade50, (v) => v <= 9 || v >= 18),
      HistoriesCell("大尾", Colors.purple.shade50, (v) => v % 10 >= 5),
      HistoriesCell("小尾", Colors.purple.shade50, (v) => v % 10 <= 4),
    ];

    rows = List.generate(
      200,
      (index) => HistoriesRow(
        "${300000000 - index}",
        Random().nextInt(10) + Random().nextInt(10) + Random().nextInt(10),
        format(Random().nextInt(100000000) + 100000000),
        format(Random().nextInt(100) + 100),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const style0 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const style1 = TextStyle(fontSize: 13);
    const padding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);

    return Scaffold(
      appBar: AppBar(title: const Text("历史分析"), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            children: [
              // 左侧表格
              Table(
                border: TableBorder.all(width: 2, color: Colors.black26),
                columnWidths: const {
                  0: FixedColumnWidth(88),
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
                  ...rows.map(
                    (row) => TableRow(
                      children: [
                        TableCell(
                          child: SizedBox(
                            height: 26,
                            child: Center(
                              child: Text(row.issue, style: style1),
                            ),
                          ),
                        ),
                        TableCell(
                          child: SizedBox(
                            height: 26,
                            child: Center(
                              child: Text("${row.result}", style: style1),
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
                    border: TableBorder.all(width: 2, color: Colors.black26),
                    columnWidths: {
                      ...cells.asMap().map(
                          (k, v) => MapEntry(k, const FixedColumnWidth(64))),
                      cells.length: const FixedColumnWidth(112),
                      cells.length + 1: const FixedColumnWidth(88)
                    },
                    children: [
                      TableRow(
                        children: [
                          ...cells.map(
                            (cell) => TableCell(
                              child: SizedBox(
                                height: 36,
                                child: Center(
                                    child: Text(cell.name, style: style0)),
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
                      ...rows.map(
                        (row) => TableRow(
                          children: [
                            ...cells.map(
                              (cell) => TableCell(
                                child: Container(
                                  height: 26,
                                  color: cell.background,
                                  child: Center(
                                    child: Text(
                                      cell.fn(row.result) ? cell.name : "",
                                      style: style1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 26,
                                padding: padding,
                                child: Text(
                                  row.total,
                                  textAlign: TextAlign.right,
                                  style: style1,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 26,
                                padding: padding,
                                child: Text(
                                  row.wins,
                                  textAlign: TextAlign.right,
                                  style: style1,
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
      ),
    );
  }
}

class HistoriesRow {
  final String issue;
  final int result;
  final String total;
  final String wins;

  HistoriesRow(this.issue, this.result, this.total, this.wins);
}

class HistoriesCell {
  final String name;
  final Color background;
  final bool Function(int) fn;

  HistoriesCell(this.name, this.background, this.fn);
}
