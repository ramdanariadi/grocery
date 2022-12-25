
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/chart/Cart.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/FloatingBottomNavigationBar.dart';
import 'package:grocery/home/Home.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/profile/Login.dart';
import 'package:grocery/profile/MyAccount.dart';
import 'package:grocery/services/UserService.dart';

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
    return Scaffold(body: widget.child, bottomNavigationBar: FloatingBottomNavigationBar(
      currentIndex: _activeNavbar, 
      items: [
        FloatingBottomNavigationBarItem(iconData: Icons.home),
        FloatingBottomNavigationBarItem(iconData: Icons.grid_view_rounded),
        FloatingBottomNavigationBarItem(iconData: Icons.shopping_bag),
        FloatingBottomNavigationBarItem(iconData: Icons.account_circle_outlined)
      ],
      selectedItemColor: ApplicationColor.primaryColor,
      unselectedItemColor: ApplicationColor.iconOutlineColor,
      onTap: (value) async {
        setState(() {
          _activeNavbar = value;
        });

        switch(value){
            case 0:
              GoRouter.of(context).go(Home.routeName);
            break;
            case 1:
              GoRouter.of(context).go(Products.routeName);
            break;
            case 2:
            case 3:
              if(!await UserService.isAuthenticated()){
                GoRouter.of(context).go(Login.routeName);
                break;
              }
              
              if(value == 2){
                GoRouter.of(context).go(Cart.routeName);
                break;
              }

              GoRouter.of(context).go(MyAccount.routeName);
            break;
          }
      }
    ));
  }
}
