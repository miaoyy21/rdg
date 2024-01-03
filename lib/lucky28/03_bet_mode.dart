import 'package:flutter/material.dart';

Future onBetMode(BuildContext context, List<String> modes) {
  return showModalBottomSheet(
    context: context,
    constraints: const BoxConstraints(maxHeight: 360),
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
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: ListView.separated(
                itemCount: modes.length,
                itemBuilder: (BuildContext context, int index) {
                  final mode = modes[index];

                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text("${index + 1}. $mode"),
                    splashColor: Theme.of(context).primaryColor,
                    onTap: () {
                      Navigator.pop(context, mode);
                    },
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
