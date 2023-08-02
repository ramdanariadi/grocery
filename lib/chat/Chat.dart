import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/chat/ChatRoom.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/services/HttpRequestService.dart';
import 'package:grocery/services/UserService.dart';
import 'package:grocery/state_manager/ChatState.dart';
import 'package:grocery/state_manager/DataState.dart';
import 'package:grocery/state_manager/RouterState.dart';
import 'package:intl/intl.dart';

class UserDTO {
  final String senderId;
  final String senderName;
  final String senderImageUrl;
  final String recipientId;
  final String recipientName;
  final String recipientImageUrl;
  final String lastMessage;
  final int date;

  UserDTO(
      {required this.senderId,
      required this.senderName,
      required this.senderImageUrl,
      required this.recipientId,
      required this.recipientName,
      required this.recipientImageUrl,
      required this.lastMessage,
      required this.date});
}

class Chat extends StatefulWidget {
  static final routeName = '/chat';

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final DataState<List<UserDTO>> userListStae = DataState(List.empty());
  late ChatState chatState;

  Future<void> _getUserHistory() async {
    final UserProfileDTO profileDTO = await UserService.getUserProfile();
    final response = await HttpRequestService.sendRequest(
        method: HttpMethod.POST,
        url: Application.chatServiceBaseUrl + "/message/history/user",
        body: {"userId": profileDTO.userId!, "pageIndex": 0, "pageSize": 20},
        isSecure: false);
    if (200 == response.statusCode) {
      final List<dynamic> data = jsonDecode(response.body)['data'];
      chatState.add(data.length);
      userListStae.add(data
          .map((e) => UserDTO(
              senderName: profileDTO.username!,
              senderId: profileDTO.userId!,
              senderImageUrl: "",
              recipientId: e['userId'],
              recipientName: e['username'],
              recipientImageUrl: e['userImageUrl'],
              lastMessage: e['lastMessage'],
              date: e['createdAt']))
          .toList());
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserHistory();
  }

  @override
  void dispose() {
    super.dispose();
    userListStae.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    chatState = BlocProvider.of<ChatState>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(color: ApplicationColor.naturalWhite),
            width: size.width,
            height: size.height,
            padding: EdgeInsets.all(Application.defaultPadding),
            child: StreamBuilder<List<UserDTO>>(
                stream: userListStae.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: snapshot.data!
                            .map((e) => UserItemDTO(userData: e))
                            .toList());
                  }
                  return Column(
                    children: [],
                  );
                })),
      ),
    );
  }
}

class UserItemDTO extends StatelessWidget {
  const UserItemDTO({Key? key, required this.userData}) : super(key: key);
  final UserDTO userData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RouterState activeNavbarState = BlocProvider.of<RouterState>(context);
    return InkWell(
      onTap: () {
        activeNavbarState.go(
            context: context,
            baseRoute: ChatRoom.routeName,
            extra: ChatRoom(
                recipientName: this.userData.recipientName,
                senderId: this.userData.senderId,
                recipientId: this.userData.recipientId,
                recipientImageUrl: this.userData.recipientImageUrl,
                senderName: this.userData.senderName,
                senderImageUrl: this.userData.senderImageUrl));
        // GoRouter.of(context).go(Login.routeName);
      },
      child: Container(
        // color: const Color.fromARGB(70, 33, 149, 243),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(right: 23),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  userData.recipientImageUrl,
                ),
              ),
              decoration: BoxDecoration(
                  // color: ApplicationColor.primaryColor,
                  borderRadius: BorderRadius.circular(50)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width - ((Application.defaultPadding * 2) + 73),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userData.recipientName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        DateFormat('E d').format(
                            DateTime.fromMillisecondsSinceEpoch(userData.date,
                                isUtc: true)),
                        style: TextStyle(
                            color: Color.fromARGB(255, 197, 189, 189),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 3),
                  child: Text(
                    userData.lastMessage,
                    style: TextStyle(
                        color: Color.fromARGB(255, 156, 151, 151),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
