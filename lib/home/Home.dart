import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/home/LabelWithActionButton.dart';
import 'package:grocery/home/Profile.dart';
import 'package:grocery/home/SearchBar.dart';
import 'package:grocery/product/ProductCategories.dart';
import 'package:grocery/product/RecomendationProducts.dart';
import 'package:grocery/product/TopProducts.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';
import 'package:grocery/products/Products.dart';

enum BottomIcons { Home, Favorite, Search, Account }

class Home extends StatelessWidget {
  static final String routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: Application.defaultPadding / 100,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Profile(),
              SearchBar(),
              ProductCategories(),
              LabelWithActionButton(
                title: "Top Products",
                actionButtonTitle: "SHOW ALL",
                press: () {
                  GoRouter.of(context).push(Products.routeName + "/" + ProductGroupGridItems.routeName, extra: {
                    'title': 'Top Products',
                    'url': Application.httBaseUrl + '/product/top'});
                },
              ),
              TopProducts(),
              LabelWithActionButton(
                title: "Recommendation",
                actionButtonTitle: "SHOW ALL",
                press: () {
                    GoRouter.of(context).push(Products.routeName + "/" + ProductGroupGridItems.routeName, extra: {
                    'title': 'Recommendation',
                    'url': Application.httBaseUrl + '/product/recommended'});
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
    );
  }
}
