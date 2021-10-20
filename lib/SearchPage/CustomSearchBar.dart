import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom search"),actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.search))
      ],),
    );
  }
}
