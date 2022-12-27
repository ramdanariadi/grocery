import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';

// ignore: must_be_immutable
class TransactionCard extends StatelessWidget {
  TransactionCard(
      {Key? key,
      String? imageUrl,
      required this.name,
      required this.total,
      required this.totalPrice,
      required this.totalPerProduct})
      : super(key: key) {
    this.imageUrl = imageUrl;
  }

  String? imageUrl;
  final String name;
  final int total;
  final int totalPrice;
  final int totalPerProduct;

  factory TransactionCard.fromJson(Map<String, dynamic> json) {
    return TransactionCard(
        name: json['name'],
        imageUrl: json['imageUrl'],
        totalPerProduct: json['totalPerProduct'],
        total: json['total'],
        totalPrice: json['totalPrice']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Application.defaultPadding,
          right: Application.defaultPadding,
          bottom: Application.defaultPadding / 4,
          top: Application.defaultPadding / 4),
      padding: EdgeInsets.all(Application.defaultPadding / 3),
      width: double.infinity,
      height: 100,
      constraints: BoxConstraints(maxHeight: 150),
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
        children: [
          // Image.asset('images/notFound.png'),
          this.imageUrl == null
              ? Image.asset('images/notFound.png')
              : Image.network(this.imageUrl!),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  this.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  "${this.totalPerProduct} piece${this.totalPerProduct > 1 ? 's' : ''}",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "+${this.total > 1 ? this.total - 1 : 0} product more",
                  style: TextStyle(fontSize: 12),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "Total : ",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  TextSpan(
                    text: "\$${this.totalPrice}",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ]))
              ],
            ),
          )
        ],
      ),
    );
  }
}
