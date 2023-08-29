import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/RetryButton.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/product/dto/GetProduct.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/services/RestClient.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class TopProducts extends StatelessWidget {
  TopProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
          padding: EdgeInsets.all(Application.defaultPadding / 2),
          child: FutureBuilder<List<ProductCard>>(
            future: fetchProduct(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: snapshot.data!,
                  crossAxisAlignment: CrossAxisAlignment.end,
                );
              } else if (snapshot.hasError) {
                return RetryButton(onTap: () {});
              }
              return Shimmer.fromColors(
                baseColor: ApplicationColor.shimmerBaseColor,
                highlightColor: ApplicationColor.shimmerHighlightColor,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FakeProductCard(),
                      FakeProductCard(),
                      FakeProductCard()
                    ]),
              );
            },
          )),
    );
  }

  Future<List<ProductCard>> fetchProduct() async {
    RestClient restClient = RestClient(await HttpRequestService.getDio());
    GetProductResponse response = await restClient
        .fetchProduct(GetProduct(pageIndex: 0, pageSize: 10, isTop: true));
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
}
