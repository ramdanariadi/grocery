import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/home/BottomNavBar.dart';
import 'package:grocery/home/ProductCategory.dart';
import 'package:grocery/home2/LabelWIthActionButton.dart';
import 'package:grocery/home2/ProductCategories.dart';
import 'package:grocery/home2/Profile.dart';
import 'package:grocery/home/RecomendationProduct.dart';
import 'package:grocery/home2/RecomendationProducts.dart';
import 'package:grocery/home/Searchbar.dart';
import 'package:grocery/home/TitleAndMoreButton.dart';
import 'package:grocery/home2/ProductCard.dart';
import 'package:grocery/home2/TopProducts.dart';
import 'package:grocery/home/WideProductCard.dart';
import 'package:grocery/home2/SearchBar.dart';

enum BottomIcons { Home, Favorite, Search, Account }

class Home extends StatelessWidget {
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
        BottomNavBar()
      ]),
    );
  }
}

class BodyBak extends StatelessWidget {
  const BodyBak({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Profile(),
            Searchbar(),
            // ProductCategory(),
            TitleAndMoreButton(
              title: 'Top Products',
              moreButtonTitle: 'show all',
              moreFunction: () {},
            ),
            TopProducts(),
            TitleAndMoreButton(
              title: 'Recomendation',
              moreButtonTitle: 'show all',
              moreFunction: () {},
            ),
            RecomendationProduct(),
            SizedBox(
              height: size.height / 9,
            )
          ],
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: BottomNavBar(),
      )
    ]);
  }
}
