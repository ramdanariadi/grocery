import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';

enum Alerts { success }

class Alert extends StatelessWidget {
  final String message;
  final Alerts icon;
  final VoidCallback callback;
  const Alert(
      {required this.icon,
      required this.message,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset("images/icons/success.png"),
          ),
          Positioned(
            bottom: 10,
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.all(kDefaultPadding),
                width: size.width - (kDefaultPadding * 2),
                height: size.height / 11,
                padding: EdgeInsets.all(kDefaultPadding),
                child: Center(
                  child: Text(
                    "OK",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                ),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(8)),
              ),
              onTap: this.callback,
            ),
          )
        ],
      ),
    );
  }
}
