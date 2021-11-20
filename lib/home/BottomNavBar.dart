import 'package:flutter/material.dart';
import 'package:grocery/chart/Cart.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/home/Home.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/profile/MyAccount.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key, required this.active}) : super(key: key);

  final String active;
  final home = [Home.routeName];
  final product = [Products.routeName, ProductGroupGridItems.routeName];
  final profile = [MyAccount.routeName];

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
          InkWell(
              onTap: () {
                if (ModalRoute.of(context)!.settings.name != Home.routeName)
                  Navigator.popAndPushNamed(context, Home.routeName);
              },
              child: Icon(Icons.home,
                  size: 32,
                  color: home.contains(active)
                      ? kPrimaryColor
                      : kIconOutlineColor)),
          GestureDetector(
              onTap: () {
                if (ModalRoute.of(context)!.settings.name != Products.routeName)
                  Navigator.popAndPushNamed(context, Products.routeName);
              },
              child: Icon(
                Icons.grid_view_rounded,
                size: 32,
                color: product.contains(active)
                    ? kPrimaryColor
                    : kIconOutlineColor,
              )),
          GestureDetector(
              onTap: () {
                if (ModalRoute.of(context)!.settings.name != Cart.routeName)
                  Navigator.popAndPushNamed(context, Cart.routeName);
              },
              child: Icon(
                Icons.shopping_bag,
                size: 32,
                color: kIconOutlineColor,
              )),
          GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, MyAccount.routeName);
              },
              child: Icon(
                Icons.account_circle_outlined,
                size: 32,
                color: profile.contains(active)
                    ? kPrimaryColor
                    : kIconOutlineColor,
              ))
        ]),
      ),
    );
  }
}
