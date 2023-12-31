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
    final Color background = Theme.of(context).scaffoldBackgroundColor;
    late Color secondary = Theme.of(context).secondaryHeaderColor;
    late Color color = Colors.black;

    // 是否禁用
    if (onPressed == null) {
      secondary = Theme.of(context).scaffoldBackgroundColor;
      color = Colors.black54;
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
        backgroundColor: MaterialStateProperty.all<Color>(background),
        foregroundColor: MaterialStateProperty.all<Color>(background),
        overlayColor: MaterialStateProperty.all<Color>(secondary),
        shadowColor: MaterialStateProperty.all<Color>(background),
        surfaceTintColor: MaterialStateProperty.all<Color>(background),
        elevation: MaterialStateProperty.all(4),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(color: color),
        ),
      ),
      child: Text(
        text!,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
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
