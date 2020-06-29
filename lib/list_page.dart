/*
* Author : LiJiqqi
* Date : 2020/6/29
*/

import 'package:flutter/material.dart';

class ListPage extends StatefulWidget{

  final Size size;


  ListPage(this.size);

  @override
  State<StatefulWidget> createState() {
    return ListPageState(size);
  }

}

class ListPageState extends State<ListPage> {

  final Size size;


  ListPageState(this.size);

  ScrollController scrollController;
  PageController pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,height: size.height,
      child: Column(
        children: <Widget>[
          ListView.builder(
            controller: scrollController,
            itemBuilder:(ctx,index){} ,

          )
        ],
      ),
    );
  }
}
























