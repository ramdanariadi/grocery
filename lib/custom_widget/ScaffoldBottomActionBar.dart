
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/chart/Cart.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/home/Home.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/profile/MyAccount.dart';

class ScaffoldBottomActionBar extends StatefulWidget {
  const ScaffoldBottomActionBar({
    Key? key,
    required this.child
  }) : super(key: key);

  final Widget child;

  @override
  State<ScaffoldBottomActionBar> createState() => _ScaffoldBottomActionBarState();
}

class _ScaffoldBottomActionBarState extends State<ScaffoldBottomActionBar> {
  int _activeNavbar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: widget.child, bottomNavigationBar: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: "Product"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: "Profile")
      ],
      currentIndex: _activeNavbar,
      selectedItemColor: ApplicationColor.primaryColor,
      unselectedItemColor: ApplicationColor.iconOutlineColor,
      onTap: (value) {
        setState(() {
          _activeNavbar = value;
        });
        switch (value){
          case 0 : 
            GoRouter.of(context).go(Home.routeName);
            // Navigator.pushNamed(context, Home.routeName);
          break;
          case 1 : 
            GoRouter.of(context).go(Products.routeName);
            // Navigator.pushNamed(context, Products.routeName);
          break;
          case 2 :
            GoRouter.of(context).go(Cart.routeName);
          break;
          case 3 :
            GoRouter.of(context).go(MyAccount.routeName);
          break;
        }
      },),
    );
  }
}
