import 'package:flutter/material.dart';

@immutable
class RectangleCircleButtonWithBorder extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final OutlinedBorder border;
  final EdgeInsetsGeometry margin;
  final double fontSize;
  double? width;
  double? height;

  RectangleCircleButtonWithBorder({
    super.key,
    required this.onPressed,
    required this.text,
    this.border = const RoundedRectangleBorder(),
    this.margin = const EdgeInsets.symmetric(horizontal: 4),
    this.fontSize = 16,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<OutlinedBorder?> shape;
    if (border is RoundedRectangleBorder) {
      shape = MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      );
    } else if (border is CircleBorder) {
      shape = MaterialStateProperty.all<CircleBorder>(
        const CircleBorder(),
      );
    } else {
      throw Exception("unexpected type of ${border.runtimeType}");
    }

    final button = ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: shape,
        backgroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.all(4),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(color: Colors.black, width: 2),
        ),
      ),
      child: Text(
        text,
        softWrap: false,
        style: TextStyle(fontSize: fontSize, color: Colors.black),
      ),
    );

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: button,
    );
  }
}
