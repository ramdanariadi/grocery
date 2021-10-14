import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:grocery/home/BottomNavBar.dart';
import 'package:grocery/home/LabelWIthActionButton.dart';

class Profile extends StatelessWidget {
  static final String routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(children: [
            UserProfile(size: size),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TransactionCard(),
                    TransactionCard(),
                    TransactionCard(),
                    TransactionCard(),
                    TransactionCard(),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            )
          ]),
          BottomNavBar(active: Profile.routeName)
        ],
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
  }) : super(key: key);

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
          Image.asset('images/broccoli.jpeg'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Broccoli",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  "2 pieces",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "+1 product more",
                  style: TextStyle(fontSize: 12),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text: "Total : ",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  TextSpan(
                    text: "\$15",
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
  const UserProfile({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

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
              child: Image.asset('images/default_user_image_profile.png'),
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
              callback: () {})
        ],
      ),
    );
  }
}
