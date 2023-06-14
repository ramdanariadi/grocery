import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/products/LabelWithActionButton.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/state_manager/PaginationState.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ProductGroupGridItems extends StatelessWidget {
  static final routeName = 'allProductByCategory';

  final String title;
  final String url;

  Future<List<ProductCard>>? productFuture;
  PaginationState paginationState = PaginationState(
      data: List.empty(growable: true), pageIndex: 0, pageSize: 10);
  ProductGroupGridItems({required this.url, required this.title});

  Future<void> fetchProduct() async {
    debugPrint("scroll controller fetch product pageIndex = " +
        paginationState.pageIndex.toString());
    paginationState.setIsLoading(
        true,
        Shimmer.fromColors(
          baseColor: ApplicationColor.shimmerBaseColor,
          highlightColor: ApplicationColor.shimmerHighlightColor,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, child: FakeProductCard()),
        ));
    await Future.delayed(Duration(seconds: 2));
    final response = await HttpRequestService.sendRequest(
        method: HttpMethod.GET,
        url: this.url +
            "&pageIndex=${paginationState.pageIndex++}&pageSize=${paginationState.pageSize}");
    debugPrint(
        "scroll controller status code " + response.statusCode.toString());
    if (response.statusCode == 200) {
      List<dynamic> responseList = jsonDecode(response.body)['data'];
      List<ProductCard> productList = responseList
          .map((e) => ProductCard.fromJson(
                e,
                margin: Application.defaultPadding / 4,
              ))
          .toList();
      if (productList.isEmpty) {
        this.paginationState.pageIndex = this.paginationState.pageIndex - 1;
      }
      paginationState.refresh(data: productList);
    } else {
      this.paginationState.pageIndex = this.paginationState.pageIndex - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    this.fetchProduct();
    ScrollController scrollController = ScrollController();
    scrollController.addListener(
      () {
        debugPrint("scroll controller : " +
            scrollController.position.pixels.toString() +
            " of " +
            scrollController.position.maxScrollExtent.toString());
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          debugPrint(
              "scroll controller : " + paginationState.isLoading().toString());
          if (!paginationState.isLoading()) {
            this.fetchProduct();
          }
        }

        // Fluttertoast.showToast(msg: "msg");
      },
    );
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
                  child: StreamBuilder<List<dynamic>>(
                      stream: paginationState.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          debugPrint(
                              "scroll controller stream received data : " +
                                  snapshot.data!.length.toString());

                          return StaggeredGridView.countBuilder(
                            controller: scrollController,
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

                        debugPrint("scroll controller stream received");

                        return Shimmer.fromColors(
                          baseColor: ApplicationColor.shimmerBaseColor,
                          highlightColor:
                              ApplicationColor.shimmerHighlightColor,
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
                      })
                  // FutureBuilder<List<ProductCard>>(
                  //   future: productFuture,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       return StaggeredGridView.countBuilder(
                  //         controller: scrollController,
                  //         crossAxisCount: 2,
                  //         itemCount: snapshot.data!.length,
                  //         itemBuilder: (BuildContext context, int index) =>
                  //             snapshot.data![index],
                  //         staggeredTileBuilder: (int index) =>
                  //             new StaggeredTile.fit(1),
                  //         mainAxisSpacing: Application.defaultPadding / 2,
                  //         // crossAxisSpacing: Application.defaultPadding,
                  //       );
                  //     }

                  //     if (snapshot.hasError) {
                  //       return RetryButton(onTap: () {});
                  //     }

                  // return Shimmer.fromColors(
                  //   baseColor: ApplicationColor.shimmerBaseColor,
                  //   highlightColor: ApplicationColor.shimmerHighlightColor,
                  //   child: SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  //       child: Row(
                  //         children: [
                  //           FakeProductCard(),
                  //           FakeProductCard(),
                  //           FakeProductCard()
                  //         ],
                  //       )),
                  // );
                  //   },
                  // ),
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
