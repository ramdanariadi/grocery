import 'package:flutter/widgets.dart';
import '../constants/Application.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key, required this.message, this.other = false})
      : super(key: key);

  final bool other;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          other ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
              color: other
                  ? Color.fromRGBO(228, 228, 228, 0.83)
                  : Color.fromARGB(255, 208, 236, 232),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: other ? Radius.circular(0) : Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight:
                      other ? Radius.circular(20) : Radius.circular(0))),
          margin: EdgeInsets.only(top: Application.defaultPadding * 0.8),
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 11),
          child: Text(
            this.message,
            style: TextStyle(
                fontFamily: "Poppins",
                color: other
                    ? Color.fromARGB(255, 56, 55, 55)
                    : Color.fromARGB(255, 0, 118, 100),
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
