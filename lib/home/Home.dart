import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/home/LabelWithActionButton.dart';
import 'package:grocery/home/Profile.dart';
import 'package:grocery/product/ProductCategories.dart';
import 'package:grocery/product/RecomendationProducts.dart';
import 'package:grocery/product/TopProducts.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/home/SearchBar.dart' as MySearchBar;
import 'package:grocery/state_manager/RouterState.dart';

enum BottomIcons { Home, Favorite, Search, Account }

class Home extends StatelessWidget {
  static final String routeName = '/';
  @override
  Widget build(BuildContext context) {
    RouterState routerState = BlocProvider.of<RouterState>(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Profile(),
                MySearchBar.SearchBar(),
                ProductCategories(),
                LabelWithActionButton(
                  title: "Top Products",
                  actionButtonTitle: "SHOW ALL",
                  press: () {
                    routerState.go(
                        context: context,
                        baseRoute: Products.routeName,
                        path: ProductGroupGridItems.routeName,
                        extra: {
                          'title': 'Top Products',
                          'url': Application.httBaseUrl +
                              '/product?pageIndex=0&pageSize=10&isTop=true'
                        });
                  },
                ),
                TopProducts(),
                LabelWithActionButton(
                  title: "Recommendation",
                  actionButtonTitle: "SHOW ALL",
                  press: () {
                    routerState.go(
                        context: context,
                        baseRoute: Products.routeName,
                        path: ProductGroupGridItems.routeName,
                        extra: {
                          'title': 'Recommendation',
                          'url': Application.httBaseUrl +
                              '/product?pageIndex=0&pageSize=10&isRecommendation=true'
                        });
                  },
                ),
                RecomendationProducts(),
                // SizedBox(
                //   height: size.height / 9,
                // )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
