/*
* Author : LiJiqqi
* Date : 2020/6/29
*/


import 'package:flutter/material.dart';

class ListDemo extends StatefulWidget{

  final Size size;

  ListDemo(this.size);

  @override
  State<StatefulWidget> createState() {
    return ListDemoState();
  }
  
}

class ListDemoState extends State<ListDemo> {

  //List<Widget> widgets = [];

  PageController pageController;
  ScrollController scrollController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();


    pageController = PageController(viewportFraction: 0.5);
    pageController.addListener(() {});
    scrollController = ScrollController();

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      color: Colors.white,
      width: widget.size.width,height: widget.size.height,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 30,left: widget.size.width*0.25),
            //padding: EdgeInsets.symmetric(horizontal: widget.size.width*0.1 ),
            width: widget.size.width,height: 300,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              children: List.generate(30, (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: index == currentIndex ? widget.size.width*0.5-20 : widget.size.width*0.2-20,
                color: index%2==0? Colors.yellow:Colors.red,
              )),
            ),
          ),

          Expanded(
            child: wrapWidgetWithNotify(PageView(
              controller: pageController,
              onPageChanged: (index){
                logNotify('pageview', '$index');
                currentIndex = index;
                setState(() {

                });
              },
              children: List.generate(30, (index){
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  color: index%2==0? Colors.yellow:Colors.red,
                );
              }).toList(),
            )),
          )
        ],
      ),
    );
  }

  wrapWidgetWithNotify(Widget widget){
    return NotificationListener(
      onNotification: (ScrollNotification notification){
        if(notification is ScrollStartNotification){
          ///触摸位置
          logNotify('start', 'global position    ${notification.dragDetails?.globalPosition}');

        }else if(notification is ScrollEndNotification){

          ///每个viewport的宽度
          logNotify('end', '${notification.metrics.pixels}');

        }else if(notification is ScrollUpdateNotification){
          logNotify('update', 'metrics  ${notification.metrics.pixels}');
          scrollController.animateTo(notification.metrics.pixels, duration: Duration(milliseconds: 1), curve: Curves.ease);
          ///滑动距离  向右 负值   ，向左 正值
          logNotify('update', 'scroll delta   ${notification.scrollDelta}');
          ///手指离屏后 dragDetails 会为
          logNotify('update', 'global position      ${notification.dragDetails?.globalPosition}');
          logNotify('update', 'global position direction     ${notification.dragDetails?.globalPosition?.distance}');
//          if(notification.dragDetails != null){
//            dragGlobalPosition = notification.dragDetails?.globalPosition;
//            setState(() {
//
//            });
//          }

        }else{
//          logNotify('end scroll index', '$currentAvatarIndex');
//          logNotify('temp end scroll index', '$temp');
          //value = 0.0;
//          currentAvatarIndex = temp;
//          needReverse = controller.value == 1;
          ///头/尾部 继续滑动会走这个方法
          logNotify('nothing', '-----');
          //logNotify('scroll notification', info)
        }
        return true;
      },
      child: widget,
    );
  }

  logNotify(String title,String info){
    debugPrint("$title ------- $info");
  }
}















