import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding),
        margin: EdgeInsets.all(kDefaultPadding * 0.8),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 8),
                  blurRadius: 10,
                  color: kShadownColor.withOpacity(0.23),
                  spreadRadius: 0)
            ],
            borderRadius: BorderRadius.circular(kDefaultPadding * 5)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(
              onTap: () {}, child: Image.asset("images/icons/Home.png")),
          GestureDetector(
              onTap: () {}, child: Image.asset("images/icons/Category.png")),
          GestureDetector(
              onTap: () {}, child: Image.asset("images/icons/UserOutline.png")),
          GestureDetector(
              onTap: () {},
              child: Image.asset("images/icons/ShoppingCartOutline.png"))
        ]),
      ),
    );
  }
}
