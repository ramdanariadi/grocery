import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/profile/MyAccount.dart';

class Profile extends StatelessWidget {
  String getGreting() {
    DateTime time = DateTime.now();
    int hour = time.hour;
    if (hour.clamp(12, 18) == hour) {
      return "Good afternoon";
    }

    if (hour.clamp(18, 24) == hour) {
      return "Good evening";
    }

    return "Good morning";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.17,
      padding: EdgeInsets.all(Application.defaultPadding),
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
                    this.getGreting(),
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
                    Icon(
                      Icons.location_on_rounded,
                      size: 22,
                    ),
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
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, MyAccount.routeName);
            },
            child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 244, 252, 1),
                    borderRadius: BorderRadius.circular(8)),
                child: Hero(
                  child: Image.asset("images/default_user_image_profile.png"),
                  tag: "user-profile",
                )),
          )
        ],
      ),
    );
  }
}
