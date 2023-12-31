import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<StatefulWidget> createState() => _StateMinePage();
}

class _StateMinePage extends State<MinePage> {
  late List<MineCell> cells;
  late List<MineRow> rows;

  late int win1;
  late double rate1;
  late int win7;
  late int win31;
  final format = NumberFormat("#,###").format;

  @override
  void initState() {
    super.initState();

    colorFn(row) => row.win > 0 ? Colors.red : Colors.green;

    cells = [
      MineCell("期号", 96, TextAlign.center, (row) => "${row.issue}"),
      MineCell("开奖", 56, TextAlign.center, (row) => "${row.result}"),
      MineCell("盈亏", 112, TextAlign.right, (row) => format(row.win),
          colorFn: colorFn),
      MineCell("获得", 112, TextAlign.right, (row) => format(row.total),
          colorFn: colorFn),
      MineCell("花费", 112, TextAlign.right, (row) => format(row.cost)),
    ];

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

    win1 = Random().nextInt(100000000) - 50000000;
    rate1 = Random().nextDouble();
    win7 = Random().nextInt(100000000) - 50000000;
    win31 = Random().nextInt(1000000000) - 500000000;
  }

  @override
  Widget build(BuildContext context) {
    const style0 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const style1 = TextStyle(fontSize: 13);
    const TextStyle style16 =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    labelFn(String label) {
      return Text(
        label,
        textAlign: TextAlign.right,
        style: style16,
      );
    }

    textFn(String text, int value) {
      return Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: value > 0 ? Colors.red : Colors.green,
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(title: const Text("我的投注"), centerTitle: true),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  labelFn("今日盈亏"),
                  const SizedBox(width: 8),
                  Expanded(child: textFn(format(win1), win1)),
                  labelFn("今日胜率"),
                  const SizedBox(width: 8),
                  Expanded(
                    child: textFn("${(rate1 * 100).toStringAsFixed(2)}%", win1),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  labelFn("本周盈亏"),
                  const SizedBox(width: 8),
                  Expanded(child: textFn(format(win7), win7)),
                  labelFn("当月盈亏"),
                  const SizedBox(width: 8),
                  Expanded(
                    child: textFn(format(win31), win31),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 24),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      border: TableBorder.all(color: Colors.black26),
                      columnWidths: {
                        ...cells.asMap().map((k, cell) =>
                            MapEntry(k, FixedColumnWidth(cell.width))),
                      },
                      children: [
                        TableRow(
                          children: [
                            ...cells.map(
                              (cell) => TableCell(
                                child: SizedBox(
                                  height: 36,
                                  child: Center(
                                    child: Text(cell.name, style: style0),
                                  ),
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
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
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
              ),
            ),
          ],
        ));
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
  final double width;
  final TextAlign textAlign;
  final String Function(MineRow) textFn;
  final Color Function(MineRow)? colorFn;

  MineCell(this.name, this.width, this.textAlign, this.textFn, {this.colorFn});
}
