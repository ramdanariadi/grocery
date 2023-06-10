import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/state_manager/DataState.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);

  final TextEditingController searchController = TextEditingController();
  final DataState<Widget> productsState = DataState(Container());

  Future<List<ProductCard>> doSearch(String search) async {
    final response = await HttpRequestService.sendRequest(
        method: HttpMethod.GET,
        url: Application.httBaseUrl +
            "/product?pageIndex=0&pageSize=10&search=$search");
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      return data.map((e) => ProductCard.fromJson(e)).toList();
    }

    return List.empty();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(Application.defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: 45,
              width: size.width - Application.defaultPadding * 2,
              padding:
                  EdgeInsets.symmetric(horizontal: Application.defaultPadding),
              decoration: BoxDecoration(
                  color: ApplicationColor.naturalWhite,
                  borderRadius:
                      BorderRadius.circular(Application.defaultPadding - 8)),
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: TextFormField(
                        controller: searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Search",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        onChanged: (text) {},
                        // autofocus: true,
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        productsState.add(Shimmer.fromColors(
                            baseColor: ApplicationColor.shimmerBaseColor,
                            highlightColor:
                                ApplicationColor.shimmerHighlightColor,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Row(
                                children: [
                                  FakeProductCard(),
                                  FakeProductCard()
                                ],
                              ),
                            )));
                        FocusScope.of(context).unfocus();
                        Fluttertoast.showToast(
                            msg: "do search", toastLength: Toast.LENGTH_SHORT);
                        List<ProductCard> products =
                            await doSearch(searchController.text);
                        productsState.add(SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Row(
                            children: products,
                          ),
                        ));
                      },
                      child: Icon(Icons.search))
                ],
              )),
          Container(
            padding: EdgeInsets.only(top: Application.defaultPadding),
            child: StreamBuilder<Widget>(
                stream: productsState.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!;
                  }

                  return Container();
                }),
          )
        ],
      ),
    );
  }
}
