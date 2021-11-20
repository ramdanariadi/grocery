import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:grocery/home/BottomNavBar.dart';
import 'package:grocery/home/LabelWIthActionButton.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyAccount extends StatelessWidget {
  static final String routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(children: [
            UserProfile(),
            Container(
              width: size.width,
              margin: EdgeInsets.only(
                  bottom: kDefaultPadding,
                  left: kDefaultPadding,
                  right: kDefaultPadding),
              height: 2,
              color: Colors.black12,
            ),
            LabelWithActionButton(
              title: "Transaction",
              actionButtonTitle: "",
              press: () {},
              padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding / 2),
            ),
            Transactions()
          ]),
          BottomNavBar(active: MyAccount.routeName)
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Transactions extends StatelessWidget {
  Transactions({
    Key? key,
  }) : super(key: key);

  Future<List<TransactionCard>>? transactionFuture;

  Future<List<TransactionCard>> fetchTransaction() async {
    final response = await http.get(Uri.parse(
        "$HTTPBASEURL/transaction/customer/ac723ce6-11d2-11ec-82a8-0242ac130003"));
    if (response.statusCode == 200) {
      List<dynamic> listResponse = jsonDecode(response.body)['response'];
      List<TransactionCard> transactionList =
          listResponse.map((e) => TransactionCard.fromJson(e)).toList();
      return transactionList;
    } else {
      throw new Exception("failed to load transaction");
    }
  }

  @override
  Widget build(BuildContext context) {
    transactionFuture = this.fetchTransaction();
    return Expanded(
      child: FutureBuilder<List<Widget>>(
        future: transactionFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Widget> list = snapshot.data!.map((e) => e).toList();
            list.add(SizedBox(
              height: 100,
            ));
            return ListView(children: list);
          }
          if (snapshot.hasError) {
            Text("Failed load transaction");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

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
        name: json['detailTransaction'][0]['name'],
        imageUrl: json['detailTransaction'][0]['imageUrl'],
        totalPerProduct: json['detailTransaction'][0]['total'],
        total: json['detailTransaction'].length,
        totalPrice: json['transaction']['totalPrice']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: kDefaultPadding / 4,
          top: kDefaultPadding / 4),
      padding: EdgeInsets.all(kDefaultPadding / 3),
      width: double.infinity,
      height: 100,
      constraints: BoxConstraints(maxHeight: 150),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 8),
                color: kShadownColor.withOpacity(0.23),
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

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: EdgeInsets.only(
          top: 100, left: kDefaultPadding, right: kDefaultPadding),
      child: Column(
        children: [
          Row(children: [
            Container(
              child: Hero(
                child: Image.asset('images/default_user_image_profile.png'),
                tag: "user-profile",
              ),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: kNaturanWhite,
                  borderRadius: BorderRadius.circular(10)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ghazi",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(
                    "ghazi.work@hotmail.com",
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    "021 000 987",
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
            )
          ]),
          Button(
              text: "Edit Profile",
              width: double.infinity,
              height: 29,
              margin:
                  EdgeInsets.only(left: 0, right: 0, top: kDefaultPadding / 2),
              padding: EdgeInsets.all(2),
              textStyle: TextStyle(fontSize: 12, color: Colors.white),
              onTap: () {})
        ],
      ),
    );
  }
}
