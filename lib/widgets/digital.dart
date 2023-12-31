import 'package:flutter/material.dart';

class Digital extends StatelessWidget {
  final int? digital;
  final double? fontSize;
  final double? width;
  final double? height;

  const Digital(this.digital,
      {super.key, this.fontSize = 20, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    Color secondary = Theme.of(context).secondaryHeaderColor;

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(
          "$digital",
          style: TextStyle(
            fontFamily: "Digital",
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}