import 'package:flutter/material.dart';
import 'package:grocery/chart/Chart.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/home/Home.dart';
import 'package:grocery/SearchPage/SearchPage.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/product/ProductDetail.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/profile/Profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: Home.routeName,
      routes: {
        '/': (context) => Home(),
      },
      onGenerateRoute: (setting) {
        if (setting.name == SearchPage.routeName) {
          final args = setting.arguments as SearchBarArgs;
          return CustomPageRoute(
              child: SearchPage(
                search: args.search,
              ),
              transitionDuration: 500);
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

        if (setting.name == Chart.routeName) {
          return MaterialPageRoute(builder: (context) => Chart());
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

        if (setting.name == Profile.routeName) {
          return MaterialPageRoute(builder: (context) => Profile());
        }

        assert(false, 'need to implement ${setting.name}');
        return null;
      },
    );
  }
}

class CustomPageRoute<T> extends PageRoute<T> {
  CustomPageRoute({required this.child, int? transitionDuration}) {
    this.duration = transitionDuration;
  }
  final Widget child;
  int? duration;

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
  Duration get transitionDuration => Duration(milliseconds: duration ?? 1000);
}
