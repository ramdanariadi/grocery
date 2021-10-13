import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/home/BottomNavBar.dart';
import 'package:grocery/home/LabelWIthActionButton.dart';
import 'package:grocery/product/ProductCategories.dart';
import 'package:grocery/home/Profile.dart';
import 'package:grocery/product/RecomendationProducts.dart';
import 'package:grocery/product/TopProducts.dart';
import 'package:grocery/home/SearchBar.dart';

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
                press: () {},
              ),
              TopProducts(),
              LabelWithActionButton(
                title: "Recomendation",
                actionButtonTitle: "SHOW ALL",
                press: () {},
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
