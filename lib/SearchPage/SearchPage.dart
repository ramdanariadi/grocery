import 'package:flutter/material.dart';
import 'package:grocery/SearchPage/SearchBar.dart';
import 'package:grocery/constant.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  static String routeName = '/searchpage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: kDefaultPadding),
        child: SearchBar(),
      ),
    );
  }
}
