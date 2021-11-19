import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/SearchPage/SearchPage.dart';

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  String? search;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SearchPage.routeName);
      },
      child: Container(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Search",
                      style: TextStyle(
                          color: Color.fromRGBO(61, 61, 61, 1), fontSize: 14),
                    ),
                    Icon(
                      Icons.search,
                      size: 20,
                    )
                  ],
                )),
            // Container(
            //     margin: EdgeInsets.only(left: kDefaultPadding),
            //     child: SvgPicture.asset("images/icons/Adjustments.svg"))
          ],
        ),
      ),
    );
  }
}
