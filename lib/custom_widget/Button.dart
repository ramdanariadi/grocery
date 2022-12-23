import 'package:flutter/material.dart';
import 'package:grocery/constants/ApplicationColor.dart';

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
    BorderRadius? borderRadius,
    required this.width,
    required this.height,
    required this.onTap,
  }) : super(key: key) {
    this.margin = margin ?? EdgeInsets.all(0);
    this.padding = padding ?? EdgeInsets.all(10);
    this.text = text ?? 'Button';
    this.child = child ?? Text(
              this.text,
              style: textStyle ??
                  TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w200),
            );
    this.color = color ?? ApplicationColor.naturalWhite;
    this.borderRadius = borderRadius ?? BorderRadius.circular(8);
  }

  final double width;
  final double height;
  final Function onTap;
  late String text;
  late Widget child;
  late EdgeInsets margin;
  late EdgeInsets padding;
  late Color color;
  late TextStyle textStyle;
  late BorderRadius borderRadius;
  
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
            shape:
                RoundedRectangleBorder(borderRadius: borderRadius)),
        child: this.child,
        onPressed: () {
          this.onTap();
        },
      ),
    );
  }
}
