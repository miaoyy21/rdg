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
    this.fontSize = 18,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final secondaryColor = Theme.of(context).secondaryHeaderColor;
    final textColor = Colors.black;

    final MaterialStateProperty<OutlinedBorder?> shape;
    if (border is RoundedRectangleBorder) {
      shape = MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
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
        backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        foregroundColor: MaterialStateProperty.all<Color>(backgroundColor),
        overlayColor: MaterialStateProperty.all<Color>(secondaryColor),
        shadowColor: MaterialStateProperty.all<Color>(backgroundColor),
        surfaceTintColor: MaterialStateProperty.all<Color>(backgroundColor),
        elevation: MaterialStateProperty.all(8),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: textColor, width: 2),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
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
