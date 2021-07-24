import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Category(
            category: 'All',
            iconUrl: null,
          ),
          Category(
            category: 'Vegetables',
            iconUrl: 'images/icons/vegetables.png',
          ),
          Category(
            category: 'Fish',
            iconUrl: 'images/icons/fish.png',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  Category({Key? key, required this.category, String? iconUrl})
      : super(key: key) {
    this.iconUrl = iconUrl;
  }
  final String category;
  String? iconUrl;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding / 2),
        margin: EdgeInsets.only(left: kDefaultPadding / 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: kNaturanWhite),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(right: kDefaultPadding / 2),
                child: this.iconUrl != null
                    ? Image.asset(this.iconUrl.toString())
                    : null),
            Text(
              this.category,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black38,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
