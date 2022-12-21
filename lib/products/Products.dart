import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/products/ProductGroupItems.dart';
import 'package:grocery/services/HttpRequestService.dart';

// ignore: must_be_immutable
class Products extends StatelessWidget {
  static final routeName = '/products';

  late Future<List<ProductGroupItems>> groupsFuture;

  Future<List<ProductGroupItems>> fetchCategory() async {
    final response = await HttpRequestService.sendRequest(method: HttpMethod.GET, url: Application.httBaseUrl + "/category");
    if (response.statusCode == 200) {
      List<dynamic> categories = jsonDecode(response.body)['response'];
      List<ProductGroupItems> productGroupItems =
          categories.map((e) => ProductGroupItems.fromJson(e)).toList();
      return productGroupItems;
    } else {
      throw Exception("failed load categories");
    }
  }

  @override
  Widget build(BuildContext context) {
    groupsFuture = this.fetchCategory();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: Application.defaultPadding * 1.2),
            child: SingleChildScrollView(
              child: FutureBuilder<List<ProductGroupItems>>(
                future: groupsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    snapshot.data!.add(ProductGroupItems(
                        title: "",
                        actionButtonTitle: "",
                        categoryId: "ba3e987a-12bb-484c-aeef-33d49da62f74"));
                    return Column(
                      children: snapshot.data!,
                    );
                  }
                  if (snapshot.hasError) {
                    return Text("failed load data");
                  }
                  return Center(
                    child: CircularProgressIndicator(),
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
