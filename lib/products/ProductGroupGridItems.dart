import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/RetryButton.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/products/LabelWithActionButton.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ProductGroupGridItems extends StatelessWidget {
  static final routeName = 'allProductByCategory';

  final String title;
  final String url;

  Future<List<ProductCard>>? productFuture;

  ProductGroupGridItems({required this.url, required this.title});

  Future<List<ProductCard>> fetchProduct() async {
    final response = await HttpRequestService.sendRequest(
        method: HttpMethod.GET, url: this.url);
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            LabelWithActionButton(
                padding: EdgeInsets.symmetric(
                    horizontal: Application.defaultPadding * 0.8),
                title: this.title,
                press: (context) {
                  GoRouter.of(context).pop();
                }),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    top: Application.defaultPadding,
                    left: Application.defaultPadding * 0.8,
                    right: Application.defaultPadding * 0.8),
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
                      return RetryButton(onTap: () {});
                    }

                    return Shimmer.fromColors(
                      baseColor: ApplicationColor.shimmerBaseColor,
                      highlightColor: ApplicationColor.shimmerHighlightColor,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              FakeProductCard(),
                              FakeProductCard(),
                              FakeProductCard()
                            ],
                          )),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductGroupGridItemsArgs {
  final String title;
  final String url;

  ProductGroupGridItemsArgs({required this.url, required this.title});
}
