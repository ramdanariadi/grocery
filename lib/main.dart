import 'package:flutter/material.dart';
import 'package:grocery/chart/Chart.dart';
import 'package:grocery/home/Home.dart';
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
        if (setting.name == ProductDetail.routeName) {
          final args = setting.arguments as ProductArguments;

          return MaterialPageRoute(
              builder: (context) => ProductDetail(
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
              builder: (context) => ProductGroupGridItems(
                  title: args.title, categoryId: args.categoryId));
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
