import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:grocery/state_manager/RouterState.dart';

enum Alerts { success }

class Alert extends StatelessWidget {
  static final routeName = "/alert";

  final String message;
  final Alerts icon;
  final String routeToClose;
  final Image iconImage = Image.asset("images/icons/success.png");
  Alert(
      {required this.icon, required this.message, required this.routeToClose});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final RouterState routerState = BlocProvider.of<RouterState>(context);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: Application.defaultPadding * 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconImage,
                  Container(
                    margin: EdgeInsets.only(top: 28),
                    child: Text(
                      this.message,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(67, 67, 67, 1)),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Center(
              child: Button(
                  margin: EdgeInsets.all(Application.defaultPadding),
                  color: ApplicationColor.primaryColor,
                  child: Text(
                    'OK',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                  width: size.width - (Application.defaultPadding * 2),
                  height: size.height / 11,
                  onTap: () {
                    routerState.go(context: context, baseRoute: routeToClose);
                  }),
            ),
          )
        ],
      ),
    );
  }
}
