import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/state_manager/DataState.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key) {}

  final TextEditingController searchController = TextEditingController();
  final DataState<Widget> productsState = DataState(Container());
  late final Debounce debounce = Debounce(callback: _doSearch);

  Future<List<ProductCard>> fetchProduct(String search) async {
    debugPrint("debounce-search fetchProduct $search");
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

  void _doSearch() async {
    productsState.add(Shimmer.fromColors(
        baseColor: ApplicationColor.shimmerBaseColor,
        highlightColor: ApplicationColor.shimmerHighlightColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            children: [FakeProductCard(), FakeProductCard()],
          ),
        )));
    Fluttertoast.showToast(msg: "do search", toastLength: Toast.LENGTH_SHORT);
    List<ProductCard> products = await fetchProduct(searchController.text);
    productsState.add(StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) => products[index],
      staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
      mainAxisSpacing: Application.defaultPadding / 2,
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    searchController.addListener(() {
      debounce.search(searchController.text);
    });

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Application.defaultPadding,
      ),
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
                        FocusScope.of(context).unfocus();
                        this._doSearch();
                      },
                      child: Icon(Icons.search))
                ],
              )),
          Expanded(
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: Application.defaultPadding),
              child: StreamBuilder<Widget>(
                  stream: productsState.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    }

                    return Container();
                  }),
            ),
          )
        ],
      ),
    );
  }
}

class Debounce {
  Timer? _timer;
  int secondsWait;
  VoidCallback callback;

  Debounce({required VoidCallback this.callback, int this.secondsWait = 1});

  void search(String text) {
    if (_timer != null) {
      debugPrint("debounce-search cancel timer $text");
      _timer!.cancel();
    }

    if (text.isEmpty) {
      return;
    }

    debugPrint("debounce-search init timer $text");
    _timer = Timer(Duration(seconds: secondsWait), callback);
  }
}
