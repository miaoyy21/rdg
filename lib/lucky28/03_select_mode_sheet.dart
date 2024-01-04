import 'package:flutter/material.dart';

Future onSelectModeSheet(BuildContext context, List<Mode> modes) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Stack(
        children: [
          const SizedBox(
            height: 64,
            child: Center(
              child: Text("投注模式", style: TextStyle(fontSize: 36)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 64, 16, 32),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black),
              ),
              child: ListView.separated(
                itemCount: modes.length,
                itemBuilder: (BuildContext context, int index) {
                  final mode = modes[index];

                  return ListTile(
                    dense: true,
                    title: Row(
                      children: [
                        SizedBox(width: 36, child: Text("${index + 1}")),
                        Expanded(child: Text(mode.name)),
                        Expanded(
                            child:
                                Text(mode.total, textAlign: TextAlign.right)),
                      ],
                    ),
                    splashColor: Theme.of(context).primaryColor,
                    onTap: () => Navigator.pop(context, mode.id),
                  );
                },
                separatorBuilder: (context, index) => const Divider(height: 0),
              ),
            ),
          )
        ],
      );
    },
  );
}

class Mode {
  final String id;
  final String name;
  final String total;

  Mode(this.id, this.name, this.total);
}
