import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';

// ignore: must_be_immutable
class LabelWithActionButton extends StatelessWidget {
  LabelWithActionButton({
    Key? key,
    EdgeInsets? padding,
    required this.title,
    required this.press,
  }) : super(key: key) {
    this.padding = padding ?? EdgeInsets.only(left: kDefaultPadding, top: kDefaultPadding * 1.5);
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
          Padding(
            padding: const EdgeInsets.only(right: kDefaultPadding),
            child: Text(
              this.title,
              style: TextStyle(
                  fontSize: 22, color: kBlackHint, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
