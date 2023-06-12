import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/search_page/SearchBar.dart' as CustomSearchBar;

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  static String routeName = 'searchpage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: Application.defaultPadding),
        child: CustomSearchBar.SearchBar(),
      ),
    );
  }
}
