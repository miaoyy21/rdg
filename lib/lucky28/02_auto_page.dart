import 'package:flutter/material.dart';

import '../widgets/icon_circle_button.dart';

class AutoPage extends StatefulWidget {
  const AutoPage({super.key});

  @override
  State<StatefulWidget> createState() => _StateAutoPage();
}

class _StateAutoPage extends State<AutoPage> {
  final TextEditingController _issueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const style16 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const style24 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    final primary = Theme.of(context).primaryColor;
    final secondary = Theme.of(context).secondaryHeaderColor;

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
                  const SizedBox(width: 8),
                  const Text(
                    "投注总额",
                    style: style16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "total",
                      style: style16.copyWith(color: primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(width: 8),
                  const Text(
                    "模式名称",
                    style: style16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SizedBox(
                      height: 36,
                      child: TextField(
                        controller: _issueController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: BorderSide(color: primary),
                          ),
                          filled: true,
                          fillColor: secondary,
                          hintText: '请输入模式名称',
                        ),
                      ),
                    ),
                  ),
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
              // Flexible(
              //   fit: FlexFit.loose,
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         ...modes.map(
              //           (mode) => RectangleCircleButton(
              //             label: mode.name,
              //             fontSize: 14,
              //             height: 32,
              //             onPressed: () => onMode(mode),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 4),
              // const Row(
              //   children: [
              //     SizedBox(width: 8),
              //     Text("倍率", style: style16),
              //     Expanded(child: SizedBox()),
              //   ],
              // ),
              // Flexible(
              //   fit: FlexFit.loose,
              //   child: SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         ...rates.map(
              //           (rate) => RectangleCircleButton(
              //             label: "${rate < 1 ? rate : rate.toInt()}",
              //             fontSize: 14,
              //             height: 32,
              //             onPressed: () => onRate(rate),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 8),
              // const Row(
              //   children: [
              //     SizedBox(width: 8),
              //     Text("明细", style: style16),
              //     Expanded(child: SizedBox()),
              //   ],
              // ),
              // Flexible(
              //   fit: FlexFit.loose,
              //   child: SizedBox(
              //     height: width,
              //     child: GridView(
              //       physics: const NeverScrollableScrollPhysics(),
              //       gridDelegate:
              //           const SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 6,
              //         crossAxisSpacing: 4,
              //         mainAxisSpacing: 4,
              //       ),
              //       children: [
              //         ...List.generate(
              //           28,
              //           (i) => InkWell(
              //             child: Container(
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(4),
              //                 color: bets.containsKey(i)
              //                     ? primary.withOpacity(0.3)
              //                     : Colors.transparent,
              //                 border: Border.all(
              //                     color: bets.containsKey(i)
              //                         ? primary.withOpacity(0.3)
              //                         : Colors.black26,
              //                     width: 2),
              //               ),
              //               child: Column(
              //                 children: [
              //                   Text(
              //                     format(bets.containsKey(i) ? bets[i] : 0),
              //                     overflow: TextOverflow.ellipsis,
              //                     style: const TextStyle(fontSize: 12),
              //                   ),
              //                   Expanded(
              //                     child: Center(
              //                       child: Text("$i", style: style24),
              //                     ),
              //                   ),
              //                   Text(
              //                     "${widget.stds[i]}",
              //                     style: const TextStyle(
              //                       fontSize: 9,
              //                       fontStyle: FontStyle.italic,
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //             onTap: () => onCheck(i),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Expanded(
              //       child: RectangleCircleButton(
              //         label: "清空",
              //         onPressed: onClean,
              //       ),
              //     ),
              //     Expanded(
              //       child: RectangleCircleButton(
              //         label: "删除",
              //         onPressed: onDelete,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
