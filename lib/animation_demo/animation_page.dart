/*
* Author : LiJiqqi
* Date : 2020/7/1
*/


import 'package:flutter/material.dart';


class AnimationDrivePage extends StatefulWidget{

  final Size size;


  AnimationDrivePage(this.size);

  @override
  State<StatefulWidget> createState() {
    return AnimationDrivePageState(size);
  }

}


class AnimationDrivePageState extends State<AnimationDrivePage>{

  final Size size;

  AnimationDrivePageState(this.size);

  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction:0.9 );
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      color: Colors.white,
      width: size.width,height: size.height,
      child: Column(
        children: <Widget>[
          ///avatar
          Container(
            width: size.width,height: 300,
            color: Colors.grey,
          ),
          SizedBox(width: 1,height: 20,),

          ///card
          Expanded(
            child: PageView(
              controller: pageController,
              children: List.generate(10, (index){
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: size.width,height: size.height-320,
                  color: index % 2== 0 ? Colors.red : Colors.yellow,
                );
              }).toList(),
            ),
          ),
        ],
      ),

    );
  }

}























