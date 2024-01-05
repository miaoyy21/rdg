import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'icon_circle_button.dart';

class StepLine extends StatelessWidget {
  final int num;
  final List<int> steps;
  final Function(int) callback;

  StepLine(this.num, this.steps, this.callback, {super.key});

  final format = NumberFormat("#,###").format;

  @override
  Widget build(BuildContext context) {
    const style18 = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconCircleButton(
          Icons.remove,
          onPressed: () => onBase(false),
        ),
        Container(
          width: 128,
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black26),
          ),
          child: Center(child: Text(format(num), style: style18)),
        ),
        IconCircleButton(
          Icons.add,
          onPressed: () => onBase(true),
        ),
      ],
    );
  }

  void onBase(bool flag) {
    final index = steps.indexWhere((n) => n == num);
    if (index < 0) {
      throw FlutterError("$num 不在投注基数列表中");
    }

    // [true] 增加；[false]减少
    if (flag) {
      if (index + 1 < steps.length) {
        callback(steps[index + 1]);
      }
    } else {
      if (index - 1 >= 0) {
        callback(steps[index - 1]);
      }
    }
  }
}

class StepLineSteps {
  static final StepLineSteps _instance = StepLineSteps._internal();

  factory StepLineSteps() => _instance;

  StepLineSteps._internal();

  final List<int> lucky28 = [
    500,
    1000,
    2000,
    5000,
    10000,
    20000,
    50000,
    100000,
    200000,
    500000,
    1000000,
    2000000,
    5000000,
    10000000,
    20000000,
    50000000,
    100000000,
    200000000,
    500000000,
  ];
}
