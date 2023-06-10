import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:grocery/home/Home.dart';
import 'package:grocery/home/LabelWithActionButton.dart';
import 'package:grocery/profile/EditProfile.dart';
import 'package:grocery/profile/TransactionCard.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/services/UserService.dart';
import 'package:grocery/state_manager/RouterState.dart';

class MyAccount extends StatelessWidget {
  static final String routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(children: [
            UserProfile(),
            Container(
              width: size.width,
              margin: EdgeInsets.only(
                  bottom: Application.defaultPadding,
                  left: Application.defaultPadding,
                  right: Application.defaultPadding),
              height: 2,
              color: Colors.black12,
            ),
            LabelWithActionButton(
              title: "Transaction",
              actionButtonTitle: "",
              press: () {},
              padding: EdgeInsets.only(
                  left: Application.defaultPadding,
                  right: Application.defaultPadding,
                  bottom: Application.defaultPadding / 2),
            ),
            Transactions()
          ]),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Transactions extends StatelessWidget {
  Transactions({
    Key? key,
  }) : super(key: key);

  Future<List<TransactionCard>>? transactionFuture;
  UserService userService = UserService.getInstance();

  Future<List<TransactionCard>> fetchTransaction() async {
    final response = await HttpRequestService.sendRequest(
        method: HttpMethod.GET,
        url: Application.httBaseUrl + "/transaction",
        isSecure: true);

    // debugPrint(response.body);
    if (response.statusCode == 200) {
      List<dynamic> listResponse = jsonDecode(response.body)['data'];
      // debugPrint(listResponse.toString());
      return listResponse.map((e) {
        List<dynamic> products = e['items'];
        Map<String, dynamic> product = {
          "total": products.length,
          "totalPrice": e['priceTotal'],
          "totalPerProduct": products[0]['total'],
          "name": products[0]['name'],
          "imageUrl": products[0]['imageUrl']
        };
        return TransactionCard.fromJson(product);
      }).toList();
    } else {
      throw new Exception("failed to load transaction");
    }
  }

  @override
  Widget build(BuildContext context) {
    transactionFuture = this.fetchTransaction();
    return Expanded(
      child: FutureBuilder<List<TransactionCard>>(
        future: transactionFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint("has data executed");
            List<TransactionCard> list = snapshot.data!;
            // list.add(SizedBox(
            //   height: 100,
            // ));
            return ListView(children: list);
          }

          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return Text("Failed load transaction");
          }

          debugPrint("return circular");
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RouterState rotuerState = BlocProvider.of<RouterState>(context);
    return FutureBuilder<UserProfileDTO>(
        future: UserService.getUserProfile(),
        builder: (context, snapShoot) {
          UserProfileDTO userProfile =
              snapShoot.hasData ? snapShoot.data! : UserProfileDTO();
          return Container(
            height: 220,
            padding: EdgeInsets.only(
                top: 100,
                left: Application.defaultPadding,
                right: Application.defaultPadding),
            child: Column(
              children: [
                Row(children: [
                  Container(
                    child: Hero(
                      child:
                          Image.asset('images/default_user_image_profile.png'),
                      tag: "user-profile",
                    ),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: ApplicationColor.naturalWhite,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                userProfile.name ?? "-",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              Text(
                                userProfile.email ?? "-",
                                style: TextStyle(fontSize: 13),
                              ),
                              Text(
                                userProfile.mobilePhoneNumber ?? "-",
                                style: TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            UserService.logout();
                            rotuerState.go(
                                context: context, baseRoute: Home.routeName);
                          },
                          splashColor: ApplicationColor.naturalWhite,
                          child: Container(
                            width: size.width * 0.1,
                            height: size.width * 0.14,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(
                              Icons.logout_outlined,
                              color: ApplicationColor.blackHint,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
                Button(
                    text: "Edit Profile",
                    width: double.infinity,
                    color: ApplicationColor.primaryColor,
                    height: size.height * 0.04,
                    margin: EdgeInsets.only(
                        left: 0, right: 0, top: Application.defaultPadding / 2),
                    padding: EdgeInsets.all(2),
                    textStyle: TextStyle(fontSize: 12, color: Colors.white),
                    onTap: () {
                      GoRouter.of(context).go(
                          MyAccount.routeName + "/" + EditProfile.routeName);
                    })
              ],
            ),
          );
        });
  }
}
