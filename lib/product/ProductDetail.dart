import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:grocery/home/Home.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  static final routeName = '/detailProduct';

  final String id;
  final String tag;
  final String merk;
  final String category;
  final int weight;
  final int price;
  String? imageUrl;

  ProductDetail(
      {Key? key,
      required this.id,
      required this.tag,
      required this.merk,
      required this.category,
      required this.weight,
      required this.price,
      String? imageUrl}) {
    this.imageUrl = imageUrl;
  }

  @override
  _ProductDetail createState() {
    return _ProductDetail();
  }
}

class _ProductDetail extends State<ProductDetail> {
  int _count = 1;
  Icon loveIcon = Icon(Icons.favorite_outline, size: 30);
  bool productLoved = false;
  bool widgetExist = true;

  _ProductDetail();

  void handleCountChange(context) {
    setState(() {
      if (context == 'plus') _count++;
      if (context == 'minus') _count == 0 ? _count = 0 : _count--;
    });
  }

  Future<void> like() async {
    final response;
    if (productLoved) {
      response = await http.delete(Uri.parse(HTTP_BASE_URL +
          '/wishlist/ac723ce6-11d2-11ec-82a8-0242ac130003/${widget.id}'));
    } else {
      response = await http.post(Uri.parse(HTTP_BASE_URL +
          '/wishlist/ac723ce6-11d2-11ec-82a8-0242ac130003/${widget.id}'));
    }
    if (response.statusCode == 200 && widgetExist) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      productLoved = responseBody['metaData']['code'] == 201;
      setState(() {
        loveIcon = productLoved
            ? Icon(Icons.favorite, size: 30, color: Colors.red)
            : Icon(Icons.favorite_outline, size: 30);
      });
      Fluttertoast.showToast(
          msg: productLoved ? 'loved it' : 'unloved it',
          toastLength: Toast.LENGTH_LONG);
    } else {
      Fluttertoast.showToast(
          msg: '${response.statusCode}', toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> addToCart() async {
    final response = await http.post(Uri.parse(HTTP_BASE_URL +
        '/cart/ac723ce6-11d2-11ec-82a8-0242ac130003/${widget.id}/$_count'));
    if (response.statusCode == 200 && widgetExist) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (responseBody['metaData']['code'] == 201) {
        // Fluttertoast.showToast(msg: "yeay product added");
        Navigator.pushNamed(context, Home.routeName);
      }
    } else {
      Fluttertoast.showToast(msg: "opps something wrong");
      debugPrint(response.body.toString());
    }
  }

  Future<void> isLiked() async {
    final response = await http.get(Uri.parse(HTTP_BASE_URL +
        '/wishlist/ac723ce6-11d2-11ec-82a8-0242ac130003/${widget.id}'));
    if (response.statusCode == 200 && widgetExist) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      // Fluttertoast.showToast(msg: "loved", toastLength: Toast.LENGTH_LONG);
      productLoved = responseBody['metaData']['code'] == 200;
      setState(() {
        loveIcon = productLoved
            ? Icon(Icons.favorite, size: 30, color: Colors.red)
            : Icon(Icons.favorite_outline, size: 30);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.isLiked();
  }

  @override
  void dispose() {
    super.dispose();
    widgetExist = false;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        padding: EdgeInsets.only(
            top: kDefaultPadding * 1.4,
            right: kDefaultPadding,
            bottom: kDefaultPadding,
            left: kDefaultPadding),
        color: kNaturalWhite,
        child: Stack(children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios_new, size: 32)),
                    GestureDetector(
                      onTap: () {
                        // Fluttertoast.showToast(
                        //     msg: 'loved it ${widget.merk}',
                        //     toastLength: Toast.LENGTH_LONG);
                      },
                      child: GestureDetector(
                        child: Container(
                            margin: EdgeInsets.only(right: 8), child: loveIcon),
                        onTap: () {
                          this.like();
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    widget.merk,
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 30),
                  child: Text(
                    widget.category,
                    style: TextStyle(
                        color: kShadowColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w200),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: size.width * 0.7),
                  child: Hero(
                      tag: widget.tag,
                      child: widget.imageUrl == null
                          ? Image.asset('images/notFound.png')
                          : Image.network(widget.imageUrl!)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 28),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "\$${widget.price}",
                          style: TextStyle(
                              height: 2,
                              fontSize: 24,
                              color: kBlackHint,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " /kg",
                          style: TextStyle(
                              height: 2, fontSize: 24, color: kBlackHint)),
                    ]),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          handleCountChange('minus');
                        },
                        child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                                color: kShadowColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(Icons.remove, size: 30))),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "$_count",
                      style: TextStyle(
                          fontSize: 24,
                          color: kBlackHint,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    InkWell(
                        onTap: () {
                          handleCountChange('plus');
                        },
                        child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                                color: kShadowColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              Icons.add,
                              size: 30,
                            ))),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Center(
              child: Button(
                  margin: EdgeInsets.all(0),
                  child: Text(
                    'Add to cart',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                  width: size.width - (kDefaultPadding * 2),
                  height: size.height / 11,
                  onTap: () {
                    this.addToCart();
                  }),
            ),
          )
        ]),
      ),
    );
  }
}
