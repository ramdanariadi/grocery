import 'package:flutter/material.dart';
import 'package:grocery/chart/Chart.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/home/Home.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';
import 'package:grocery/products/Products.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key, required String this.active}) : super(key: key);

  final String active;
  final home = [Home.routeName];
  final product = [Products.routeName,ProductGroupGridItems.routeName];

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
              onTap: () {
                Navigator.pushNamed(context, Home.routeName);
              },
              child: home.contains(active)
                  ? Image.asset("images/icons/HomeActive.png")
                  : Image.asset("images/icons/Home.png")),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Products.routeName);
              },
              child: product.contains(active)
                  ? Image.asset("images/icons/CategoryActive.png")
                  : Image.asset("images/icons/Category.png")),
          GestureDetector(
              onTap: () {}, child: Image.asset("images/icons/User.png")),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Chart.routeName);
              },
              child: Image.asset("images/icons/Cart.png"))
        ]),
      ),
    );
  }
}
