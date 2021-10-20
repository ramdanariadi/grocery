import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/home/BottomNavBar.dart';
import 'package:grocery/products/ProductGroupItems.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Products extends StatelessWidget {
  static final routeName = '/products';

  Future<List<ProductGroupItems>>? groupsFuture;

  Future<List<ProductGroupItems>> fetchCategory() async {
    final response = await http.get(Uri.parse("$HTTPBASEURL/category"));
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
          SingleChildScrollView(
            child: FutureBuilder<List<ProductGroupItems>>(
              future: groupsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
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
          BottomNavBar(
            active: Products.routeName,
          )
        ],
      ),
    );
  }
}
