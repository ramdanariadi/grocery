import 'package:flutter/material.dart';
import 'package:grocery/constant.dart';
import 'package:grocery/home/BottomNavBar.dart';
import 'package:grocery/home/LabelWIthActionButton.dart';
import 'package:grocery/product/ProductCategories.dart';
import 'package:grocery/home/Profile.dart';
import 'package:grocery/product/RecomendationProducts.dart';
import 'package:grocery/product/TopProducts.dart';
import 'package:grocery/home/SearchBar.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';

enum BottomIcons { Home, Favorite, Search, Account }

class Home extends StatelessWidget {
  static final String routeName = '/';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: kDefaultPadding / 100,
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
                  Navigator.pushNamed(context, ProductGroupGridItems.routeName,
                      arguments: ProductGroupGridItemsArgs(
                          title: 'Top Products',
                          categoryId: '',
                          url: '$HTTP_BASE_URL/product/top'));
                },
              ),
              TopProducts(),
              LabelWithActionButton(
                title: "Recommendation",
                actionButtonTitle: "SHOW ALL",
                press: () {
                  Navigator.pushNamed(context, ProductGroupGridItems.routeName,
                      arguments: ProductGroupGridItemsArgs(
                          title: 'Recommendation',
                          categoryId: '',
                          url: '$HTTP_BASE_URL/product/recommendation'));
                },
              ),
              RecomendationProducts(),
              SizedBox(
                height: size.height / 9,
              )
            ],
          ),
        ),
        BottomNavBar(active: Home.routeName),
      ]),
    );
  }
}
