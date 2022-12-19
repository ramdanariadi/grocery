import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/HttpRequestService.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/profile/MyAccount.dart';
import 'package:grocery/profile/Register.dart';

class Login extends StatefulWidget {
  static final String routeName = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showPassword = false;

  // textfield controller
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    Color outlineColor = Color.fromRGBO(192, 199, 208, 1);
    Color prefixIconColor = Color.fromRGBO(0, 24, 51, 0.6);
    Color hintColor = Color.fromRGBO(193, 199, 208, 1);
    Color focusColor = Color.fromRGBO(143, 146, 151, 1);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Application.defaultPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign in",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: Text(
                  "Welcome back",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 60),
                child: TextField(
                  controller: usernameController,
                  cursorColor: focusColor,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: outlineColor, width: 1.5)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: focusColor, width: 1.5)),
                    prefixIcon: Container(
                      child: Icon(
                        Icons.person_outline_sharp,
                        color: prefixIconColor,
                      ),
                      padding: EdgeInsets.only(right: 9),
                      margin: EdgeInsets.only(right: 19, bottom: 3.5),
                      height: 10,
                      decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(color: outlineColor, width: 1.5)),
                      ),
                    ),
                    hintText: "Username",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: hintColor,
                        letterSpacing: -0.2),
                  ),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: focusColor.withOpacity(0.7),
                      letterSpacing: -0.2),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: !showPassword,
                  cursorColor: focusColor,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: outlineColor, width: 1.5)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: focusColor, width: 1.5)),
                      prefixIcon: Container(
                        child: Icon(
                          Icons.lock_outline,
                          color: prefixIconColor,
                        ),
                        padding: EdgeInsets.only(right: 9),
                        margin: EdgeInsets.only(right: 19, bottom: 3.5),
                        height: 10,
                        decoration: BoxDecoration(
                          border: Border(
                              right:
                                  BorderSide(color: outlineColor, width: 1.5)),
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: !showPassword
                            ? Icon(
                                Icons.visibility_off_outlined,
                                color: prefixIconColor,
                              )
                            : Icon(
                                Icons.visibility_outlined,
                                color: prefixIconColor,
                              ),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: hintColor,
                          letterSpacing: -0.2)),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: focusColor.withOpacity(0.7),
                      letterSpacing: -0.2),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 179),
                    child: Ink(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                          color: ApplicationColor.primaryColor, shape: BoxShape.circle),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(64),
                        onTap: () async {
                          Fluttertoast.showToast(
                              msg:
                                  "${usernameController.text} - ${passwordController.text}");
                          bool authenticated = await HttpRequestService.login(
                              usernameController.text, passwordController.text);
                          if (authenticated) {
                            Navigator.popAndPushNamed(
                                context, MyAccount.routeName);
                          } else {
                            Fluttertoast.showToast(msg: "not authenticated");
                          }
                        },
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 60),
                child: Row(children: [
                  Text("New member? ", style: TextStyle(color: hintColor)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Register.routeName);
                    },
                    child: Text("Sign up",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
