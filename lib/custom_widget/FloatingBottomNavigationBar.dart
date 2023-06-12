import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';

// ignore: must_be_immutable
class FloatingBottomNavigationBar extends StatefulWidget {
  FloatingBottomNavigationBar(
      {Key? key,
      required this.items,
      required this.currentIndex,
      required this.onTap,
      this.selectedItemColor,
      this.unselectedItemColor})
      : super(key: key);

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<FloatingBottomNavigationBarItem> items;
  Color? selectedItemColor = Color.fromARGB(255, 98, 98, 98);
  Color? unselectedItemColor = Color.fromARGB(255, 179, 179, 179);

  @override
  State<FloatingBottomNavigationBar> createState() =>
      _FloatingBottomNavigationBarState();
}

class _FloatingBottomNavigationBarState
    extends State<FloatingBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(Application.defaultPadding),
        // margin: EdgeInsets.all(Application.defaultPadding * 0.8),
        decoration: BoxDecoration(
          color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //       offset: Offset(0, 8),
          //       blurRadius: 10,
          //       color: ApplicationColor.shadowColor.withOpacity(0.23),
          //       spreadRadius: 0)
          // ],
          // borderRadius: BorderRadius.circular(Application.defaultPadding * 5)
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.items
                .asMap()
                .entries
                .map((e) => InkWell(
                      onTap: () => {
                        if (e.key != widget.currentIndex) {widget.onTap(e.key)}
                      },
                      child: Icon(
                        e.value.iconData,
                        size: 32,
                        color: e.key == widget.currentIndex
                            ? widget.selectedItemColor
                            : widget.unselectedItemColor,
                      ),
                    ))
                .toList()));
  }
}

class FloatingBottomNavigationBarItem {
  final IconData iconData;

  FloatingBottomNavigationBarItem({required this.iconData});
}
