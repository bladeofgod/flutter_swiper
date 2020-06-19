/*
* Author : LiJiqqi
* Date : 2020/6/19
*/

import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DemoPageState();
  }

}

class DemoPageState extends State<DemoPage> {

  PageController pageController;
  PageController avatarController;

  ///for avatar
  int currentIndex = 0;
  int lastIndex = -1;
  int nextIndex = 1;

  double topMarginTop = 50;
  double belowMarginTop = 150;
  final double differ = 100;

  final double topSize = 98.1818;
  final double bottomSize = 392.7272;

  double lastPosition = 0.0;

  Map<int,double> marginMap = Map();
  //List<double> marginList ;
  Map<int,Container> widgetMap = Map();

  @override
  void initState() {
    List.generate(8, (index){
      marginMap[index] = index %2 == 0 ? belowMarginTop : topMarginTop;
    });



    super.initState();
    pageController = PageController();
    avatarController = PageController(viewportFraction: 0.25);

    pageController.addListener(() {
      ScrollPosition position = pageController.position;
      logNotify('controller', 'scroll position  ${position.pixels}');
      avatarController.position.moveTo(position.pixels/4);
      marginMap.forEach((key, value) {
        if((key - currentAvatarIndex).abs() % 2 == 0){
          value -= (position.pixels - lastPosition).abs();
//          topMarginTop -= (position.pixels - lastPosition).abs();
//          belowMarginTop += (position.pixels - lastPosition).abs();
        }else{
          value += (position.pixels - lastPosition).abs();
//          topMarginTop += (position.pixels - lastPosition).abs();
//          belowMarginTop -= (position.pixels - lastPosition).abs();
        }
        debugPrint("margin value    $value");
      });
      lastPosition = position.pixels;
      setState(() {

      });
      //avatarController.animateTo(position.pixels/4, duration: Duration(microseconds: 1), curve: Curves.ease);
      //double p = position.pixels;
//      setState(() {
//
//      });

//      if(dragGlobalPosition!= null){
//        avatarController.position.drag(DragStartDetails(
//            globalPosition: Offset(pageController.position.pixels, dragGlobalPosition.dy)
//        ), () { });
//      }
    });
    avatarController.addListener(() {
      ScrollPosition position = avatarController.position;
      //logNotify('avatar controller', 'scroll position ${position.pixels}');



    });

  }
  //double lastPosition = -1;

  Offset dragGlobalPosition = Offset(0, 0);


  @override
  Widget build(BuildContext context) {
    final Size size  = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey,
      width: size.width,height: size.height,
      child: Stack(
        children: <Widget>[
          PageView(
            controller: pageController,
            children: List.generate(8, (index){
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width:size.width*0.8,
                    height: size.height*0.5,
                    color: index%2 == 0 ? Colors.red : Colors.yellow,
                  ),
                  SizedBox(
                    width: 1,height: size.height*0.1,
                  ),
                ],
              );
            }),
          ),
          Container(
            //color: Colors.blue,
            width: size.width,height: 300,
            child: PageView(
              controller: avatarController,
              onPageChanged: (index){
                logNotify('pageview', '$index');
                currentAvatarIndex = index;
//                setState(() {
//
//                });
              },
              children: List.generate(8, (index){
                widgetMap[index] = Container(width: 1,height: marginMap[index],);
                return Column(
                  children: <Widget>[
                    widgetMap[index],
                    Container(
                      width: MediaQuery.of(context).size.width/5,height: MediaQuery.of(context).size.width/5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index%2 == 0 ? Colors.red : Colors.yellow,
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  int currentAvatarIndex = 0;

//  double generateHeight(int index){
//    if((index - currentAvatarIndex).abs() % 2 == 0){
//      return belowMarginTop;
//    }else{
//      return topMarginTop;
//    }
//  }


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
          ///滑动距离  左 滑向右 负值   ，右到左 正值
          logNotify('update', 'scroll delta   ${notification.scrollDelta}');
          ///手指离屏后 dragDetails 会为
          logNotify('update', 'global position      ${notification.dragDetails?.globalPosition}');
//          if(notification.dragDetails != null){
//            dragGlobalPosition = notification.dragDetails?.globalPosition;
//            setState(() {
//
//            });
//          }

        }else{
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


































