import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<StatefulWidget> createState() => _StateMinePage();
}

class _StateMinePage extends State<MinePage> {
  late List<MineRow> rows;

  final List<MineCell> cells = [
    MineCell("期号", TextAlign.center, (row) => "${row.issue}"),
    MineCell("开奖", TextAlign.center, (row) => "${row.result}"),
    MineCell(
      "盈亏",
      TextAlign.right,
      (row) => NumberFormat("#,###").format(row.win),
      colorFn: (row) => row.win >= 0 ? Colors.red : Colors.green,
    ),
    MineCell(
        "花费", TextAlign.right, (row) => NumberFormat("#,###").format(row.cost)),
    MineCell("获得", TextAlign.right,
        (row) => NumberFormat("#,###").format(row.total)),
  ];

  @override
  void initState() {
    super.initState();

    rows = List.generate(
      100,
      (index) => MineRow(
        300000000 - index,
        Random().nextInt(10) + Random().nextInt(10) + Random().nextInt(10),
        Random().nextInt(100000000) - 50000000,
        Random().nextInt(100000000) + 50000000,
        Random().nextInt(100000000) + 100000000,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const style0 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const style1 = TextStyle(fontSize: 13);

    return Scaffold(
      appBar: AppBar(title: const Text("我的投注"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 32),
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            border: TableBorder.all(width: 2, color: Colors.black12),
            columnWidths: const {
              0: FixedColumnWidth(88),
              1: FixedColumnWidth(48),
              2: FixedColumnWidth(116),
              3: FixedColumnWidth(116),
              4: FixedColumnWidth(116)
            },
            children: [
              TableRow(
                children: [
                  ...cells.map(
                    (cell) => TableCell(
                      child: SizedBox(
                        height: 36,
                        child: Center(child: Text(cell.name, style: style0)),
                      ),
                    ),
                  ),
                ],
              ),
              ...rows.map(
                (row) => TableRow(
                  children: [
                    ...cells.map(
                      (cell) => TableCell(
                        child: Container(
                          height: 26,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            cell.textFn(row),
                            textAlign: cell.textAlign,
                            style: style1.copyWith(
                              color: cell.colorFn != null
                                  ? cell.colorFn!(row)
                                  : null,
                            ),
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
    );
  }
}

class MineRow {
  final int issue;
  final int result;
  final int win;
  final int total;
  final int cost;

  MineRow(this.issue, this.result, this.win, this.total, this.cost);
}

class MineCell {
  final String name;
  final TextAlign textAlign;
  final String Function(MineRow) textFn;
  final Color Function(MineRow)? colorFn;

  MineCell(this.name, this.textAlign, this.textFn, {this.colorFn});
}
