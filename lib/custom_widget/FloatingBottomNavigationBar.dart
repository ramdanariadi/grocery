import 'package:flutter/material.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';

class FloatingBottomNavigationBar extends StatefulWidget {
  FloatingBottomNavigationBar(
      {Key? key,
      required this.items,
      required this.currentIndex,
      required this.onTap,
      this.selectedItemColor = const Color.fromARGB(255, 98, 98, 98),
      this.unselectedItemColor = const Color.fromARGB(255, 179, 179, 179)})
      : super(key: key);

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<FloatingBottomNavigationBarItem> items;
  final Color selectedItemColor;
  final Color unselectedItemColor;

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
            children: widget.items.asMap().entries.map((e) {
              List<Widget> children = List.empty(growable: true);
              children.add(Icon(
                e.value.iconData,
                size: 32,
                color: e.key == widget.currentIndex
                    ? widget.selectedItemColor
                    : widget.unselectedItemColor,
              ));

              if (e.value.badges != null) {
                children.add(Positioned(
                  right: 0,
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: e.key == widget.currentIndex
                              ? ApplicationColor.blackHint
                              : ApplicationColor.primaryColor),
                      child: e.value.badges),
                ));
              }

              return InkWell(
                onTap: () => {
                  if (e.key != widget.currentIndex) {widget.onTap(e.key)}
                },
                child: Stack(
                  children: children,
                ),
              );
            }).toList()));
  }
}

class FloatingBottomNavigationBarItem {
  final IconData iconData;
  Widget? badges;

  FloatingBottomNavigationBarItem({required this.iconData, this.badges});
}
