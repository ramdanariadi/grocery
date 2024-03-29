import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/chat/ChatRoom.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/custom_widget/Button.dart';
import 'package:grocery/home/Home.dart';
import 'package:grocery/profile/Login.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/services/RestClient.dart';
import 'package:grocery/services/UserService.dart';
import 'package:grocery/state_manager/CounterState.dart';
import 'package:grocery/state_manager/GenericState.dart';
import 'package:logger/logger.dart';

class ProductDetail extends StatefulWidget {
  static final routeName = 'detailProduct';

  final String id;
  final String tag;
  final String merk;
  final String category;
  final int weight;
  final int price;
  final String shopId;
  final String shopName;
  final String? imageUrl;

  ProductDetail(
      {Key? key,
      required this.id,
      required this.tag,
      required this.merk,
      required this.category,
      required this.weight,
      required this.price,
      required this.shopId,
      required this.shopName,
      this.imageUrl})
      : super(key: key);

  @override
  _ProductDetail createState() {
    return _ProductDetail();
  }
}

class _ProductDetail extends State<ProductDetail> {
  int _count = 1;
  bool productLoved = false;
  bool widgetExist = true;
  CounterState _counterState = CounterState();
  DataProviderState<bool> _likedState = DataProviderState();
  UserService userService = UserService.getInstance();

  _ProductDetail();
  final logger = Logger();

  Future<void> like() async {
    if (!await UserService.isAuthenticated())
      GoRouter.of(context).go(Login.routeName);
    RestClient restClient =
        RestClient(await HttpRequestService.getDio(isSecure: true));
    if (productLoved) {
      debugPrint("remove from wislist");
      restClient.removeFromWishlist(widget.id).then((value) {
        if (widgetExist) {
          productLoved = !productLoved;
          _likedState.eventSink.add(productLoved);
          Fluttertoast.showToast(
              msg: productLoved ? 'loved it' : 'unloved it',
              toastLength: Toast.LENGTH_LONG);
        }
      }).catchError((obj) {
        switch (obj.runtimeType) {
          case DioException:
            final res = (obj as DioException).response;
            logger.e("Got error : ${res!.statusCode} -> ${res.statusMessage}");
            break;
          default:
            break;
        }
      });
    } else {
      debugPrint("ADD to wislist");
      restClient.addToWishlist(widget.id).then((value) {
        if (widgetExist) {
          productLoved = !productLoved;
          _likedState.eventSink.add(productLoved);
          Fluttertoast.showToast(
              msg: productLoved ? 'loved it' : 'unloved it',
              toastLength: Toast.LENGTH_LONG);
        }
      }).catchError((obj) {
        switch (obj.runtimeType) {
          case DioException:
            final res = (obj as DioException).response;
            logger.e("Got error : ${res!.statusCode} -> ${res.statusMessage}");
            break;
          default:
            break;
        }
      });
    }
  }

  Future<void> addToCart() async {
    if (!await UserService.isAuthenticated())
      GoRouter.of(context).go(Login.routeName);

    RestClient restClient =
        RestClient(await HttpRequestService.getDio(isSecure: true));
    restClient.addToCart(productId: widget.id, total: _count).then((value) {
      if (widgetExist) {
        GoRouter.of(context).go(Home.routeName);
      }
    }).catchError((obj) {
      Fluttertoast.showToast(msg: "opps something wrong");
      switch (obj.runtimeType) {
        case DioException:
          final res = (obj as DioException).response;
          logger.e("Got error : ${res!.statusCode} -> ${res.statusMessage}");
          break;
        default:
          break;
      }
    });
  }

  Future<void> isLiked() async {
    if (!await UserService.isAuthenticated()) return;
    RestClient restClient =
        RestClient(await HttpRequestService.getDio(isSecure: true));
    restClient.getWishListByProduct(widget.id).then((value) {
      debugPrint("success");
      if (widgetExist) {
        productLoved = true;
        _likedState.eventSink.add(true);
      }
    }).catchError((obj) {
      switch (obj.runtimeType) {
        case DioException:
          final res = (obj as DioException).response;
          logger.e("Got error : ${res!.statusCode} -> ${res.statusMessage}");
          break;
        default:
          break;
      }
      if (widgetExist) {
        productLoved = false;
        _likedState.eventSink.add(false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.isLiked();
  }

  @override
  void dispose() {
    super.dispose();
    widgetExist = false;
    _counterState.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          padding: EdgeInsets.only(
              top: Application.defaultPadding,
              right: Application.defaultPadding,
              bottom: Application.defaultPadding,
              left: Application.defaultPadding),
          child: Stack(children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pop();
                          },
                          child: Icon(Icons.arrow_back_ios_new, size: 32)),
                      GestureDetector(
                        onTap: () {
                          // Fluttertoast.showToast(
                          //     msg: 'loved it ${widget.merk}',
                          //     toastLength: Toast.LENGTH_LONG);
                        },
                        child: GestureDetector(
                          child: Container(
                              margin: EdgeInsets.only(right: 8),
                              child: StreamBuilder(
                                initialData: false,
                                stream: _likedState.stream,
                                builder: (context, snapshot) => snapshot.data
                                        as bool
                                    ? Icon(Icons.favorite,
                                        size: 30, color: Colors.red)
                                    : Icon(Icons.favorite_outline, size: 30),
                              )),
                          onTap: () {
                            this.like();
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      widget.merk,
                      style: TextStyle(
                          color: ApplicationColor.textColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 30),
                    child: Text(
                      widget.category,
                      style: TextStyle(
                          color: ApplicationColor.shadowColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: size.width * 0.7),
                    child: Hero(
                        tag: widget.tag,
                        child: widget.imageUrl == null
                            ? Image.asset('images/notFound.png')
                            : Image.network(widget.imageUrl!)),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 28),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "\$${widget.price}",
                            style: TextStyle(
                                height: 2,
                                fontSize: 24,
                                color: ApplicationColor.blackHint,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " /kg",
                            style: TextStyle(
                                height: 2,
                                fontSize: 24,
                                color: ApplicationColor.blackHint)),
                      ]),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            _counterState.eventSink
                                .add(CounterAction.decreament);
                          },
                          child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                  color: ApplicationColor.shadowColor
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(Icons.remove, size: 30))),
                      SizedBox(
                        width: 25,
                      ),
                      StreamBuilder(
                        stream: _counterState.stateStream,
                        initialData: 0,
                        builder: (context, snapshot) {
                          _count = snapshot.data as int;
                          return Text(
                            '${snapshot.data}',
                            style: TextStyle(
                                fontSize: 24,
                                color: ApplicationColor.blackHint,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      InkWell(
                          onTap: () {
                            _counterState.eventSink
                                .add(CounterAction.increament);
                          },
                          child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                  color: ApplicationColor.shadowColor
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                Icons.add,
                                size: 30,
                              ))),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width - Application.defaultPadding * 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FutureBuilder<UserProfileDTO>(
                        future: UserService.getUserProfile(),
                        builder: (context, snapShot) {
                          if (!snapShot.hasData) return Spacer();
                          return InkWell(
                              onTap: () async {
                                if (!await UserService.isAuthenticated()) {
                                  GoRouter.of(context).go(Login.routeName);
                                } else {
                                  GoRouter.of(context).go(ChatRoom.routeName,
                                      extra: ChatRoom(
                                        senderId: snapShot.data!.userId!,
                                        senderName: snapShot.data!.username!,
                                        senderImageUrl:
                                            "https://crewdible-pub.s3.ap-southeast-1.amazonaws.com/blog/buyer%20adalah.jpeg",
                                        recipientName: widget.shopName,
                                        recipientId: widget.shopId,
                                        recipientImageUrl:
                                            "https://tunas-grocery.s3.ap-southeast-1.amazonaws.com/images/app-icon.png",
                                      ));
                                }
                              },
                              child: Container(
                                  padding: EdgeInsets.all(
                                      Application.defaultPadding / 2),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ApplicationColor.primaryColor,
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Icon(
                                    Icons.wechat,
                                    color: ApplicationColor.primaryColor,
                                  )));
                        }),
                    Button(
                        color: ApplicationColor.primaryColor,
                        margin: EdgeInsets.all(0),
                        child: Text(
                          'Add to cart',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w200),
                        ),
                        width: size.width - Application.defaultPadding * 4.4,
                        height: size.height / 11,
                        onTap: () {
                          this.addToCart();
                        }),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
