import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery/constrant.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        padding: EdgeInsets.only(
            top: kDefaultPadding * 1.4,
            right: kDefaultPadding,
            bottom: kDefaultPadding,
            left: kDefaultPadding),
        color: kNaturanWhite,
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'images/icons/ChevronLeftOutline.svg',
                        height: size.width / 10,
                        width: size.width / 10,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: "loved it", toastLength: Toast.LENGTH_LONG);
                      },
                      child: SvgPicture.asset(
                        'images/icons/HeartOutline.svg',
                        height: size.width / 10,
                        width: size.width / 10,
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    "Brocilli",
                    style: TextStyle(
                        color: kTextColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 30),
                  child: Text(
                    "Vegetables",
                    style: TextStyle(
                        color: kShadownColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w200),
                  ),
                ),
                Image.asset('images/broccoli.jpeg'),
                Container(
                  margin: EdgeInsets.only(bottom: 28),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "\$4",
                          style: TextStyle(
                              height: 2,
                              fontSize: 24,
                              color: kBlackHint,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " /kg",
                          style: TextStyle(
                              height: 2, fontSize: 24, color: kBlackHint)),
                    ]),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset('images/icons/minus.svg')),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "5",
                      style: TextStyle(
                          fontSize: 24,
                          color: kBlackHint,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    SvgPicture.asset('images/icons/plus.svg'),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              width: size.width - (kDefaultPadding * 2),
              height: size.height / 11,
              padding: EdgeInsets.all(kDefaultPadding),
              child: Center(
                child: Text(
                  "Add to cart",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w200),
                ),
              ),
              decoration: BoxDecoration(
                  color: kPrimaryColor, borderRadius: BorderRadius.circular(8)),
            ),
          )
        ]),
      ),
    );
  }
}
