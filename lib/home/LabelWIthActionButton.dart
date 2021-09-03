import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';

class LabelWithActionButton extends StatelessWidget {
  const LabelWithActionButton({
    Key? key,
    required this.title,
    required this.actionButtonTitle,
    required this.press,
  }) : super(key: key);

  final String title;
  final String actionButtonTitle;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            this.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
              onTap: this.press,
              child: Text(this.actionButtonTitle.toUpperCase()))
        ],
      ),
    );
  }
}
