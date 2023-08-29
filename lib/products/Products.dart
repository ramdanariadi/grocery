import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/RetryButton.dart';
import 'package:grocery/custom_widget/Skeleteon.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/product/dto/GetCategory.dart';
import 'package:grocery/products/ProductGroupItems.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/services/RestClient.dart';
import 'package:shimmer/shimmer.dart';

class Products extends StatelessWidget {
  static final routeName = '/products';

  Future<List<ProductGroupItems>> fetchCategory() async {
    final client = RestClient(await HttpRequestService.getDio());
    final GetCategoryResponse response =
        await client.fetchCategory(GetCategory(pageIndex: 0, pageSize: 10));

    return response.data
        .map((e) => ProductGroupItems(
              title: e.category,
              categoryId: e.id,
              actionButtonTitle: "SHOW ALL",
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: Application.defaultPadding * 2.5),
            child: SingleChildScrollView(
              child: FutureBuilder<List<ProductGroupItems>>(
                future: this.fetchCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data!,
                    );
                  }
                  if (snapshot.hasError) {
                    return RetryButton(onTap: () {});
                  }
                  return Shimmer.fromColors(
                    baseColor: ApplicationColor.shimmerBaseColor,
                    highlightColor: ApplicationColor.shimmerHighlightColor,
                    child: Container(
                      margin: EdgeInsets.only(top: Application.defaultPadding),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Application.defaultPadding / 2),
                            child: FakeLabelWithActionButton(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  FakeProductCard(),
                                  FakeProductCard(),
                                  FakeProductCard()
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Application.defaultPadding / 2),
                            child: FakeLabelWithActionButton(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  FakeProductCard(),
                                  FakeProductCard(),
                                  FakeProductCard()
                                ],
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Application.defaultPadding / 2),
                            child: FakeLabelWithActionButton(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  FakeProductCard(),
                                  FakeProductCard(),
                                  FakeProductCard()
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // BottomNavBar(
          //   activeRoute: Products.routeName,
          // )
        ],
      ),
    );
  }
}

class FakeLabelWithActionButton extends StatelessWidget {
  const FakeLabelWithActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Skeleton(widht: 140, height: 38),
          Skeleton(widht: 80, height: 30)
        ],
      ),
    );
  }
}
