import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';

// ignore: must_be_immutable
class LabelWithActionButton extends StatelessWidget {
  LabelWithActionButton({
    Key? key,
    EdgeInsets? padding,
    required this.title,
    required this.actionButtonTitle,
    required this.press,
  }) : super(key: key) {
    this.padding = padding ?? EdgeInsets.symmetric(horizontal: Application.defaultPadding);
  }

  final String title;
  final String actionButtonTitle;
  final VoidCallback press;
  late EdgeInsets padding;

  factory LabelWithActionButton.fromJson(
      Map<String, dynamic> json, VoidCallback callback) {
    return new LabelWithActionButton(
        title: json['title'],
        actionButtonTitle: json['actionButtonTitle'],
        press: callback);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            this.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          TextButton(
              onPressed: this.press,
              child: Text(
                this.actionButtonTitle.toUpperCase(),
                style: TextStyle(color: ApplicationColor.shadowColor),
              ))
        ],
      ),
    );
  }
}
