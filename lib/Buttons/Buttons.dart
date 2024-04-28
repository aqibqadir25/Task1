import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double minWidth;
  final double height;
  final BorderRadius borderRadius;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.black,
    this.minWidth = double.infinity,
    this.height = 55.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(32.0)),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Material(
        color: color,
        borderRadius: borderRadius,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: minWidth,
          height: height,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
