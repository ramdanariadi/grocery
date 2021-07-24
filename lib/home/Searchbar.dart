import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery/constrant.dart';

class Searchbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            alignment: Alignment.center,
            height: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: kNaturanWhite),
            width: size.width * 0.75,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: kBlackHint),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                SvgPicture.asset("images/icons/SearchOutline.svg")
              ],
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("images/icons/Adjustments.svg")),
        ],
      ),
    );
  }
}
