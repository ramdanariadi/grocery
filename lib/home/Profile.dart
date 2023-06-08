import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/profile/MyAccount.dart';
import 'package:grocery/services/UserService.dart';
import 'package:grocery/state_manager/RouterState.dart';

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
    return FutureBuilder<UserProfileDTO>(
        future: UserService.getUserProfile(),
        builder: (context, snapShot) {
          UserProfileDTO userProfile =
              snapShot.hasData ? snapShot.data! : UserProfileDTO();
          List<Widget> userInfo = [
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
          ];
          if (userProfile.isAuthenticated) {
            if (userProfile.name != null) {
              userInfo.add(Container(
                // margin: EdgeInsets.only(bottom: 9),
                child: Text(
                  userProfile.name!,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ));
            }
            if (userProfile.email != null) {
              userInfo.add(Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 22,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    userProfile.email ?? "-",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ],
              ));
            }
          }
          RotuerState activeNavbarState = BlocProvider.of<RotuerState>(context);
          return Container(
            padding: EdgeInsets.all(Application.defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: userInfo,
                  ),
                ),
                InkWell(
                  onTap: () {
                    activeNavbarState.go(
                        context: context, baseRoute: MyAccount.routeName);
                  },
                  child: Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 244, 252, 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Hero(
                        child: Image.asset(
                            "images/default_user_image_profile.png"),
                        tag: "user-profile",
                      )),
                )
              ],
            ),
          );
        });
  }
}
