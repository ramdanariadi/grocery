import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery/constant.dart';

class Register extends StatefulWidget {
  static String routeName = '/register';

  @override
  State<Register> createState() => _LoginState();
}

class _LoginState extends State<Register> {
  bool showPassword = false;

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

    // textfield controller
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

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
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign up",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: Text(
                  "Create an account here",
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
                child: TextField(
                  controller: passwordController,
                  cursorColor: focusColor,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: outlineColor, width: 1.5)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: focusColor, width: 1.5)),
                    prefixIcon: Container(
                      child: Icon(
                        Icons.phone_iphone,
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
                    hintText: "Mobile Number",
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
                child: TextField(
                  cursorColor: focusColor,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: outlineColor, width: 1.5)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: focusColor, width: 1.5)),
                    prefixIcon: Container(
                      child: Icon(
                        Icons.email_outlined,
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
                    hintText: "Email",
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
                child: TextField(
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
                          debugPrint("show password");
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(
                          !showPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
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
                    margin: EdgeInsets.only(top: 40),
                    child: Ink(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                          color: kPrimaryColor, shape: BoxShape.circle),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(64),
                        onTap: () {
                          Fluttertoast.showToast(
                              msg: "${usernameController.text}");
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
                margin: EdgeInsets.only(top: 40),
                child: Row(children: [
                  Text("Already member? ", style: TextStyle(color: hintColor)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text("Sign in",
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
