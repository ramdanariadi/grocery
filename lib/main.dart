import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/chart/Cart.dart';
import 'package:grocery/custom_widget/ScaffoldBottomActionBar.dart';
import 'package:grocery/home/Home.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/profile/MyAccount.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

late SharedPreferences sharedPreferences;

class MyApp extends StatelessWidget {
  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    init();
    final GlobalKey<NavigatorState>_rootNavigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routerConfig: GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: Home.routeName,
        routes: [
        ShellRoute(
          builder: (context, state, child) => ScaffoldBottomActionBar(child: child,),
          routes: [
            GoRoute(path: Home.routeName, builder: (context, state) => Home()),
            GoRoute(path: Products.routeName, builder: (context, state) => Products()),
            GoRoute(path: Cart.routeName, builder: (context, state) => Cart()),
            GoRoute(path: MyAccount.routeName, builder: (context, state) => MyAccount())
          ]
        )
      ])
    );
  }
}