import 'package:flutter/material.dart';
import 'package:grocery/chart/Cart.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/home/Home.dart';
import 'package:grocery/SearchPage/SearchPage.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/product/ProductDetail.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/profile/Login.dart';
import 'package:grocery/profile/MyAccount.dart';
import 'package:grocery/profile/Register.dart';
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
    MyApp.init();
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: Home.routeName,
      onGenerateRoute: (setting) {
        if (setting.name == Home.routeName) {
          return MaterialPageRoute(builder: (context) => Home());
        }

        if (setting.name == Login.routeName) {
          return MaterialPageRoute(builder: (context) => Login());
        }

        if (setting.name == Register.routeName) {
          return MaterialPageRoute(builder: (context) => Register());
        }

        if (setting.name == SearchPage.routeName) {
          return CustomPageRoute(child: SearchPage(), transitionDuration: 500);
        }

        if (setting.name == ProductDetail.routeName) {
          final args = setting.arguments as ProductArguments;
          return CustomPageRoute(
              child: ProductDetail(
                  tag: args.tag,
                  id: args.id,
                  merk: args.merk,
                  category: args.category,
                  price: args.price,
                  weight: args.weight,
                  imageUrl: args.imageUrl));
        }

        if (setting.name == Cart.routeName) {
          return MaterialPageRoute(builder: (context) => Cart());
        }

        if (setting.name == Products.routeName) {
          return MaterialPageRoute(builder: (context) => Products());
        }

        if (setting.name == ProductGroupGridItems.routeName) {
          final args = setting.arguments as ProductGroupGridItemsArgs;
          return MaterialPageRoute(
              builder: (context) => args.url == null
                  ? ProductGroupGridItems(
                      title: args.title, categoryId: args.categoryId)
                  : ProductGroupGridItems.customUrl(args.title, args.url));
        }

        if (setting.name == MyAccount.routeName) {
          if (!(sharedPreferences.getBool("authenticated") ?? false)) {
            return MaterialPageRoute(builder: (context) => Login());
          }
          return CustomPageRoute(child: MyAccount());
        }

        assert(false, 'need to implement ${setting.name}');
        return null;
      },
    );
  }
}

class CustomPageRoute<T> extends PageRoute<T> {
  CustomPageRoute({required this.child, int transitionDuration = 0}) {
    this.duration = transitionDuration;
  }
  final Widget child;
  late int duration;

  @override
  Color? get barrierColor => kBlackHint;

  @override
  String? get barrierLabel => '';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(opacity: animation, child: this.child);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: duration);
}
