import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/RetryButton.dart';
import 'package:grocery/home/LabelWithActionButton.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ProductGroupItems extends StatelessWidget {
  final String title;
  final String actionButtonTitle;
  final String categoryId;

  late Future<List<ProductCard>> productFuture;

  ProductGroupItems(
      {required this.title,
      required this.actionButtonTitle,
      required this.categoryId});

  factory ProductGroupItems.fromJson(Map<String, dynamic> json) {
    return new ProductGroupItems(
        title: json['category'],
        actionButtonTitle: 'SHOW ALL',
        categoryId: json['id']);
  }

  Future<List<ProductCard>> fetchProduct() async {
    final response = await HttpRequestService.sendRequest(method: HttpMethod.GET, url : Application.httBaseUrl + "/product/category/${this.categoryId}");
    if (response.statusCode == 200) {
      List<dynamic> responseList = jsonDecode(response.body)['data'];
      List<ProductCard> productList = responseList.map((e) => ProductCard.fromJson(e)).toList();
      return productList;
    } else {
      throw Exception("failed laod product by category");
    }
  }

  @override
  Widget build(BuildContext context) {
    productFuture = this.fetchProduct();
    return Column(
      children: [
        LabelWithActionButton(
            title: this.title,
            actionButtonTitle: this.actionButtonTitle,
            press: () {
              Navigator.pushNamed(context, ProductGroupGridItems.routeName,
                  arguments: new ProductGroupGridItemsArgs(
                      title: this.title, categoryId: this.categoryId));
            }),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder<List<ProductCard>>(
            future: productFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: snapshot.data!,
                );
              }

              if (snapshot.hasError) {
                return RetryButton(onTap: (){});
              }

              return Shimmer.fromColors(
                baseColor: ApplicationColor.shimmerBaseColor,
                highlightColor: ApplicationColor.shimmerHighlightColor,
                child: SingleChildScrollView(scrollDirection: Axis.horizontal,child: Row(children: [FakeProductCard(), FakeProductCard(), FakeProductCard()],)),);
            },
          ),
        )
      ],
    );
  }
}
