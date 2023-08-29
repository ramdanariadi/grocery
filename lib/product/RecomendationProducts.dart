import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/RetryButton.dart';
import 'package:grocery/product/WideProductCard.dart';
import 'package:grocery/product/dto/GetProduct.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/services/RestClient.dart';
import 'package:shimmer/shimmer.dart';

class RecomendationProducts extends StatelessWidget {
  RecomendationProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
          padding: EdgeInsets.only(
              top: Application.defaultPadding / 2,
              left: Application.defaultPadding / 2,
              right: Application.defaultPadding / 2,
              bottom: Application.defaultPadding),
          child: FutureBuilder<List<WideProductCard>>(
            future: fetchRecomendedProduct(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: snapshot.data!,
                  crossAxisAlignment: CrossAxisAlignment.end,
                );
              } else if (snapshot.hasError) {
                return RetryButton(
                  onTap: () {},
                );
              }
              return Shimmer.fromColors(
                baseColor: ApplicationColor.shimmerBaseColor,
                highlightColor: ApplicationColor.shimmerHighlightColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [FakeWideProductCard(), FakeWideProductCard()],
                ),
              );
            },
          )),
    );
  }

  Future<List<WideProductCard>> fetchRecomendedProduct() async {
    RestClient restClient = RestClient(await HttpRequestService.getDio());
    GetProductResponse response = await restClient.fetchProduct(
        GetProduct(pageIndex: 0, pageSize: 10, isRecomendation: true));
    return response.data
        .map((e) => WideProductCard(
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
