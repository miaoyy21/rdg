import 'package:flutter/material.dart';

class TextFieldBox extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;

  const TextFieldBox(this.placeholder, this.controller);

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    final secondary = Theme.of(context).secondaryHeaderColor;

    return SizedBox(
      height: 36,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: primary),
          ),
          filled: true,
          fillColor: secondary,
          hintText: placeholder,
        ),
      ),
    );
  }
}
