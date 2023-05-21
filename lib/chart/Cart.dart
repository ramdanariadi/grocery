import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/alert/Alert.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/home/Home.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/services/UserService.dart';
import 'package:grocery/state_manager/DataProviderState.dart';

import 'CartItemCard.dart';

class Cart extends StatefulWidget {
  static final routeName = '/cart';

  @override
  State<StatefulWidget> createState() {
    return _Cart();
  }
}

class _Cart extends State<Cart> {
  late Future<List<CartItemCard>> productFuture;
  late List<CartItemCard> productList;
  DataProviderState<int> totalState = DataProviderState();
  UserService userService = UserService.getInstance();

  Future<List<CartItemCard>> fetchCart() async {
    final response = await HttpRequestService.sendRequest(method: HttpMethod.GET, url: Application.httBaseUrl + '/cart', isSecure: true);

    if (response.statusCode == 200) {
      List<dynamic> cart = jsonDecode(response.body)['data'];
      int tmpTotalPrice = 0;
      debugPrint("body : " + response.body);
      productList = cart.map((dynamic item) {
        Map<String, dynamic> mapItem = item;
        tmpTotalPrice += int.parse(mapItem['price'].toString()) * int.parse(mapItem['total'].toString());
        return CartItemCard.fromJson(item, () {
          this.countTotalPrice();
        });
      }).toList();

      totalState.eventSink.add(tmpTotalPrice);
      return productList;
    } else {
      throw Exception("Failed load cart");
    }
  }

  void countTotalPrice() {
    int totalPrice = 0;
    productList.forEach((element) {
      totalPrice += element.price * element.total;
    });
    totalState.eventSink.add(totalPrice);
  }

  @override
  void initState() {
    super.initState();
    productFuture = this.fetchCart();
  }

  @override
  void dispose(){
    super.dispose();
    totalState.dispose();
  }

  Future<void> checkout() async {
    this.countTotalPrice();
    debugPrint("object");
    final resBody = jsonEncode(<String, dynamic>{
      'userId': userService.userId,
      'products': productList
        .map((e) => <String, dynamic>{
          "id": e.productId,
          "total": e.total
        })
        .toList()
    });
    debugPrint(resBody);
    final response = await HttpRequestService.sendRequest(method: HttpMethod.POST, 
      url: Application.httBaseUrl + "/transaction", 
      body: resBody, 
      isSecure: true);
    if (response.statusCode == 200) {
      GoRouter.of(context).go(Alert.routeName, extra: Alert(icon: Alerts.success, message: "Order Successfully", 
        routeToClose: Home.routeName,));
      debugPrint("checkout success");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.only(
            top: Application.defaultPadding * 1.2,
            // right: Application.defaultPadding,
            bottom: size.height * 0.29,
            // left: Application.defaultPadding
          ),
          color: ApplicationColor.naturalWhite,
          child: FutureBuilder<List<CartItemCard>>(
            future: productFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!,
                );
              }

              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: EdgeInsets.all(Application.defaultPadding),
            width: size.width,
            height: size.height * 0.25,
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(20),
              //     topRight: Radius.circular(20))
            ),
            child: StreamBuilder(
              stream: totalState.stream,
              initialData: 0,
              builder: (context, snapshot) => Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      right: Application.defaultPadding, bottom: Application.defaultPadding / 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sub total price",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Color.fromRGBO(108, 111, 115, 1)),
                        ),
                        Text(
                          "${snapshot.data}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromRGBO(108, 111, 115, 1)),
                        )
                      ]),
                ),
                Container(
                  margin: EdgeInsets.only(
                      right: Application.defaultPadding, bottom: Application.defaultPadding / 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Coupon",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Color.fromRGBO(108, 111, 115, 1)),
                        ),
                        Text(
                          "None",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromRGBO(108, 111, 115, 1)),
                        )
                      ]),
                ),
                Container(
                  height: 1,
                  color: Color.fromRGBO(176, 176, 176, 0.8),
                  width: size.width - Application.defaultPadding * 2,
                  margin: EdgeInsets.only(bottom: Application.defaultPadding / 4),
                ),
                Container(
                  margin: EdgeInsets.only(
                      right: Application.defaultPadding, bottom: Application.defaultPadding),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Color.fromRGBO(108, 111, 115, 1)),
                        ),
                        Text(
                          "${snapshot.data}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromRGBO(108, 111, 115, 1)),
                        )
                      ]),
                ),
                TextButton(
                    onPressed: () {
                      this.checkout();
                    },
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w200),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: ApplicationColor.primaryColor,
                        minimumSize: Size(double.infinity, size.height / 11),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)))),
              ],
            ),)
          ),
        )
      ]),
    );
  }
}
