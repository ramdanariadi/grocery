import 'package:flutter/material.dart';

import '../constrant.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  Button({
    Key? key,
    EdgeInsets? margin,
    EdgeInsets? padding,
    Color? color,
    TextStyle? textStyle,
    Widget? child,
    String? text,
    required this.width,
    required this.height,
    required this.onTap,
  }) : super(key: key) {
    this.margin = margin;
    this.padding = padding;
    this.child = child;
    this.text = text;
    this.color = color;
  }

  final double width;
  final double height;
  final Function onTap;
  String? text;
  Widget? child;
  EdgeInsets? margin;
  EdgeInsets? padding;
  Color? color;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin ?? EdgeInsets.all(10),
      width: this.width,
      height: this.height,
      child: TextButton(
        style: TextButton.styleFrom(
            padding: this.padding ?? EdgeInsets.all(10),
            backgroundColor: this.color ?? kPrimaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: this.child ??
            Text(
              this.text ?? 'Button',
              style: textStyle ??
                  TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w200),
            ),
        onPressed: () {
          this.onTap();
        },
      ),
    );
  }
}
