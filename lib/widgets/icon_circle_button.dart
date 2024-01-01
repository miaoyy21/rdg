import 'package:flutter/material.dart';

class IconCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const IconCircleButton(this.icon, {super.key, this.onPressed});

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

    final side = BorderSide(color: primary, width: 2);

    return IconButton.outlined(
      icon: Icon(icon),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(background),
        foregroundColor: MaterialStateProperty.all(primary),
        overlayColor: MaterialStateProperty.all<Color>(secondary),
        shadowColor: MaterialStateProperty.all<Color>(primary),
        surfaceTintColor: MaterialStateProperty.all(background),
        elevation: MaterialStateProperty.all(4),
        side: MaterialStateProperty.all<BorderSide>(side),
      ),
      onPressed: onPressed,
    );
  }
}
