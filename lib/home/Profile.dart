import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/profile/MyAccount.dart';
import 'package:grocery/services/UserService.dart';
import 'package:grocery/state_manager/DataState.dart';
import 'package:grocery/state_manager/RouterState.dart';

class Profile extends StatelessWidget {
  final DataState<String> dataLocationSate = DataState("-");
  final Geolocator location = Geolocator();
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

  Future<bool> _handleLocationPermission() async {
    // flag to indicate gps service enabled status
    bool serviceEnabled = false;
    LocationPermission permissionStatus;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // Fluttertoast.showToast(
    // msg: "gps service is " +
    //     (serviceEnabled ? "enabled" : "disabled, plesae enable"));
    if (!serviceEnabled) {
      return false;
    }

    permissionStatus = await Geolocator.checkPermission();
    if (permissionStatus == LocationPermission.denied) {
      permissionStatus = await Geolocator.requestPermission();
      if (permissionStatus == LocationPermission.denied) {
        // Fluttertoast.showToast(msg: "Location permission denied");
        return false;
      }
      // Fluttertoast.showToast(msg: "Location permission granted");
      return true;
    }

    if (permissionStatus == LocationPermission.deniedForever) {
      // Fluttertoast.showToast(msg: "Location permission denied forever");
    }
    // Fluttertoast.showToast(msg: "Location permission granted");
    return true;
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
          }

          userInfo.add(StreamBuilder(
            stream: dataLocationSate.stream,
            builder: (context, snapShot) => Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 22,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  snapShot.hasData ? snapShot.data!.toString() : "-",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ));

          _handleLocationPermission().then((value) async {
            Position currentLocation = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            placemarkFromCoordinates(
                    currentLocation.latitude, currentLocation.longitude)
                .then((value) {
              List<Placemark> placemarks = value;
              if (!placemarks.isEmpty) {
                Placemark placemark = placemarks[0];
                String place =
                    placemark.administrativeArea ?? placemark.country ?? "";
                UserService user = UserService.getInstance();
                user.address = place;
                dataLocationSate.add(place);
              } else {
                dataLocationSate.add(currentLocation.latitude.toString());
              }
            }).catchError((e) {
              debugPrint(e.toString());
            });
          }).catchError((e) {
            debugPrint(e.toString());
          });
          RouterState activeNavbarState = BlocProvider.of<RouterState>(context);
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
