import 'package:flutter/material.dart';
import 'package:grocery/chart/Cart.dart';
import 'package:grocery/constants/Application.dart';
import 'package:grocery/constants/ApplicationColor.dart';
import 'package:grocery/home/Home.dart';
import 'package:grocery/products/ProductGroupGridItems.dart';
import 'package:grocery/products/Products.dart';
import 'package:grocery/profile/MyAccount.dart';

class FloatingBottomNavigationBar extends StatefulWidget {
  FloatingBottomNavigationBar({Key? key, required this.items, required this.currentIndex, required this.onTap, this.selectedItemColor, this.unselectedItemColor}) : super(key: key);

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<FloatingBottomNavigationBarItem> items;
  Color? selectedItemColor = Color.fromARGB(255, 98, 98, 98);
  Color? unselectedItemColor = Color.fromARGB(255, 179, 179, 179);

  @override
  State<FloatingBottomNavigationBar> createState() => _FloatingBottomNavigationBarState();
}

class _FloatingBottomNavigationBarState extends State<FloatingBottomNavigationBar> {
  final homeRoutes = [Home.routeName];
  final productRoutes = [Products.routeName, ProductGroupGridItems.routeName];
  final profileRoutes = [MyAccount.routeName];
  final cartRoutes = [Cart.routeName];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Application.defaultPadding),
      margin: EdgeInsets.all(Application.defaultPadding * 0.8),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 8),
                blurRadius: 10,
                color: ApplicationColor.shadowColor.withOpacity(0.23),
                spreadRadius: 0)
          ],
          borderRadius: BorderRadius.circular(Application.defaultPadding * 5)),
      child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: widget.items.asMap().entries.map(
              (e) => InkWell(
                onTap: () => {
                  if(e.key != widget.currentIndex){
                    widget.onTap(e.key)
                  }
                }, 
                child: Icon(e.value.iconData, size: 32, color: e.key == widget.currentIndex ? widget.selectedItemColor : widget.unselectedItemColor,),)
            ).toList()
    ));
  }
}

class FloatingBottomNavigationBarItem{
  final IconData iconData;

  FloatingBottomNavigationBarItem({required this.iconData});
}