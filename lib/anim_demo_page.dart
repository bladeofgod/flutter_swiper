

import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AnimationPageState();
  }

}

enum ScrollStatus{
  TOUCH,SLIDE,IDLE
}

class AnimationPageState extends State<AnimationPage>
  with TickerProviderStateMixin {

  PageController pageController;
  PageController avatarController;

  AnimationController controller;
  Animation begin50Anim;
  Animation begin150Anim;

  final double topSize = 98.1818;
  final double bottomSize = 392.7272;

  double lastPosition = 0.0;

  double ratio = 0.0;

  double delta;

  //int index =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    begin50Anim = Tween<double>(begin: 50,end: 150).animate(controller);
    begin150Anim = Tween<double>(begin: 150,end: 50).animate(controller);

    pageController = PageController();
    avatarController = PageController(viewportFraction: 0.25);
    pageController.addListener(() {
      ScrollPosition position = pageController.position;
      logNotify('controller', 'scroll position  ${position.pixels}');
      avatarController.position.moveTo(position.pixels/4);
//      if(scrollStatus != ScrollStatus.SLIDE){
//        //index = (position.pixels / bottomSize).floor();
//        return;
//      }
//      ratio = ((position.pixels % bottomSize) / bottomSize).abs();
//
//      logNotify('delta', '$delta');
//      logNotify('current index', '$currentAvatarIndex');
      if(currentAvatarIndex % 2== 0){
        logNotify('animation ', 'forward    ');
        controller.forward();
        //controller.animateTo(ratio) ;
      }else{
        logNotify('animation', 'backd   ');
        //controller.animateBack(ratio);
        //logNotify('sum', '${1-ratio}');
        controller.reverse();
//        controller.animateTo(ratio) ;
      }
//      if(lastPosition < position.pixels){
//        currentAvatarIndex % 2== 0 ? controller.forward() : controller.reverse();
//      }else if(lastPosition > position.pixels){
//        currentAvatarIndex % 2== 0 ? controller.reverse() : controller.forward();
//      }

      setState(() {

      });
      lastPosition = position.pixels;

    });


    controller.addStatusListener((status) {
//      if(status == AnimationStatus.dismissed){
//        controller.forward();
//      }
    logNotify('animation value', '${controller.value}');
      logNotify('animation status', '${status.toString()}');
    });

    avatarController.addListener(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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

              },
              children: List.generate(8, (index){

                return Column(
                  children: <Widget>[
                    SizedBox(width: 1,height: index%2==0?begin150Anim.value : begin50Anim.value,),
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
  int temp = 0;

  ScrollStatus scrollStatus = ScrollStatus.IDLE;


  wrapWidgetWithNotify(Widget widget){
    return NotificationListener(
      onNotification: (ScrollNotification notification){
        if(notification is ScrollStartNotification){
          scrollStatus = ScrollStatus.TOUCH;
          ///触摸位置
          logNotify('start', 'global position    ${notification.dragDetails?.globalPosition}');

        }else if(notification is ScrollEndNotification){
          scrollStatus = ScrollStatus.IDLE;
          ratio = 0.0;
          ///每个viewport的宽度
          logNotify('end', '${notification.metrics.pixels}');

        }else if(notification is ScrollUpdateNotification){
          delta = notification.scrollDelta;
          scrollStatus = ScrollStatus.SLIDE;
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
//          logNotify('end scroll index', '$currentAvatarIndex');
//          logNotify('temp end scroll index', '$temp');
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




















