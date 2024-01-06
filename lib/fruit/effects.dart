import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'categories.dart';
import 'fruit.dart';

enum Effects {
  invalid,
  songDeng,
  daSanYuan,
  xiaoSanYuan,
  daSiXi,
  zengHengSiHai,
  xianNvSanHua,
  tianLongBaBu,
  jiuBaoLianDeng,
  kaiHuoChe,
  daManGuan
}

extension EffectsExtension on Effects {
  String? get name => {
        Effects.invalid: "无",
        Effects.songDeng: "送灯",
        Effects.daSanYuan: "大三元",
        Effects.xiaoSanYuan: "小三元",
        Effects.daSiXi: "大四喜",
        Effects.zengHengSiHai: "纵横四海",
        Effects.xianNvSanHua: "仙女散花",
        Effects.tianLongBaBu: "天龙八部",
        Effects.jiuBaoLianDeng: "九宝莲灯",
        Effects.kaiHuoChe: "开火车",
        Effects.daManGuan: "大满贯",
      }[this];

  List<int> getExtra(Effects effect) {
    // 从列表ds中随机n个不同奖项
    randFn(List<int> ds, int n) {
      if (ds.length < n) {
        throw FlutterError(
            "List size is ${ds.length} less than target size $n");
      }

      final nds = List.of(ds);
      return List.generate(n, (_) {
        final t = nds[Random().nextInt(nds.length)];

        nds.remove(t);
        return t;
      });
    }

    // 取消【龙王：🐲】和【糖果：🍬】
    final fs = fruits
        .where((f) =>
            f.category != Categories.king && f.category != Categories.candy)
        .toList();

    // 计算额外
    switch (effect) {
      case Effects.invalid:
        return [];
      case Effects.songDeng:
        // 送灯：随机选择1个～3个
        final n = Random().nextInt(3);
        return randFn(fs.map((f) => f.index).toList(), n);
      case Effects.daSanYuan:
        // 大三元：固定3个大奖：大🍉、大🥗，大🍔
        return [13, 35, 45];
      case Effects.xiaoSanYuan:
        // 小三元：固定3个小奖：大🍊、大🫐，大🍇
        final fs1 = fs
            .where((f) => f.category == Categories.orange && f.isLarge)
            .toList();
        final fs2 = fs
            .where((f) => f.category == Categories.blueberry && f.isLarge)
            .toList();
        final fs3 = fs
            .where((f) => f.category == Categories.grape && f.isLarge)
            .toList();

        return [
          randFn(fs1.map((f) => f.index).toList(), 1).first,
          randFn(fs2.map((f) => f.index).toList(), 1).first,
          randFn(fs3.map((f) => f.index).toList(), 1).first,
        ];
      case Effects.daSiXi:
        // 大四喜：固定4个大🍎
        return [4, 34, 44, 14];
      case Effects.zengHengSiHai:
        // 纵横四号：随机选择4个
        return randFn(fs.map((f) => f.index).toList(), 4);
      case Effects.xianNvSanHua:
        // 仙女散花：随机选择3个～5个
        final n = Random().nextInt(3) + 3;
        return randFn(fs.map((f) => f.index).toList(), n);
      case Effects.tianLongBaBu:
        // 天龙八部：随机选择8个
        return randFn(fs.map((f) => f.index).toList(), 8);
      case Effects.jiuBaoLianDeng:
        // 九宝莲灯：随机选择9个
        return randFn(fs.map((f) => f.index).toList(), 9);
      case Effects.kaiHuoChe:
        // 开火车：随机选择连续的3个～5个
        final n = 3 + Random().nextInt(3);

        final fs1 = [14, 7, 0, 1];
        final fs2 = [4, 5, 6, 13, 20];
        final fs3 = [34, 41, 48, 47, 46, 45, 44, 43, 42, 35, 28];

        final int start;
        if (n == 5) {
          start = randFn([4, 34, 41, 48, 47, 46, 45, 44], 1).first;
        } else if (n == 4) {
          start = randFn([14, 4, 5, 34, 41, 48, 47, 46, 45, 44, 43], 1).first;
        } else {
          start =
              randFn([14, 7, 4, 5, 6, 34, 41, 48, 47, 46, 45, 44, 43, 42], 1)
                  .first;
        }

        if (fs1.contains(start)) {
          final index = fs1.indexOf(start);
          return fs1.getRange(index, index + n).toList();
        } else if (fs2.contains(start)) {
          final index = fs2.indexOf(start);
          return fs2.getRange(index, index + n).toList();
        } else {
          final index = fs3.indexOf(start);
          return fs3.getRange(index, index + n).toList();
        }
      case Effects.daManGuan:
        // [0,4]
        final extra = [4, 5, 6, 13, 20];

        // [5]：随机1个
        extra.add(randFn(fs.map((f) => f.index).toList(), 1).first);

        // [6,16]
        extra.addAll([34, 41, 48, 47, 46, 45, 44, 43, 42, 35, 28]);

        // [17]：随机1个
        extra.add(randFn(fs.map((f) => f.index).toList(), 1).first);

        // [18,23]
        extra.addAll([14, 7, 0, 1, 2, 3]);

        return extra;
      default:
        return [];
    }
  }
}
