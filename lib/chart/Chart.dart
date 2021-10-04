import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery/chart/WideProductCard.dart';
import 'package:http/http.dart' as http;
import '../constrant.dart';

class Chart extends StatelessWidget {
  static final routeName = '/chart';

  Future<List<WideProductCard>>? productFuture;

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
              onTap: () {},
            ),
          )
        ]),
      ),
    );
  }
}
