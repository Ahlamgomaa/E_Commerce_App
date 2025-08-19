import 'package:flutter/material.dart';

class IconButtonApp extends StatelessWidget {
  final Icon icon;
  final void Function() onPressed;

  const IconButtonApp({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButtonApp(icon: icon, onPressed: onPressed);
  }
}