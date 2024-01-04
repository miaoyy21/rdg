import 'package:flutter/material.dart';

@immutable
class RectangleCircleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final OutlinedBorder? border;
  final double? elevation;

  final EdgeInsetsGeometry? margin;
  final double? fontSize;
  final double? width;
  final double? height;

  const RectangleCircleButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.border = const RoundedRectangleBorder(),
    this.elevation = 4,
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
    } else if (label.contains("删除")) {
      primary = Colors.red;
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
    final text = Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        color: primary,
        fontWeight: FontWeight.bold,
      ),
    );

    final button = ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(shape),
        backgroundColor: MaterialStateProperty.all(background),
        foregroundColor: MaterialStateProperty.all(background),
        overlayColor: MaterialStateProperty.all(secondary),
        shadowColor: MaterialStateProperty.all(primary),
        surfaceTintColor: MaterialStateProperty.all(background),
        elevation: MaterialStateProperty.all(elevation),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        side: MaterialStateProperty.all(side),
      ),
      child: Row(
        children: [
          Expanded(child: text),
          icon != null ? Icon(icon, color: primary) : SizedBox(),
        ],
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
