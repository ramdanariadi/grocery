import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery/constrant.dart';

class LabelWithActionButton extends StatelessWidget {
  LabelWithActionButton({
    Key? key,
    EdgeInsets? padding,
    required this.title,
    required this.press,
  }) : super(key: key) {
    this.padding = padding;
  }

  final String title;
  final Function press;
  EdgeInsets? padding;

  factory LabelWithActionButton.fromJson(
      Map<String, dynamic> json, Function callback) {
    return new LabelWithActionButton(title: json['title'], press: callback);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: padding ??
          EdgeInsets.only(left: kDefaultPadding, top: kDefaultPadding * 1.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              this.press(context);
            },
            child: SvgPicture.asset(
              'images/icons/ChevronLeftOutline.svg',
              height: size.width / 11,
              width: size.width / 11,
            ),
          ),
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
