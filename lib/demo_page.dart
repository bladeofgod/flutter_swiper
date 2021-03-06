/*
* Author : LiJiqqi
* Date : 2020/6/19
*/

import 'package:flutter/material.dart';

enum SlideDirection{
  LEFT,
  RIGHT
}


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
  final double distanceRatio = 100/392.7272;

  double lastPosition = 0.0;

  Map<int,double> marginMap = Map();
  //List<double> marginList ;
  //Map<int,Container> widgetMap = Map();

  ///值更新
  double value = 0.0;
  ///比例更新
  double ratio = 0.0;

  SlideDirection slideDirection = SlideDirection.RIGHT;

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
      //logNotify('base pos', 'info')
      avatarController.position.moveTo(position.pixels/4);
      ///比例更新
      logNotify('%', '${position.pixels%bottomSize}');
      //ratio = (position.pixels%bottomSize)/bottomSize;
      //logNotify('ratio', '$ratio');
//      if(lastPosition <= position.pixels){
//        slideDirection = SlideDirection.RIGHT;
//      }else{
//        slideDirection = SlideDirection.LEFT;
//      }

      ///值更新
      //value = ((position.pixels - lastPosition).abs()) * distanceRatio;
      value = ((position.pixels - lastPosition).abs()) / bottomSize * 100;
      debugPrint('distance value    ------$value');
      cal += value.abs();
      logNotify('value sum', '$cal');
      lastPosition = position.pixels;
      setState(() {

      });

//      if(currentAvatarIndex% 2 == 0){
//        value -= (position.pixels - lastPosition).abs();
////          topMarginTop -= (position.pixels - lastPosition).abs();
////          belowMarginTop += (position.pixels - lastPosition).abs();
//      }else{
//        value += (position.pixels - lastPosition).abs();
////          topMarginTop += (position.pixels - lastPosition).abs();
////          belowMarginTop -= (position.pixels - lastPosition).abs();
//      }

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
          wrapWidgetWithNotify(PageView(
            controller: pageController,
            onPageChanged: (index){
              temp = index;
            },
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
          )),
          Container(
            //color: Colors.blue,
            width: size.width,height: 300,
            child: PageView(
              controller: avatarController,
              onPageChanged: (index){
                logNotify('pageview', '$index');

//                setState(() {
//
//                });
              },
              children: List.generate(8, (index){

                return Column(
                  children: <Widget>[
                    SizedBox(width: 1,height: geneHeightByDirection(index).abs(),),
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

  final double flag = 100;

  double checkValue(double value){
    return value > 150 ? 150 : value;
  }
  double cal = 0.0;
  double geneHeightByDirection(int index){
    //logNotify('scroll direction ', '${slideDirection}');

    if(currentAvatarIndex % 2 == 0){
      //logNotify('scroll direction ', '${slideDirection}');
      if(index % 2 == 0){
        marginMap[index] = marginMap[index] - value;
      }else {
        marginMap[index] = marginMap[index] + value;
      }
      logNotify('even top--$index', '${marginMap[index]}');
      return marginMap[index];
    }else{
      //logNotify('scroll direction ', '${slideDirection}');
//      if(index % 2 == 0){
//        marginMap[index] = marginMap[index] + value;
//      }else {
//        marginMap[index] = marginMap[index] - value;
//      }
//      logNotify('odd top -- $index', '${marginMap[index]}');
      return marginMap[index];
    }
  }

  double geneHeight(int index){
    //if(ratio < 0.001 || ratio > 1) return marginMap[index];
    debugPrint('current index $currentAvatarIndex');
    if(currentAvatarIndex % 2 == 0){
      debugPrint('up-----------------');
      //logNotify('margin top   $value', '${marginMap[0]}');
      if(index % 2 == 0){
        marginMap[index] = checkValue(marginMap[index] - (flag*ratio));
      }else {
        marginMap[index] = checkValue(marginMap[index] + (flag*ratio));
      }
      logNotify('even top', '${marginMap[index]}');
      return marginMap[index];
    }else{
      debugPrint('down-----------------');
      if(index % 2 == 0){
        marginMap[index] = checkValue(marginMap[index] + (flag*ratio));
      }else {
        marginMap[index] = checkValue(marginMap[index] - (flag*ratio));
      }
      logNotify('odd top', '${marginMap[index]}');
      return marginMap[index];
    }

  }

  int temp = 0;
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
          logNotify('end scroll index', '$currentAvatarIndex');
          logNotify('temp end scroll index', '$temp');
          //value = 0.0;
          currentAvatarIndex = temp;
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


































