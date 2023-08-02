import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/chat/Chat.dart';
import 'package:grocery/chat/ChatItem.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/state_manager/DataState.dart';
import 'package:grocery/state_manager/RouterState.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../constants/Application.dart';

enum ChatStatus { NEW, HISTORY, VOID }

class ChatData<T> {
  final ChatStatus status;
  final T data;

  ChatData({required this.status, required this.data});
}

class ChatRoom extends StatefulWidget {
  static final routeName = '/chatRoom';

  final String recipientName;
  final String recipientId;
  final String recipientImageUrl;
  final String senderId;
  final String senderName;
  final String senderImageUrl;

  ChatRoom(
      {required this.recipientName,
      required this.senderId,
      required this.recipientId,
      required this.recipientImageUrl,
      required this.senderName,
      required this.senderImageUrl});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  List<ChatItem> chatItems = List.empty(growable: true);
  final ScrollController scrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();
  final DataState<ChatData> chatDataState =
      DataState(ChatData<String>(status: ChatStatus.VOID, data: ""));
  late WebSocketChannel _channel;
  int pageSize = 15;
  int pageIndex = 0;
  bool isAllPage = false;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _channel.sink.close();
  }

  @override
  void initState() {
    super.initState();
    _getChatHistory();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.jumpTo(
        scrollController.position.maxScrollExtent,
        // duration: Duration(milliseconds: 500), curve: Curves.easeInOut
      );
    });

    scrollController.addListener(() {
      // debugPrint("scroll controller : " +
      //     scrollController.position.pixels.toString() +
      //     " of " +
      //     scrollController.position.maxScrollExtent.toString() +
      //     " max and " +
      //     scrollController.position.minScrollExtent.toString() +
      //     " min");

      if (scrollController.position.pixels ==
              scrollController.position.minScrollExtent &&
          !isLoading &&
          !isAllPage) {
        _getChatHistory();
      }
    });

    _channel = WebSocketChannel.connect(
        Uri.parse(Application.wsBaseUrl + "/ws/" + widget.senderId));
    _channel.stream.listen((event) {
      debugPrint(event);
      dynamic message = jsonDecode(event);
      chatDataState.add(ChatData<ChatItem>(
          status: ChatStatus.NEW,
          data: ChatItem(
            message: message['message'],
            other: true,
          )));
      scrollController.jumpTo(
        scrollController.position.maxScrollExtent,
        // duration: Duration(milliseconds: 1000), curve: Curves.easeInOut
      );
    });
  }

  Future<void> _getChatHistory() async {
    isLoading = true;
    final response = await HttpRequestService.sendRequest(
        method: HttpMethod.POST,
        url: Application.chatServiceBaseUrl + "/message/history",
        isSecure: false,
        body: {
          "userIdFrom": widget.senderId,
          "userIdTo": widget.recipientId,
          "pageIndex": pageIndex,
          "pageSize": pageSize
        });
    if (response.statusCode == 200) {
      dynamic responseBody = jsonDecode(response.body);
      isAllPage = responseBody['recordsFiltered'] == 0;
      List<dynamic> body = responseBody['data'];
      chatDataState.add(ChatData<List<ChatItem>>(
          status: ChatStatus.HISTORY,
          data: body
              .map((e) => ChatItem(
                    message: e['message'],
                    other: e['from'] != widget.senderId,
                  ))
              .toList()
              .reversed
              .toList()));
      pageIndex++;
      await Future.delayed(Duration(milliseconds: 100));
      isLoading = false;
      scrollController.jumpTo(
        pageIndex == 1 ? scrollController.position.maxScrollExtent : 680,
        // duration: Duration(milliseconds: 1),
        // curve: Curves.linear
      );
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
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    RouterState activeNavbarState = BlocProvider.of<RouterState>(context);
    return Scaffold(
      backgroundColor: ApplicationColor.naturalWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 65,
        backgroundColor: ApplicationColor.naturalWhite,
        elevation: 1,
        leading: ElevatedButton(
            style: ButtonStyle(
                shadowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent)),
            onPressed: () {
              activeNavbarState.go(context: context, baseRoute: Chat.routeName);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 32,
              color: ApplicationColor.blackHint,
            )),
        title: Container(
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      widget.recipientImageUrl,
                    ),
                  ),
                  decoration: BoxDecoration(
                      // color: ApplicationColor.primaryColor,
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
                          widget.recipientName,
                          style: TextStyle(
                              color: ApplicationColor.blackHint,
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
                                  fontSize: 10,
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
          width: size.width,
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
                            chatItems.insertAll(
                                0, snapShot.data!.data as List<ChatItem>);
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
                      controller: textEditingController,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Color.fromRGBO(151, 148, 148, 0.939)),
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                              onTap: () async {
                                String message = jsonEncode({
                                  "sender": widget.senderId,
                                  "senderName": widget.senderName,
                                  "senderImageUrl": widget.senderImageUrl,
                                  "recipient": widget.recipientId,
                                  "recipientName": widget.recipientName,
                                  "recipientImageUrl": widget.recipientImageUrl,
                                  "message": textEditingController.value.text
                                });
                                debugPrint("message : " + message);
                                _channel.sink.add(message);
                                chatDataState.add(ChatData<ChatItem>(
                                    status: ChatStatus.NEW,
                                    data: ChatItem(
                                      message: textEditingController.value.text,
                                      other: false,
                                    )));
                                await Future.delayed(
                                    Duration(milliseconds: 100));
                                scrollController.jumpTo(
                                  scrollController.position.maxScrollExtent,
                                  // duration: Duration(milliseconds: 1),
                                  // curve: Curves.linear
                                );
                                textEditingController.clear();
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
