import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/RetryButton.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/products/LabelWithActionButton.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ProductGroupGridItems extends StatelessWidget {
  static final routeName = '/allProductByCategory';

  final String title;
  final String categoryId;
  late String url;

  Future<List<ProductCard>>? productFuture;

  ProductGroupGridItems(
      {String? url, required this.title, required this.categoryId}) {
    this.url = url ?? Application.httBaseUrl + "/product/category/${this.categoryId}";
  }

  factory ProductGroupGridItems.fromJson(Map<String, dynamic> json) {
    return new ProductGroupGridItems(
        title: json['category'], categoryId: json['id']);
  }

  factory ProductGroupGridItems.customUrl(String title, String? url) {
    return new ProductGroupGridItems(
      title: title,
      categoryId: '',
      url: url,
    );
  }

  Future<List<ProductCard>> fetchProduct() async {
    final response = await HttpRequestService.sendRequest(method: HttpMethod.GET, url: this.url);
    if (response.statusCode == 200) {
      List<dynamic> responseList = jsonDecode(response.body)['data'];
      List<ProductCard> productList = responseList
          .map((e) => ProductCard.fromJson(
                e,
                margin: Application.defaultPadding / 4,
              ))
          .toList();
      return productList;
    } else {
      debugPrint(response.statusCode.toString());
    }
    return List<ProductCard>.empty();
  }

  @override
  Widget build(BuildContext context) {
    productFuture = this.fetchProduct();
    return Scaffold(
      body: Stack(
        children: [
          LabelWithActionButton(
              title: this.title,
              press: (context) {
                Navigator.pop(context);
              }),
          Container(
            child: FutureBuilder<List<ProductCard>>(
              future: productFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) =>
                        snapshot.data![index],
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(1),
                    mainAxisSpacing: Application.defaultPadding / 2,
                    // crossAxisSpacing: Application.defaultPadding,
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
          ),
          // BottomNavBar(activeRoute: ProductGroupGridItems.routeName)
        ],
      ),
    );
  }
}

class ProductGroupGridItemsArgs {
  final String title;
  final String categoryId;
  String? url;

  ProductGroupGridItemsArgs(
      {String? url, required this.title, required this.categoryId}) {
    this.url = url;
  }
}
