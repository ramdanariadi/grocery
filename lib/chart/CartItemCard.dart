import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/product/ProductDetail.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/state_manager/RouterState.dart';

class CartItemCard extends StatefulWidget {
  CartItemCard({
    Key? key,
    required this.callback,
    required this.id,
    required this.shopId,
    required this.shopName,
    required this.productId,
    required this.merk,
    required this.category,
    required this.weight,
    required this.price,
    required this.total,
    this.imageUrl,
  }) : super(key: key);

  final String id;
  final String shopId;
  final String shopName;
  final String productId;
  final String merk;
  final int weight;
  final int price;
  final String category;
  final String? imageUrl;
  final int total;
  final VoidCallback callback;

  factory CartItemCard.fromJson(
      Map<String, dynamic> item, VoidCallback callback) {
    return new CartItemCard(
      id: item['id'],
      shopId: item['shopId'],
      shopName: item['shopName'],
      productId: item['productId'],
      merk: item['name'],
      weight: item['weight'],
      price: item['price'],
      total: item['total'],
      category: item['category'],
      imageUrl: item['imageUrl'],
      callback: callback,
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _WideProductCard(this.total);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '{ ${this.merk},${this.weight},${this.price},${this.total},${this.category},${this.imageUrl} }';
  }
}

class _WideProductCard extends State<CartItemCard> {
  int total;
  _WideProductCard(int total) : this.total = total;

  @override
  void initState() {
    super.initState();
  }

  void handleCountChange(context) {
    setState(() {
      if (context == 'plus') total++;
      if (context == 'minus') total < 1 ? total = 0 : total--;
    });
    widget.callback();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double cardHeight = size.height / 6.5;
    RouterState routerState = BlocProvider.of<RouterState>(context);
    return GestureDetector(
      onTap: () {
        routerState.go(
            context: context,
            baseRoute: Products.routeName,
            path: ProductDetail.routeName,
            extra: ProductArguments(
                tag: widget.id + 'cart',
                id: widget.id,
                shopId: widget.shopId,
                shopName: widget.shopName,
                merk: widget.merk,
                category: widget.category,
                weight: widget.weight,
                price: widget.price,
                imageUrl: widget.imageUrl!));
      },
      child: Container(
        width: size.width,
        margin: EdgeInsets.only(
            top: Application.defaultPadding / 2,
            bottom: Application.defaultPadding / 6,
            left: Application.defaultPadding,
            right: Application.defaultPadding),
        padding: EdgeInsets.symmetric(vertical: Application.defaultPadding / 2),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 8),
                  color: ApplicationColor.shadowColor.withOpacity(0.23),
                  spreadRadius: -10,
                  blurRadius: 20)
            ],
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id + 'cart',
                    child: widget.imageUrl == null
                        ? Image.asset(
                            'images/notFound.png',
                            height: cardHeight * 0.6,
                            width: size.width / 5,
                          )
                        : Image.network(
                            widget.imageUrl!,
                            height: cardHeight * 0.6,
                            width: size.width / 5,
                          ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: Application.defaultPadding / 2),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "${widget.merk}\n",
                          style: TextStyle(
                              height: 1.5,
                              color: ApplicationColor.blackHint,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "weight ",
                          style: TextStyle(
                              height: 1.5, color: ApplicationColor.blackHint)),
                      TextSpan(
                          text: "${widget.weight}g\n",
                          style: TextStyle(
                              height: 1.5,
                              color: ApplicationColor.blackHint,
                              fontWeight: FontWeight.w500)),
                      TextSpan(
                          text: "\$${widget.price}",
                          style: TextStyle(
                              height: 1.5,
                              color: ApplicationColor.blackHint,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "/kg",
                          style: TextStyle(
                              height: 1.5, color: ApplicationColor.blackHint)),
                    ])),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: Application.defaultPadding / 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Button(
                              width: 30,
                              height: 30,
                              onTap: () {
                                this.handleCountChange('minus');
                              },
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.all(0),
                              color: ApplicationColor.naturalWhite
                                  .withOpacity(0.5),
                              child: Icon(
                                Icons.remove_outlined,
                                color: ApplicationColor.blackHint,
                                size: 15,
                              ),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Text(
                              "${total}",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ApplicationColor.blackHint,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Button(
                              width: 30,
                              height: 30,
                              onTap: () {
                                this.handleCountChange('plus');
                              },
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.all(0),
                              color: ApplicationColor.naturalWhite
                                  .withOpacity(0.5),
                              child: Icon(
                                Icons.add,
                                color: ApplicationColor.blackHint,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
