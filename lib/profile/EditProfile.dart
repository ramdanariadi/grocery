import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:grocery/services/HttpRequestService.dart';

class EditProfile extends StatelessWidget{
  static final String routeName = "editProfile";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color outlineColor = Color.fromRGBO(192, 199, 208, 1);
    Color prefixIconColor = Color.fromRGBO(0, 24, 51, 0.6);
    Color hintColor = Color.fromRGBO(193, 199, 208, 1);
    Color focusColor = Color.fromRGBO(143, 146, 151, 1);

    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController mobilePhoneNumberController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(onPressed: (){
          GoRouter.of(context).pop();
        }, icon: Icon(Icons.arrow_back, color: Colors.black,)),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.symmetric(horizontal: Application.defaultPadding * 2),
        decoration: BoxDecoration(color: Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("Edit Profile", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),),
          SizedBox(height: size.height * 0.1),
          Container(
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: outlineColor)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: focusColor, width:1.5),
                ),
                prefixIcon: Container(
                  child: Icon(
                    Icons.alternate_email_outlined, 
                    color: prefixIconColor,
                  ),
                  padding: EdgeInsets.only(right: 9),
                  margin: EdgeInsets.only(right: 19, bottom: 3.5),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: outlineColor,
                        width: 1.5
                      )
                    )
                  ),
                ),
                hintText: "Username",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: hintColor,
                  letterSpacing: -0.2
                )
              ),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: focusColor.withOpacity(0.7),
                letterSpacing: -0.2
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.015),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: outlineColor)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: focusColor, width:1.5),
                ),
                prefixIcon: Container(
                  child: Icon(
                    Icons.email_outlined, 
                    color: prefixIconColor,
                  ),
                  padding: EdgeInsets.only(right: 9),
                  margin: EdgeInsets.only(right: 19, bottom: 3.5),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: outlineColor,
                        width: 1.5
                      )
                    )
                  ),
                ),
                hintText: "Email",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: hintColor,
                  letterSpacing: -0.2
                )
              ),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: focusColor.withOpacity(0.7),
                letterSpacing: -0.2
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.015),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: outlineColor)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: focusColor, width:1.5),
                ),
                prefixIcon: Container(
                  child: Icon(
                    Icons.person_outline_sharp, 
                    color: prefixIconColor,
                  ),
                  padding: EdgeInsets.only(right: 9),
                  margin: EdgeInsets.only(right: 19, bottom: 3.5),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: outlineColor,
                        width: 1.5
                      )
                    )
                  ),
                ),
                hintText: "Name",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: hintColor,
                  letterSpacing: -0.2
                )
              ),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: focusColor.withOpacity(0.7),
                letterSpacing: -0.2
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.015),
            child: TextField(
              controller: mobilePhoneNumberController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: outlineColor)
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: focusColor, width:1.5),
                ),
                prefixIcon: Container(
                  child: Icon(
                    Icons.local_phone_rounded, 
                    color: prefixIconColor,
                  ),
                  padding: EdgeInsets.only(right: 9),
                  margin: EdgeInsets.only(right: 19, bottom: 3.5),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: outlineColor,
                        width: 1.5
                      )
                    )
                  ),
                ),
                hintText: "Mobile",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: hintColor,
                  letterSpacing: -0.2
                )
              ),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: focusColor.withOpacity(0.7),
                letterSpacing: -0.2
              ),
            ),
          ),
          Container(
            child: Button(
              text: "Save",
              width: double.infinity,
              color: ApplicationColor.primaryColor,
              height: size.height * 0.06,
              margin: EdgeInsets.only(left: 0, right: 0, top: Application.defaultPadding / 1.8),
              padding: EdgeInsets.all(2),
              textStyle: TextStyle(fontSize: 16, color: Colors.white),
              onTap: () async {
                Map<String, String> body = {"email": emailController.text, "username": usernameController.text, "name": nameController.text, "mobilePhoneNumber": mobilePhoneNumberController.text};
                final response = await HttpRequestService.sendRequest(method: HttpMethod.PUT, url: Application.httBaseUrl + "/user", body: body, isSecure: true);
                if(response.statusCode == 200){
                  GoRouter.of(context).pop();
                }else{
                  Map<String, dynamic> jsonResponse = jsonDecode(response.body);
                  Fluttertoast.showToast(msg: jsonResponse['message']);
                }
              })
            ),
        ]),
      ),
    );
  }

}