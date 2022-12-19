import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/constant.dart';

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);

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
                  color: kNaturalWhite,
                  borderRadius: BorderRadius.circular(kDefaultPadding - 8)),
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: TextFormField(
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Search",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        onChanged: (text) {},
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
