import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';
import 'package:flutter_svg/svg.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.17,
      padding: EdgeInsets.all(kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // margin: EdgeInsets.only(bottom: 9),
                  child: Text(
                    "Good Morning",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(bottom: 9),
                  child: Text(
                    "Ghazi",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset("images/icons/my_location.svg"),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Tlogomas, Malang",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(244, 244, 252, 1),
                  borderRadius: BorderRadius.circular(8)),
              child: Image.asset("images/default_user_image_profile.png"))
        ],
      ),
    );
  }
}
