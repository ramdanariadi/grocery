import 'package:flutter/material.dart';
import 'package:grocery/constants/ApplicationColor.dart';

class Skeleton extends StatelessWidget {
  Skeleton(
      {Key? key,
      required this.widht,
      required this.height,
      BorderRadius? borderRadius})
      : this.borderRadius = borderRadius ?? BorderRadius.circular(8),
        super(key: key);

  final double widht;
  final double height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widht,
        height: height,
        decoration: BoxDecoration(
            color: ApplicationColor.shadowColor.withOpacity(0.8),
            borderRadius: borderRadius));
  }
}
