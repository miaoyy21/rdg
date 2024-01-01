import 'package:flutter/material.dart';

@immutable
class RectangleCircleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? label;
  final OutlinedBorder? border;

  final EdgeInsetsGeometry? margin;
  final double? fontSize;
  final double? width;
  final double? height;

  const RectangleCircleButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.border = const RoundedRectangleBorder(),
    this.margin = const EdgeInsets.symmetric(horizontal: 4),
    this.fontSize = 18,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    late Color primary = Theme.of(context).primaryColor;
    late Color secondary = Theme.of(context).secondaryHeaderColor;
    final Color background = Theme.of(context).scaffoldBackgroundColor;

    // 是否禁用
    if (onPressed == null) {
      primary = Colors.black54;
      secondary = Theme.of(context).scaffoldBackgroundColor;
    }

    final OutlinedBorder? shape;
    if (border is RoundedRectangleBorder) {
      shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0));
    } else if (border is CircleBorder) {
      shape = const CircleBorder();
    } else {
      throw Exception("unexpected type of ${border.runtimeType}");
    }

    final side = BorderSide(color: primary, width: 2);

    final button = ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(shape),
        backgroundColor: MaterialStateProperty.all(background),
        foregroundColor: MaterialStateProperty.all(background),
        overlayColor: MaterialStateProperty.all(secondary),
        shadowColor: MaterialStateProperty.all(primary),
        surfaceTintColor: MaterialStateProperty.all(background),
        elevation: MaterialStateProperty.all(4),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        side: MaterialStateProperty.all(side),
      ),
      child: Text(
        label!,
        style: TextStyle(
          fontSize: fontSize,
          color: primary,
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
