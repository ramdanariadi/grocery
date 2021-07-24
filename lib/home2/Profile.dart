import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery/constrant.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      height: size.height * 0.2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Good Morning",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
                Text("Ghazi",
                    style: TextStyle(
                        fontSize: 24,
                        height: 1.8,
                        fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    SvgPicture.asset("images/icons/my_location.svg"),
                    SizedBox(
                      width: 6,
                    ),
                    Text("Tlogomas, Malang",
                        style: TextStyle(fontSize: 14, height: 1.8)),
                  ],
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(8),
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                  color: kNaturanWhite, borderRadius: BorderRadius.circular(8)),
              child: Image.asset("images/default_user_image_profile.png"))
        ],
      ),
    );
  }
}
