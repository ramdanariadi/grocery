import 'package:flutter/material.dart';
import 'package:grocery/chart/Cart.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/home/Home.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/profile/MyAccount.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key, required this.activeRoute}) : super(key: key);

  final String activeRoute;
  final homeRoutes = [Home.routeName];
  final productRoutes = [Products.routeName, ProductGroupGridItems.routeName];
  final profileRoutes = [MyAccount.routeName];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(Application.defaultPadding),
        margin: EdgeInsets.all(Application.defaultPadding * 0.8),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 8),
                  blurRadius: 10,
                  color: ApplicationColor.shadowColor.withOpacity(0.23),
                  spreadRadius: 0)
            ],
            borderRadius: BorderRadius.circular(Application.defaultPadding * 5)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          InkWell(
              onTap: () {
                if (this.activeRoute != Home.routeName)
                  Navigator.pushNamed(context, Home.routeName);
              },
              child: Icon(Icons.home,
                  size: 32,
                  color: homeRoutes.contains(activeRoute)
                      ? ApplicationColor.primaryColor
                      : ApplicationColor.iconOutlineColor)),
          GestureDetector(
              onTap: () {
                if (this.activeRoute != Products.routeName)
                  Navigator.pushNamed(context, Products.routeName);
              },
              child: Icon(
                Icons.grid_view_rounded,
                size: 32,
                color: productRoutes.contains(activeRoute)
                    ? ApplicationColor.primaryColor
                    : ApplicationColor.iconOutlineColor,
              )),
          GestureDetector(
              onTap: () {
                if (this.activeRoute != Cart.routeName)
                  Navigator.pushNamed(context, Cart.routeName);
              },
              child: Icon(
                Icons.shopping_bag,
                size: 32,
                color: ApplicationColor.iconOutlineColor,
              )),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, MyAccount.routeName);
              },
              child: Icon(
                Icons.account_circle_outlined,
                size: 32,
                color: profileRoutes.contains(activeRoute)
                    ? ApplicationColor.primaryColor
                    : ApplicationColor.iconOutlineColor,
              ))
        ]),
      ),
    );
  }
}
