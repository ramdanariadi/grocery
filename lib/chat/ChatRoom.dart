import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery/chat/ChatItem.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/state_manager/DataState.dart';
import 'package:grocery/state_manager/PaginationState.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../constants/Application.dart';

class ChatRoom extends StatefulWidget {
  static final routeName = '/chatRoom';

  final String shopName;
  final String shopId;
  final String userId;

  ChatRoom(
      {required this.shopName, required this.userId, required this.shopId});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

enum ChatStatus { NEW, HISTORY, VOID }

class ChatData<T> {
  final ChatStatus status;
  final T data;

  ChatData({required this.status, required this.data});
}

class _ChatRoomState extends State<ChatRoom> {
  List<ChatItem> chatItems = List.empty(growable: true);
  ScrollController scrollController = ScrollController();
  DataState<ChatData> chatDataState =
      DataState(ChatData<String>(status: ChatStatus.VOID, data: ""));
  late WebSocketChannel _channel;
  int pageSize = 15;
  int pageIndex = 0;

  @override
  void dispose() {
    super.dispose();
    _channel.sink.close();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    });

    scrollController.addListener(() {
      debugPrint("scroll controller : " +
          scrollController.position.pixels.toString() +
          " of " +
          scrollController.position.maxScrollExtent.toString() +
          " max and " +
          scrollController.position.minScrollExtent.toString() +
          " min");

      if (scrollController.position.pixels ==
          scrollController.position.minScrollExtent) {
        _getChatHistory();
      }
    });

    _channel = WebSocketChannel.connect(
        Uri.parse(Application.wsBaseUrl + "/ws/" + widget.userId));
    _channel.stream.listen((event) {
      debugPrint(event);
      dynamic message = jsonDecode(event);
      chatDataState.add(ChatData<ChatItem>(
          status: ChatStatus.NEW,
          data: ChatItem(
            message: message['message'],
            other: true,
          )));
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  Future<void> _getChatHistory() async {
    debugPrint("_getChatHistory");
    final response = await HttpRequestService.sendRequest(
        method: HttpMethod.POST,
        url: Application.chatServiceBaseUrl + "/message/history",
        isSecure: false,
        body: {
          "userIdFrom": widget.userId,
          "userIdTo": widget.shopId,
          "pageIndex": pageIndex,
          "pageSize": pageSize
        });
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      chatDataState.add(ChatData<List<ChatItem>>(
          status: ChatStatus.HISTORY,
          data: body
              .map((e) => ChatItem(
                    message: e['message'],
                    other: e['from'] != widget.userId,
                  ))
              .toList()));
      Future.delayed(Duration(milliseconds: 500)).then((value) => {
            scrollController.animateTo(
                pageIndex == 0
                    ? scrollController.position.maxScrollExtent
                    : 367,
                duration: Duration(milliseconds: 100),
                curve: Curves.easeInOut)
          });
      pageIndex++;
    }
    // chatDataState.add(ChatData<List<ChatItem>>(
    //     status: ChatStatus.HISTORY,
    //     data: List<ChatItem>.of(<ChatItem>[
    //       ChatItem(message: "message"),
    //       ChatItem(message: "message"),
    //       ChatItem(message: "message")
    //     ])));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _getChatHistory();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      backgroundColor: ApplicationColor.naturalWhite,
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: ApplicationColor.naturalWhite,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1,
                      color: ApplicationColor.shadowColor.withOpacity(0.2)))),
          child: Container(
            height: double.infinity,
            padding: EdgeInsets.only(
                top: Application.defaultPadding * 1.2,
                right: Application.defaultPadding,
                left: Application.defaultPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios_new, size: 32)),
                Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.only(left: 12.5),
                  decoration: BoxDecoration(
                      color: ApplicationColor.primaryColor,
                      borderRadius: BorderRadius.circular(50)),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.shopName,
                          style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Active Now",
                              style: TextStyle(
                                  color: Color.fromRGBO(197, 196, 196, 1)),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 4),
                              child: Icon(
                                Icons.circle,
                                size: 8,
                                color: ApplicationColor.primaryColor
                                    .withAlpha(210),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 75,
                      left: Application.defaultPadding / 2,
                      right: Application.defaultPadding / 2),
                  child: StreamBuilder<ChatData>(
                    stream: chatDataState.stream,
                    builder: (context, snapShot) {
                      if (snapShot.hasData) {
                        debugPrint("snapshot data : ");
                        switch (snapShot.data!.status) {
                          case ChatStatus.NEW:
                            chatItems.add(snapShot.data!.data);
                            break;
                          case ChatStatus.HISTORY:
                            List<ChatItem> temp = chatItems;
                            chatItems = (snapShot.data!.data as List<ChatItem>);
                            chatItems.addAll(temp);
                            break;
                          case ChatStatus.VOID:
                        }
                      }
                      return Column(
                        children: chatItems,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  color: ApplicationColor.naturalWhite,
                  padding: EdgeInsets.only(
                      top: Application.defaultPadding / 2,
                      right: Application.defaultPadding,
                      bottom: Application.defaultPadding / 2,
                      left: Application.defaultPadding),
                  width: size.width,
                  child: Container(
                    padding: EdgeInsets.only(top: 6, bottom: 4, left: 23),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: Color.fromARGB(255, 238, 238, 238)),
                    child: TextField(
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Color.fromRGBO(151, 148, 148, 0.939)),
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: () {
                                String message = jsonEncode({
                                  "sender": widget.userId,
                                  "recipient": widget.shopId,
                                  "message": "hiii"
                                });
                                debugPrint("message : " + message);
                                _channel.sink.add(message);

                                // chatDataState.add(ChatData<List<ChatItem>>(
                                //     status: ChatStatus.HISTORY,
                                //     data: List<ChatItem>.of(<ChatItem>[
                                //       ChatItem(message: "message history"),
                                //       ChatItem(message: "message history")
                                //     ])));
                              },
                              child: Icon(
                                Icons.send_rounded,
                                color: Color.fromRGBO(188, 185, 185, 0.79),
                              )),
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Color.fromRGBO(188, 185, 185, 0.79)),
                          hintText: "Send Message",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatRoomArg {
  final String shopName;
  final String shopId;
  final String userId;

  ChatRoomArg(
      {required this.shopName, required this.userId, required this.shopId});
}
