import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/constrant.dart';

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  SearchBar({Key? key, String? search}) : super(key: key) {
    this.search = search;
  }

  String? search;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: 45,
              width: size.width - kDefaultPadding * 2,
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                  color: kNaturanWhite,
                  borderRadius: BorderRadius.circular(kDefaultPadding - 8)),
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: TextFormField(
                        initialValue: search ?? '',
                        decoration: InputDecoration(
                          hintText: "Search",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        onChanged: (text) {
                          search = text;
                        },
                        // autofocus: true,
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        Fluttertoast.showToast(
                            msg: "do search", toastLength: Toast.LENGTH_SHORT);
                      },
                      child: Icon(Icons.search))
                ],
              )),
        ],
      ),
    );
  }
}
