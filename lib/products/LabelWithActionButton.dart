import 'package:flutter/material.dart';
import 'package:grocery/constants/ApplicationColor.dart';

// ignore: must_be_immutable
class LabelWithActionButton extends StatelessWidget {
  LabelWithActionButton({
    Key? key,
    EdgeInsets? padding,
    required this.title,
    required this.press,
  }) : super(key: key) {
    this.padding = padding ?? EdgeInsets.only(left: 0, top: 0);
  }

  final String title;
  final Function press;
  late EdgeInsets padding;

  factory LabelWithActionButton.fromJson(
      Map<String, dynamic> json, Function callback) {
    return new LabelWithActionButton(title: json['title'], press: callback);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                this.press(context);
              },
              child: Icon(Icons.arrow_back_ios_new, size: 32)),
          Text(
            this.title,
            style: TextStyle(
                fontSize: 22,
                color: ApplicationColor.blackHint,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
