import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(Application.defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: 45,
              width: size.width - Application.defaultPadding * 2,
              padding: EdgeInsets.symmetric(horizontal: Application.defaultPadding),
              decoration: BoxDecoration(
                  color: ApplicationColor.naturalWhite,
                  borderRadius: BorderRadius.circular(Application.defaultPadding - 8)),
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
