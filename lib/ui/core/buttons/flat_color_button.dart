import 'package:flutter/material.dart';

class FlatColorButton extends StatelessWidget {
  final Color color;
  final Function() onPressed;
  final String text;
  const FlatColorButton({Key? key, required this.onPressed, required this.text, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: color,
            fixedSize: const Size(200, 30),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            )),
        child: Text(text, style: const TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }
}
