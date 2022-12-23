import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/services/HttpRequestService.dart';

// ignore: must_be_immutable
class TopProducts extends StatelessWidget {
  TopProducts({
    Key? key,
  }) : super(key: key);

  late Future<List<ProductCard>> futureProductList;

  void initState() {
    futureProductList = this.fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    this.initState();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
          padding: EdgeInsets.all(Application.defaultPadding / 2),
          child: FutureBuilder<List<ProductCard>>(
            future: futureProductList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: snapshot.data!,
                  crossAxisAlignment: CrossAxisAlignment.end,
                );
              } else if (snapshot.hasError) {
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
                ));              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }

  Future<List<ProductCard>> fetchProduct() async {
    final response = await HttpRequestService.sendRequest(method:HttpMethod.GET, url: Application.httBaseUrl + "/top-product.php");

    if (response.statusCode == 200) {
      List<dynamic> productList = jsonDecode(response.body)['data'];
      List<ProductCard> productCardList = productList
          .map((dynamic item) => ProductCard.fromJson(item))
          .toList();
      return productCardList;
    } else {
      throw Exception("Failed load product");
    }
  }
}
