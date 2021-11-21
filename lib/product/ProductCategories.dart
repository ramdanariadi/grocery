import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ProductCategories extends StatelessWidget {
  ProductCategories({
    Key? key,
  }) : super(key: key);

  late Future<List<ProductCategory>> categoryFuture;

  Future<List<ProductCategory>> fetchCategories() async {
    final response = await http.get(Uri.parse("$HTTPBASEURL/category"));
    if (response.statusCode == 200) {
      List<dynamic> listCategory = jsonDecode(response.body)['response'];
      List<ProductCategory> productCategories = listCategory
          .map((e) => ProductCategory.fromJson(e,
                  (String categoryId, String title, BuildContext context) {
                Navigator.pushNamed(context, ProductGroupGridItems.routeName,
                    arguments: ProductGroupGridItemsArgs(
                        title: title, categoryId: categoryId));
              }))
          .toList();
      return productCategories;
    } else {
      Fluttertoast.showToast(
          msg: "Failed load category", toastLength: Toast.LENGTH_LONG);
    }
    return List<ProductCategory>.empty();
  }

  @override
  Widget build(BuildContext context) {
    categoryFuture = this.fetchCategories();
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder<List<ProductCategory>>(
          future: categoryFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                children: snapshot.data!,
              );
            }

            if (snapshot.hasError) {
              return Text("Failed load category");
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

// ignore: must_be_immutable
class ProductCategory extends StatelessWidget {
  ProductCategory({
    Key? key,
    String? imageUrl,
    required this.id,
    required this.title,
    required this.onTap,
  }) : super(key: key) {
    this.imageUrl = imageUrl;
  }

  factory ProductCategory.fromJson(Map<String, dynamic> json, Function onTap) {
    return new ProductCategory(
      id: json['id'],
      title: json['category'],
      onTap: onTap,
      imageUrl: json['imageUrl'],
    );
  }

  String? imageUrl;
  final String title;
  final String id;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: GestureDetector(
        onTap: () {
          this.onTap(this.id, this.title, context);
        },
        child: Container(
          margin:
              EdgeInsets.only(left: kDefaultPadding, bottom: kDefaultPadding),
          padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              top: kDefaultPadding / 2,
              bottom: kDefaultPadding / 2),
          decoration: BoxDecoration(
              color: kNaturanWhite,
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    offset: Offset(0, 2),
                    color: kShadownColor.withOpacity(0.12),
                    spreadRadius: 0)
              ],
              borderRadius: BorderRadius.circular(40)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  child: this.imageUrl != null
                      ? Image.network(this.imageUrl.toString())
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
