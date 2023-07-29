import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/alert/Alert.dart';
import 'package:grocery/chart/Cart.dart';
import 'package:grocery/chat/Chat.dart';
import 'package:grocery/chat/ChatRoom.dart';
import 'package:grocery/custom_widget/ScaffoldBottomActionBar.dart';
import 'package:grocery/home/Home.dart';
import 'package:grocery/product/ProductCard.dart';
import 'package:grocery/product/ProductDetail.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/profile/EditProfile.dart';
import 'package:grocery/profile/Login.dart';
import 'package:grocery/profile/MyAccount.dart';
import 'package:grocery/profile/Register.dart';
import 'package:grocery/search_page/SearchPage.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/services/UserService.dart';
import 'package:grocery/state_manager/CartState.dart';
import 'package:grocery/state_manager/ChatState.dart';
import 'package:grocery/state_manager/RouterState.dart';
import 'constants/Application.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> _rootNavigatorKey =
        GlobalKey<NavigatorState>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<RouterState>(create: (context) => RouterState(0)),
        BlocProvider<CartState>(create: (context) => CartState(0)),
        BlocProvider<ChatState>(create: (context) => ChatState(0))
      ],
      child: TheApp(rootNavigatorKey: _rootNavigatorKey),
    );
  }
}

class TheApp extends StatelessWidget {
  TheApp({
    Key? key,
    required GlobalKey<NavigatorState> rootNavigatorKey,
  })  : _rootNavigatorKey = rootNavigatorKey,
        super(key: key);

  final GlobalKey<NavigatorState> _rootNavigatorKey;

  Future init(ChatState chatState, CartState cartState) async {
    if (await UserService.isAuthenticated()) {
      final UserProfileDTO profileDTO = await UserService.getUserProfile();
      final getChatResponse = await HttpRequestService.sendRequest(
          method: HttpMethod.POST,
          url: Application.chatServiceBaseUrl + "/message/history/user",
          body: {"userId": profileDTO.userId!, "pageIndex": 0, "pageSize": 20},
          isSecure: false);
      if (200 == getChatResponse.statusCode) {
        final List<dynamic> data = jsonDecode(getChatResponse.body)['data'];
        chatState.add(data.length);
      }

      final getCartResponse = await HttpRequestService.sendRequest(
          method: HttpMethod.GET,
          url: Application.httBaseUrl + '/cart',
          isSecure: true);

      if (getCartResponse.statusCode == 200) {
        List<dynamic> cart = jsonDecode(getCartResponse.body)['data'];
        cartState.add(cart.length);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    init(BlocProvider.of<ChatState>(context),
        BlocProvider.of<CartState>(context));
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routerConfig: GoRouter(
            navigatorKey: _rootNavigatorKey,
            initialLocation: Home.routeName,
            routes: [
              ShellRoute(
                  builder: (context, state, child) => ScaffoldBottomActionBar(
                        child: child,
                      ),
                  routes: [
                    /* Home route */
                    GoRoute(
                        path: Home.routeName,
                        builder: (context, state) => Home()),
                    /* Products route */
                    GoRoute(
                        path: Products.routeName,
                        builder: (context, state) => Products(),
                        routes: [
                          GoRoute(
                            path: ProductGroupGridItems.routeName,
                            builder: (context, state) {
                              Map<String, dynamic> param =
                                  state.extra as Map<String, dynamic>;
                              return ProductGroupGridItems(
                                title: param["title"]!,
                                url: param["url"],
                              );
                            },
                          ),
                          GoRoute(
                            path: ProductDetail.routeName,
                            builder: (context, state) {
                              ProductArguments arguments =
                                  state.extra as ProductArguments;
                              return ProductDetail(
                                id: arguments.id,
                                shopId: arguments.shopId,
                                shopName: arguments.shopName,
                                tag: arguments.tag,
                                merk: arguments.merk,
                                category: arguments.category,
                                weight: arguments.weight,
                                price: arguments.price,
                                imageUrl: arguments.imageUrl,
                              );
                            },
                          ),
                          GoRoute(
                              path: SearchPage.routeName,
                              builder: (context, state) => SearchPage()),
                        ]),
                    /* Cart route */
                    GoRoute(
                        path: Cart.routeName,
                        builder: (context, state) => Cart()),
                    /* Profile route */
                    GoRoute(
                        path: MyAccount.routeName,
                        builder: (context, state) => MyAccount(),
                        routes: [
                          GoRoute(
                              path: EditProfile.routeName,
                              builder: (context, state) {
                                return EditProfile();
                              })
                        ]),
                    /* Chat Route */
                    GoRoute(
                      path: Chat.routeName,
                      builder: (context, state) => Chat(),
                    ),
                  ]),
              /* Login router */
              GoRoute(
                  path: Login.routeName, builder: (context, state) => Login()),
              GoRoute(
                  path: Register.routeName,
                  builder: ((context, state) => Register())),
              /* Alert router */
              GoRoute(
                  path: Alert.routeName,
                  builder: (context, state) => state.extra as Alert),
              /* Chat Room Route */
              GoRoute(
                  path: ChatRoom.routeName,
                  builder: (context, state) => state.extra as ChatRoom)
            ]));
  }
}
