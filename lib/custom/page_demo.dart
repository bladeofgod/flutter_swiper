/*
* Author : LiJiqqi
* Date : 2020/6/29
*/

import 'package:flutter/material.dart';
import 'custom_scroll_physics.dart';
import 'custom_page_position.dart';
import 'custom_page_controller.dart';


class PageDemo extends StatefulWidget{

  final Size size;


  PageDemo(this.size);

  @override
  State<StatefulWidget> createState() {
    return PageDemoState();
  }

}

class PageDemoState extends State<PageDemo> {

  CustomPageController controller;

  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    controller = CustomPageController(middleViewPortFraction: 0.4,sideViewportFraction: 0.2);
    widgets.addAll(List.generate(20, (index) => Container(
        color: index%2==0? Colors.yellow:Colors.red,
    )));
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,height: widget.size.height,
      child: PageView(
        controller: controller,
        physics: CustomScrollPhysics(),
        onPageChanged: (index){
          debugPrint('index : $index');
        },
      ),
    );
  }
}















