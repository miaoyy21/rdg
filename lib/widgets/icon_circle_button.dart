import 'package:flutter/material.dart';

class IconCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const IconCircleButton(this.icon, {super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    late Color primary = Theme.of(context).primaryColor;
    late Color secondary = Theme.of(context).secondaryHeaderColor;

    // 是否禁用
    if (onPressed == null) {
      primary = Colors.black54;
      secondary = Theme.of(context).scaffoldBackgroundColor;
    }

    final side = BorderSide(color: primary, width: 2);

    return IconButton.outlined(
      icon: Icon(icon),
      color: primary,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(secondary),
        // shadowColor: MaterialStateProperty.all<Color>(primary),
        side: MaterialStateProperty.all<BorderSide>(side),
        elevation: MaterialStateProperty.all(1),
      ),
      onPressed: onPressed,
    );
  }
}
