import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:grocery/custom_widget/Skeleteon.dart';
import 'package:grocery/product/dto/GetCategory.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/services/RestClient.dart';
import 'package:grocery/state_manager/RouterState.dart';
import 'package:shimmer/shimmer.dart';

class ProductCategories extends StatelessWidget {
  ProductCategories({
    Key? key,
  }) : super(key: key);

  Future<List<ProductCategory>> fetchCategories() async {
    final client = RestClient(await HttpRequestService.getDio());
    final GetCategoryResponse response =
        await client.fetchCategory(GetCategory(pageIndex: 0, pageSize: 10));

    List<ProductCategory> pc = response.data
        .map((e) => ProductCategory(
              id: e.id,
              imageUrl: e.imageUrl,
              title: e.category,
              onTap: (String categoryId, String title, BuildContext context) {
                RouterState routerState = BlocProvider.of<RouterState>(context);
                routerState.go(
                    context: context,
                    baseRoute: Products.routeName,
                    path: ProductGroupGridItems.routeName,
                    extra: {
                      'title': title,
                      'url': Application.httBaseUrl +
                          '/product?categoryId=$categoryId&pageIndex=0&pageSize=10'
                    });
              },
            ))
        .toList();
    return pc;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder<List<ProductCategory>>(
          future: fetchCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                children: snapshot.data!,
              );
            }

            if (snapshot.hasError) {
              debugPrint("error : " + snapshot.error.toString());
              return Button(
                  width: 82,
                  height: 40,
                  onTap: () {},
                  padding: EdgeInsets.all(4),
                  borderRadius: BorderRadius.circular(50),
                  color: ApplicationColor.blackHint.withOpacity(0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "retry",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: ApplicationColor.blackHint),
                      ),
                      Icon(
                        Icons.replay_outlined,
                        size: 18,
                        color: ApplicationColor.blackHint,
                      ),
                    ],
                  ));
            }

            return Padding(
              padding: EdgeInsets.only(left: Application.defaultPadding),
              child: Shimmer.fromColors(
                baseColor: ApplicationColor.shimmerBaseColor,
                highlightColor: ApplicationColor.shimmerHighlightColor,
                child: Row(
                  children: [
                    Skeleton(
                      widht: 130,
                      height: 38,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Skeleton(
                      widht: 120,
                      height: 38,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Skeleton(
                      widht: 120,
                      height: 38,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Skeleton(
                      widht: 100,
                      height: 38,
                      borderRadius: BorderRadius.circular(40),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class ProductCategory extends StatelessWidget {
  ProductCategory({
    Key? key,
    this.imageUrl,
    required this.id,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  factory ProductCategory.fromJson(Map<String, dynamic> json, Function onTap) {
    return new ProductCategory(
      id: json['id'],
      title: json['category'],
      onTap: onTap,
      imageUrl: json['imageUrl'],
    );
  }

  final String? imageUrl;
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
          margin: EdgeInsets.only(
              left: Application.defaultPadding,
              bottom: Application.defaultPadding),
          padding: EdgeInsets.only(
              left: Application.defaultPadding,
              right: Application.defaultPadding,
              top: Application.defaultPadding / 2,
              bottom: Application.defaultPadding / 2),
          decoration: BoxDecoration(
              color: ApplicationColor.naturalWhite,
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    offset: Offset(0, 2),
                    color: ApplicationColor.shadowColor.withOpacity(0.12),
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
                width:
                    this.imageUrl != null ? Application.defaultPadding / 2 : 0,
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
