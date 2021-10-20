import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/SearchPage/SearchPage.dart';

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
                    child: SvgPicture.asset(
                      "images/icons/SearchOutline.svg",
                      height: 20,
                      width: 20,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
