import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/search_page/SearchPage.dart';
import 'package:grocery/state_manager/RouterState.dart';

// ignore: must_be_immutable
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RouterState routerState = BlocProvider.of<RouterState>(context);
    return GestureDetector(
      onTap: () {
        routerState.go(context: context, baseRoute: SearchPage.routeName);
      },
      child: Container(
        padding: EdgeInsets.all(Application.defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 45,
                width: size.width - Application.defaultPadding * 2,
                padding: EdgeInsets.symmetric(
                    horizontal: Application.defaultPadding),
                decoration: BoxDecoration(
                    color: ApplicationColor.naturalWhite,
                    borderRadius:
                        BorderRadius.circular(Application.defaultPadding - 8)),
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
            //     margin: EdgeInsets.only(left: Application.defaultPadding),
            //     child: SvgPicture.asset("images/icons/Adjustments.svg"))
          ],
        ),
      ),
    );
  }
}
