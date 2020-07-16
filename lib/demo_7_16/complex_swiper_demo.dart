/*
* Author : LiJiqqi
* Date : 2020/7/16
*/

import 'package:flutter/material.dart';

class ComplexSwiperDemo extends StatefulWidget{

  final Size size;

  ComplexSwiperDemo(this.size);

  @override
  State<StatefulWidget> createState() {

    return ComplexSwiperDemoState(size);
  }

}

class ComplexSwiperDemoState extends State<ComplexSwiperDemo> {

  final Size size;

  ComplexSwiperDemoState(this.size);

  PageController pageController;

  ScrollController scrollController;

  int pageCount = 10;

  double top = 20;

  double avatarSize = 40;



  @override
  void initState() {
    pageController = PageController();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        width: size.width,height: size.height,
        child: Stack(
          children: <Widget>[

            SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              child: Container(
                width: size.width,
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: List.generate(pageCount, (index){
                    return Positioned(
                      top: index%2==0 ? top*5:top,
                      child: Container(
                        margin: EdgeInsets.only(left: (index*100).floorToDouble()),
                        width: avatarSize,height: avatarSize,
                        decoration: BoxDecoration(
                            color: index%2==0 ? Colors.red:Colors.yellow,
                            shape: BoxShape.circle
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            ///page
            Positioned(
              bottom: size.height/10,
              child: Container(
                width: size.width,height: size.height/2,
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index){
                    //todo
                  },
                  itemCount: pageCount,
                  itemBuilder: (ctx,index){
                    return Container(
                      margin: EdgeInsets.only(right: size.width/10,left: size.width/10),
                      width:size.width*0.8,
                      height: size.height*0.5,
                      color: index%2 == 0 ? Colors.red : Colors.yellow,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
























