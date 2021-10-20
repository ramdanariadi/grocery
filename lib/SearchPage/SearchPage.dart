import 'package:flutter/material.dart';
import 'package:grocery/SearchPage/SearchBar.dart';
import 'package:grocery/constrant.dart';

class SearchPage extends StatelessWidget {
  static String routeName = '/searchpage';
  String? search;

  SearchPage({String? search}) {
    this.search = search;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: kDefaultPadding),
        child: Hero(tag: "searchbar", child: SearchBar(search: this.search)),
      ),
    );
  }
}

class SearchBarArgs {
  String? search;
  SearchBarArgs({String? search}) {
    this.search = search;
  }
}
