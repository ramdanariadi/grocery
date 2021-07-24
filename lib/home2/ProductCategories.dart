
import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';

class ProductCategories extends StatelessWidget {
  const ProductCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ProductCategory(title: "All", onTap: () {}),
          ProductCategory(
            title: "Vegetables",
            imageUrl: "images/icons/vegetables.png",
            onTap: () {},
          ),
          ProductCategory(
            title: "Fish",
            imageUrl: "images/icons/fish.png",
            onTap: () {},
          ),
          ProductCategory(
            title: "Fastfood",
            imageUrl: "images/icons/FastFood.png",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ProductCategory extends StatelessWidget {
  ProductCategory({
    Key? key,
    String? imageUrl,
    required this.title,
    required this.onTap,
  }) : super(key: key) {
    this.imageUrl = imageUrl;
  }
  String? imageUrl;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: GestureDetector(
        onTap: this.onTap,
        child: Container(
          margin: EdgeInsets.only(left: kDefaultPadding),
          padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              top: kDefaultPadding / 2,
              bottom: kDefaultPadding / 2),
          decoration: BoxDecoration(
              color: kNaturanWhite, borderRadius: BorderRadius.circular(40)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  child: this.imageUrl != null
                      ? Image.asset(this.imageUrl.toString())
                      : null),
              SizedBox(
                width: this.imageUrl != null ? kDefaultPadding / 2 : 0,
              ),
              Text(this.title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal))
            ],
          ),
        ),
      ),
    );
  }
}
