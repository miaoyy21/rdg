import 'package:flutter/material.dart';

@immutable
class RectangleCircleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final OutlinedBorder? border;
  final EdgeInsetsGeometry? margin;
  final double? fontSize;
  final double? width;
  final double? height;

  const RectangleCircleButton({
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
    final Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    late Color secondaryColor = Theme.of(context).secondaryHeaderColor;
    late Color textColor = Colors.black;

    // 是否禁用
    if (onPressed == null) {
      secondaryColor = Theme.of(context).scaffoldBackgroundColor;
      textColor = Colors.black54;
    }

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
        elevation: MaterialStateProperty.all(4),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: textColor),
        ),
      ),
      child: Text(
        text!,
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
