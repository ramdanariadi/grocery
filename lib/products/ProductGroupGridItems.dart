import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/RetryButton.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/product/dto/GetProduct.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/services/RestClient.dart';

class ProductGroupGridItems extends StatelessWidget {
  static final routeName = 'allProductByCategory';

  final String title;
  final String url;

  ProductGroupGridItems({required this.url, required this.title});

  Future<List<ProductCard>> fetchProduct(pageIndex) async {
    await Future.delayed(Duration(milliseconds: 1000));
    RestClient restClient = RestClient(await HttpRequestService.getDio());
    GetProductResponse response =
        await restClient.fetchProduct(GetProduct(pageIndex: 0, pageSize: 10));
    return response.data
        .map((e) => ProductCard(
              id: e.id,
              shopId: e.shopId,
              shopName: e.shopName,
              merk: e.name,
              category: e.category,
              weight: e.weight,
              price: e.price,
              imageUrl: e.imageUrl,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0),
          leading: InkWell(
            onTap: () {
              GoRouter.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 32,
              color: Colors.black,
            ),
          ),
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              this.title,
              style: TextStyle(
                  fontSize: 22,
                  color: ApplicationColor.blackHint,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Container(
            margin: EdgeInsets.only(
                left: Application.defaultPadding * 0.8,
                right: Application.defaultPadding * 0.8),
            child: PagewiseGridView<ProductCard>.count(
              pageSize: 10,
              shrinkWrap: false,
              addAutomaticKeepAlives: true,
              childAspectRatio: 0.9,
              mainAxisSpacing: Application.defaultPadding / 2,
              crossAxisCount: 2,
              loadingBuilder: (context) => FakeProductCard(),
              retryBuilder: (context, retryCallback) {
                return RetryButton(onTap: retryCallback);
              },
              itemBuilder: (context, entry, index) {
                return entry;
              },
              pageFuture: (pageIndex) => fetchProduct(pageIndex),
            )),
      ),
    );
  }
}

class ProductGroupGridItemsArgs {
  final String title;
  final String url;

  ProductGroupGridItemsArgs({required this.url, required this.title});
}
