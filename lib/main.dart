import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/alert/Alert.dart';
import 'package:grocery/chart/Cart.dart';
import 'package:grocery/custom_widget/ScaffoldBottomActionBar.dart';
import 'package:grocery/home/Home.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/product/ProductDetail.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/profile/Login.dart';
import 'package:grocery/profile/MyAccount.dart';
import 'package:grocery/services/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static Future init() async {
    UserService.isAuthenticated();
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
            /* Home route */
            GoRoute(path: Home.routeName, builder: (context, state) => Home()),
            /* Products route */
            GoRoute(path: Products.routeName, builder: (context, state) => Products(),
              routes: [
                GoRoute(path: ProductGroupGridItems.routeName, builder: (context, state) {
                  Map<String, dynamic> param = state.extra as Map<String, dynamic>;
                  return ProductGroupGridItems( title: param["title"]!, url: param["url"],);},),
                GoRoute(path: ProductDetail.routeName, builder: (context, state) {
                  ProductArguments arguments = state.extra as ProductArguments;
                  return ProductDetail(id: arguments.id, tag: arguments.tag, merk: arguments.merk, category: arguments.category, 
                    weight: arguments.weight, price: arguments.price, imageUrl: arguments.imageUrl,);
                },)
              ]
            ),
            /* Cart route */
            GoRoute(path: Cart.routeName, builder: (context, state) => Cart()),
            /* Profile route */
            GoRoute(path: MyAccount.routeName, builder: (context, state) => MyAccount()),
          ]
        ),
        /* Login router */
        GoRoute(path: Login.routeName, builder: (context, state) => Login()),
        /* Alert router */
        GoRoute(path: Alert.routeName, builder: (context, state) => state.extra as Alert),
      ])
    );
  }
}