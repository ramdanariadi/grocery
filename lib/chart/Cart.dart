import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/alert/Alert.dart';
import 'package:grocery/home/Home.dart';
import 'package:http/http.dart' as http;
import '../constrant.dart';
import 'WideProductCard.dart';

class Cart extends StatefulWidget {
  static final routeName = '/cart';

  @override
  State<StatefulWidget> createState() {
    return _Cart();
  }
}

class _Cart extends State<Cart> {
  late Future<List<WideProductCard>> productFuture;
  late List<WideProductCard> productList;
  int totalPrice = 0;

  Future<List<WideProductCard>> fetchCart() async {
    final response = await http.get(
        Uri.parse(HTTP_BASE_URL + '/cart/ac723ce6-11d2-11ec-82a8-0242ac130003'));

    if (response.statusCode == 200) {
      List<dynamic> cart = jsonDecode(response.body)['response'];
      int tmpTotalPrice = 0;
      List<WideProductCard> cartList = productList = cart.map((dynamic item) {
        Map<String, dynamic> mapItem = item;
        tmpTotalPrice += int.parse(mapItem['price'].toString()) *
            int.parse(mapItem['total'].toString());
        return WideProductCard.fromJson(item, () {
          this.countTotalPrice();
        });
      }).toList();
      setState(() {
        totalPrice = tmpTotalPrice;
      });
      return cartList;
    } else {
      throw Exception("Failed load cart");
    }
  }

  void countTotalPrice() {
    totalPrice = 0;
    setState(() {
      productList.forEach((element) {
        totalPrice += element.price * element.total;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    productFuture = this.fetchCart();
  }

  Future<void> checkout() async {
    this.countTotalPrice();
    debugPrint("object");
    final resBody = jsonEncode(<String, dynamic>{
      'userId': 'ac723ce6-11d2-11ec-82a8-0242ac130003',
      'products': productList
          .map((e) => <String, dynamic>{
                "id": e.productId,
                "name": e.merk,
                "price": e.price,
                "weight": e.weight,
                "perUnit": 100,
                "total": e.total,
                "imageUrl": e.imageUrl
              })
          .toList()
    });
    debugPrint(resBody);
    final response = await http.post(Uri.parse(HTTP_BASE_URL + "/transaction"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: resBody);
    if (response.statusCode == 200) {
      final Map<String, dynamic> message =
          jsonDecode(response.body)['metaData'];
      debugPrint(message.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Alert(
                    icon: Alerts.success,
                    message: 'Successfully Order',
                    callback: () {
                      Navigator.pushNamed(context, Home.routeName);
                    },
                  )));
    }
    debugPrint(response.statusCode.toString());
    debugPrint(jsonDecode(response.body).toString());
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
            top: kDefaultPadding * 1.2,
            // right: kDefaultPadding,
            bottom: size.height * 0.29,
            // left: kDefaultPadding
          ),
          color: kNaturalWhite,
          child: FutureBuilder<List<WideProductCard>>(
            future: productFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!,
                );
              }

              if (snapshot.hasError) {
                return Text("Failed load cart");
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
            padding: EdgeInsets.all(kDefaultPadding),
            width: size.width,
            height: size.height * 0.29,
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.only(
              //     topLeft: Radius.circular(20),
              //     topRight: Radius.circular(20))
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      right: kDefaultPadding, bottom: kDefaultPadding / 4),
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
                          "$totalPrice",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromRGBO(108, 111, 115, 1)),
                        )
                      ]),
                ),
                Container(
                  margin: EdgeInsets.only(
                      right: kDefaultPadding, bottom: kDefaultPadding / 4),
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
                  width: size.width - kDefaultPadding * 2,
                  margin: EdgeInsets.only(bottom: kDefaultPadding / 4),
                ),
                Container(
                  margin: EdgeInsets.only(
                      right: kDefaultPadding, bottom: kDefaultPadding),
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
                          "$totalPrice",
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
                        backgroundColor: kPrimaryColor,
                        minimumSize: Size(double.infinity, size.height / 11),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)))),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
