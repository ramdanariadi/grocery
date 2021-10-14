import 'package:flutter/material.dart';
import 'package:grocery/constrant.dart';
import 'package:grocery/custom_widget/Button.dart';

enum Alerts { success }

class Alert extends StatelessWidget {
  final String message;
  final Alerts icon;
  final VoidCallback callback;
  const Alert(
      {required this.icon, required this.message, required this.callback});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/icons/success.png"),
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
          Positioned(
            bottom: 10,
            child: Button(text: "OK", width: size.width - (kDefaultPadding * 2), height: size.height / 11, callback: callback),
          )
        ],
      ),
    );
  }
}