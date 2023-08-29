import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/RetryButton.dart';
import 'package:grocery/home/LabelWithActionButton.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/product/dto/GetProduct.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/services/RestClient.dart';
import 'package:shimmer/shimmer.dart';

class ProductGroupItems extends StatelessWidget {
  final String title;
  final String actionButtonTitle;
  final String categoryId;

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
    debugPrint('categoryId : $categoryId');
    RestClient restClient = RestClient(await HttpRequestService.getDio());
    GetProductResponse response = await restClient.fetchProduct(
        GetProduct(pageIndex: 0, pageSize: 10, categoryId: categoryId));
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
    return Column(
      children: [
        LabelWithActionButton(
            title: this.title,
            actionButtonTitle: this.actionButtonTitle,
            press: () {
              debugPrint('categoryId : $categoryId');
              GoRouter.of(context).go(
                  Products.routeName + "/" + ProductGroupGridItems.routeName,
                  extra: {
                    'title': title,
                    'url': Application.httBaseUrl +
                        '/product?categoryId=$categoryId'
                  });
            }),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: FutureBuilder<List<ProductCard>>(
            future: this.fetchProduct(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: snapshot.data!,
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
        )
      ],
    );
  }
}
