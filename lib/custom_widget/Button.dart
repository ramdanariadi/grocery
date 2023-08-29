import 'package:flutter/material.dart';
import 'package:grocery/constants/ApplicationColor.dart';

class Button extends StatelessWidget {
  Button({
    Key? key,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(10),
    this.color = ApplicationColor.naturalWhite,
    this.textStyle = const TextStyle(
        color: Colors.white, fontSize: 12, fontWeight: FontWeight.w200),
    this.text = 'Button',
    BorderRadius? borderRadius,
    Widget? child,
    required this.width,
    required this.height,
    required this.onTap,
  })  : this.child = child ?? Text(text, style: textStyle),
        this.borderRadius = borderRadius ?? BorderRadius.circular(8),
        super(key: key);

  final double width;
  final double height;
  final Function onTap;
  final String text;
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color color;
  final TextStyle textStyle;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      width: this.width,
      height: this.height,
      padding: this.padding,
      child: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: this.color,
            shape: RoundedRectangleBorder(borderRadius: borderRadius)),
        child: this.child,
        onPressed: () {
          this.onTap();
        },
      ),
    );
  }
}
