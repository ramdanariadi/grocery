import 'package:flutter/material.dart';
import 'package:grocery/constant.dart';

class TitleAndMoreButton extends StatelessWidget {
  const TitleAndMoreButton({
    Key? key,
    required this.title,
    required this.moreButtonTitle,
    required this.moreFunction,
  }) : super(key: key);

  final String title;
  final String moreButtonTitle;
  final VoidCallback moreFunction;

  factory TitleAndMoreButton.fromJson(Map<String, dynamic> json, VoidCallback callback) {
    return new TitleAndMoreButton(
        title: json['title'],
        moreButtonTitle: json['moreButtonTitle'],
        moreFunction: callback);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: kDefaultPadding, left: kDefaultPadding, right: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: this.moreFunction,
            child: Text(
              moreButtonTitle.toUpperCase(),
              style: TextStyle(fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}
