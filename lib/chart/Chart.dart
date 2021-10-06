import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/alert/Alert.dart';
import 'package:grocery/chart/WideProductCard.dart';
import 'package:grocery/home/Home.dart';
import 'package:http/http.dart' as http;
import '../constrant.dart';

class Chart extends StatelessWidget {
  static final routeName = '/chart';

  Future<List<WideProductCard>>? productFuture;
  List<WideProductCard>? productList;

  Future<List<WideProductCard>> fetchChart() async {
    final response = await http.get(
        Uri.parse(HTTPBASEURL + '/chart/ac723ce6-11d2-11ec-82a8-0242ac130003'));

    if (response.statusCode == 200) {
      List<dynamic> chart = jsonDecode(response.body)['response'];
      List<WideProductCard> chartList =
          chart.map((dynamic item) => WideProductCard.fromJson(item)).toList();
      return chartList;
    } else {
      throw Exception("Failed load chart");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    productFuture = this.fetchChart();
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(
            top: kDefaultPadding * 1.4,
            right: kDefaultPadding,
            bottom: kDefaultPadding,
            left: kDefaultPadding),
        color: kNaturanWhite,
        child: Stack(children: [
          SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: FutureBuilder<List<WideProductCard>>(
                future: productFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    productList = snapshot.data!;
                    return Column(
                      children: snapshot.data!,
                    );
                  }

                  if (snapshot.hasError) {
                    return Text("Failed load chart");
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )),
          Positioned(
            bottom: 10,
            child: GestureDetector(
              child: Container(
                width: size.width - (kDefaultPadding * 2),
                height: size.height / 11,
                padding: EdgeInsets.all(kDefaultPadding),
                child: Center(
                  child: Text(
                    "Checkout",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                ),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(8)),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Alert(
                              icon: Alerts.success,
                              message: 'message',
                              callback: () {
                                Navigator.pushNamed(context, Home.routeName);
                              },
                            )));
                // debugPrint("object");
                // WideProductCard wideProductCard = productList!.first;
                // final resBody = jsonEncode(<String, dynamic>{
                //   'userId': 'ac723ce6-11d2-11ec-82a8-0242ac130003',
                //   'products': productList!
                //       .map((e) => <String, dynamic>{
                //             "id": "d7c6d7a4-186c-11ec-b6fd-23e8ea136663",
                //             "name": e.merk,
                //             "price": e.price,
                //             "weight": e.weight,
                //             "perUnit": 100,
                //             "total": e.total
                //           })
                //       .toList()
                // });
                // debugPrint(resBody);
                // final response = await http.post(
                //     Uri.parse(HTTPBASEURL + "/transaction"),
                //     headers: <String, String>{
                //       'Content-Type': 'application/json'
                //     },
                //     body: resBody);
                // if (response.statusCode == 200) {
                //   final Map<String, dynamic> message =
                //       jsonDecode(response.body)['metaData'];
                //   debugPrint(message.toString());
                // }
                // debugPrint(response.statusCode.toString());
                // debugPrint(jsonDecode(response.body).toString());
              },
            ),
          )
        ]),
      ),
    );
  }
}
