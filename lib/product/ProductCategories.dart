import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:grocery/custom_widget/Skeleteon.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ProductCategories extends StatelessWidget {
  ProductCategories({
    Key? key,
  }) : super(key: key);

  late Future<List<ProductCategory>> categoryFuture;

  Future<List<ProductCategory>> fetchCategories() async {
    final response = await HttpRequestService.sendRequest(method:HttpMethod.GET, url: Application.httBaseUrl + "/category?pageIndex=0&pageSize=10");
    
    if (response.statusCode == 200) {
      List<dynamic> listCategory = jsonDecode(response.body)['data'];
      List<ProductCategory> productCategories = listCategory
          .map((e) => ProductCategory.fromJson(e, (String categoryId, String title, BuildContext context) {
            GoRouter.of(context).go(Products.routeName + "/" + ProductGroupGridItems.routeName, extra: {
              'title': title, 
              'url': Application.httBaseUrl + '/product/category/$categoryId'
            });
          })).toList();
      return productCategories;
    } else {
      Fluttertoast.showToast(
          msg: "Failed load category", toastLength: Toast.LENGTH_LONG);
    }
    return List<ProductCategory>.empty();
  }

  @override
  Widget build(BuildContext context) {
    categoryFuture = this.fetchCategories();
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: FutureBuilder<List<ProductCategory>>(
          future: categoryFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Row(
                children: snapshot.data!,
              );
            }

            if (snapshot.hasError) {
              debugPrint("error : "+snapshot.error.toString());
              return Button(
                  width: 82, 
                  height: 40, 
                  onTap: (){
                    
                  }, 
                  padding: EdgeInsets.all(4),
                  borderRadius: BorderRadius.circular(50),
                  color: ApplicationColor.blackHint.withOpacity(0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("retry", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: ApplicationColor.blackHint),),
                    Icon(Icons.replay_outlined, size: 18,color: ApplicationColor.blackHint,),
                  ],
                ));
            }

            return Padding(
              padding: EdgeInsets.only(left: Application.defaultPadding),
              child: Shimmer.fromColors(
                baseColor: ApplicationColor.shimmerBaseColor,
                highlightColor: ApplicationColor.shimmerHighlightColor,
                child: Row(children: [
                  Skeleton(widht: 130, height: 38, borderRadius: BorderRadius.circular(40),),
                  SizedBox(width: 10,),
                  Skeleton(widht: 120, height: 38, borderRadius: BorderRadius.circular(40),),
                  SizedBox(width: 10,),
                  Skeleton(widht: 120, height: 38, borderRadius: BorderRadius.circular(40),),
                  SizedBox(width: 10,),
                  Skeleton(widht: 100, height: 38, borderRadius: BorderRadius.circular(40),)],),
              ),
            );
          },
        ));
  }
}

// ignore: must_be_immutable
class ProductCategory extends StatelessWidget {
  ProductCategory({
    Key? key,
    String? imageUrl,
    required this.id,
    required this.title,
    required this.onTap,
  }) : super(key: key) {
    this.imageUrl = imageUrl;
  }

  factory ProductCategory.fromJson(Map<String, dynamic> json, Function onTap) {
    return new ProductCategory(
      id: json['id'],
      title: json['category'],
      onTap: onTap,
      imageUrl: json['imageUrl'],
    );
  }

  String? imageUrl;
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
          margin:
              EdgeInsets.only(left: Application.defaultPadding, bottom: Application.defaultPadding),
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
                width: this.imageUrl != null ? Application.defaultPadding / 2 : 0,
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
