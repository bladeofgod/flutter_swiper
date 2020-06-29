/*
* Author : LiJiqqi
* Date : 2020/6/29
*/

import 'package:flutter/material.dart';

class PageDemo extends StatefulWidget{

  final Size size;


  PageDemo(this.size);

  @override
  State<StatefulWidget> createState() {
    return PageDemoState();
  }

}

class PageDemoState extends State<PageDemo> {

  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,height: widget.size.height,
    );
  }
}















