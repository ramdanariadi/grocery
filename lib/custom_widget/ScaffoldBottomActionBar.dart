import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/chart/Cart.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/FloatingBottomNavigationBar.dart';
import 'package:grocery/home/Home.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/profile/Login.dart';
import 'package:grocery/profile/MyAccount.dart';
import 'package:grocery/services/UserService.dart';
import 'package:grocery/state_manager/CartState.dart';
import 'package:grocery/state_manager/DataState.dart';
import 'package:grocery/state_manager/RouterState.dart';

class ScaffoldBottomActionBar extends StatelessWidget {
  ScaffoldBottomActionBar({Key? key, required this.child}) : super(key: key);

  final Widget child;
  final DataState<double> totalState = DataState(0);
  static final Map<String, FloatingBottomNavigationBarItem> navbarItems = {
    Home.routeName: FloatingBottomNavigationBarItem(iconData: Icons.home),
    Products.routeName:
        FloatingBottomNavigationBarItem(iconData: Icons.grid_view_rounded),
    Cart.routeName: FloatingBottomNavigationBarItem(
        iconData: Icons.shopping_bag,
        badges: BlocBuilder<CartState, int>(
          builder: (context, data) {
            return Text(
              "${data}",
              style:
                  TextStyle(fontSize: 10, color: ApplicationColor.naturalWhite),
            );
          },
        )),
    MyAccount.routeName:
        FloatingBottomNavigationBarItem(iconData: Icons.account_circle_outlined)
  };

  @override
  Widget build(BuildContext context) {
    RouterState activeNavbarState = BlocProvider.of<RouterState>(context);
    return BlocBuilder<RouterState, int>(
      builder: (context, _activeNavbar) {
        return Scaffold(
            body: child,
            bottomNavigationBar: FloatingBottomNavigationBar(
                currentIndex: _activeNavbar,
                items: navbarItems.values.toList(),
                selectedItemColor: ApplicationColor.primaryColor,
                unselectedItemColor: ApplicationColor.iconOutlineColor,
                onTap: (value) async {
                  activeNavbarState.add(value);

                  switch (value) {
                    case 0:
                      GoRouter.of(context).go(Home.routeName);
                      break;
                    case 1:
                      GoRouter.of(context).go(Products.routeName);
                      break;
                    case 2:
                    case 3:
                      if (!await UserService.isAuthenticated()) {
                        GoRouter.of(context).go(Login.routeName);
                        break;
                      }

                      if (value == 2) {
                        GoRouter.of(context).go(Cart.routeName);
                        break;
                      }

                      GoRouter.of(context).go(MyAccount.routeName);
                      break;
                  }
                }));
      },
    );
  }
}
