import 'package:flutter/material.dart';

import '../constrant.dart';

class Button extends StatelessWidget {
  Button({
    Key? key,
    EdgeInsets? this.margin,
    EdgeInsets? this.padding,
    Color? this.color,
    TextStyle? this.textStyle,
    required this.text,
    required this.width,
    required this.height,
    required this.callback,
  }) : super(key: key) {
    this.margin = margin;
    this.padding = padding;
  }

  final String text;
  final double width;
  final double height;
  final Function callback;
  EdgeInsets? margin;
  EdgeInsets? padding;
  Color? color;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: margin ?? EdgeInsets.all(10),
        width: this.width,
        height: this.height,
        padding: padding ?? EdgeInsets.all(10),
        child: Center(
          child: Text(
            this.text,
            style: textStyle ??
                TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w200),
          ),
        ),
        decoration: BoxDecoration(
            color: color ?? kPrimaryColor,
            borderRadius: BorderRadius.circular(8)),
      ),
      onTap: () {
        this.callback();
      },
    );
  }
}
