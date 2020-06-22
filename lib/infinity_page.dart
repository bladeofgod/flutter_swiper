




import 'package:flutter/material.dart';

class InfinityPage extends StatefulWidget{

  final Size screenSize;


  InfinityPage(this.screenSize);

  @override
  State<StatefulWidget> createState() {
    return InfinityPageState();
  }

}

enum ScrollStatus{
  TOUCH,SLIDE,IDLE
}

class InfinityPageState extends State<InfinityPage>
    with TickerProviderStateMixin {

  PageController pageController;
  PageController avatarController;

  AnimationController controller;
  AnimationController avatarControl;
  Animation begin50Anim;
  Animation begin150Anim;
  Animation avatarSize2Big;
  Animation avatarSize2Small;

  final double topSize = 98.1818;
  final double bottomSize = 392.7272;

  double lastPosition = 0.0;

  double ratio = 0.0;

  double delta;

  double norMalSize;
  double bigSize;

  //int index =0;

  final int animDuration = 400;
  bool showAvatarBorder = true;

  bool isClickDrive = false;
  double slideDistance = 0.0;

  ///temp
  double lastSlide = 0.0;

  int initPageIndex = 300;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    norMalSize = widget.screenSize.width/5.5;
    bigSize = widget.screenSize.width/4.0;
    debugPrint('screen size  ${widget.screenSize}');
    controller = AnimationController(vsync: this,duration: Duration(milliseconds: animDuration));
    avatarControl = AnimationController(vsync: this,duration: Duration(milliseconds: animDuration));
    begin50Anim = Tween<double>(begin: 50,end: 150).animate(controller);
    begin150Anim = Tween<double>(begin: 150,end: 50).animate(controller);

    avatarSize2Big = Tween<double>(begin: norMalSize ,end:bigSize )
        .animate(controller);
    avatarSize2Small = Tween<double>(begin: bigSize ,end:norMalSize )
        .animate(controller);


    currentAvatarIndex = initPageIndex;
    pageController = PageController(initialPage: initPageIndex);
    avatarController = PageController(viewportFraction: 0.25,initialPage: initPageIndex);
    pageController.addListener(() {
      ScrollPosition position = pageController.position;
      if(!isClickDrive && slideDistance.abs() < 30){
        return;
      }
//      if(slideDistance.abs() < 30){
//        if(lastPosition == 0){
//          lastPosition = position.pixels;
//        }else{
//          slideDistance = position.pixels - lastPosition;
//        }
//        logNotify('scroll', '$slideDistance');
//        return;
//      }

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
      if(scrollStatus == ScrollStatus.IDLE)return;
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

  final int itemCount = 600;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey,
      width: size.width,height: size.height,
      child: Stack(
        children: <Widget>[
          wrapWidgetWithNotify(PageView.builder(
            controller: pageController,
            onPageChanged: (index){
              temp = index;
            },
            itemCount: itemCount,
            itemBuilder: (ctx,index){
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
            },

          )),
          Container(
            //color: Colors.blue,
            width: size.width,height: 300,
            child: PageView.builder(
              controller: avatarController,
              onPageChanged: (index){

              },
              itemCount: itemCount,
              itemBuilder: (ctx,index){
                return Column(
                  children: <Widget>[
                    SizedBox(width: 1,height: index%2==0?begin150Anim.value : begin50Anim.value,),
                    GestureDetector(
                      onTap: (){
                        if(index != currentAvatarIndex){
                          isClickDrive = true;
                          if((index - currentAvatarIndex).abs() == 1){
                            pageController.animateToPage(index, duration:
                            Duration(milliseconds: animDuration+50)
                                , curve: Curves.ease).whenComplete(() => isClickDrive = false);
                          }else{
                            if(index > currentAvatarIndex){
                              pageController.animateToPage(currentAvatarIndex+1, duration:
                              Duration(milliseconds: animDuration+50)
                                  , curve: Curves.ease).whenComplete((){
                                Future.delayed(Duration(milliseconds: 100))
                                    .then((value) {
                                  pageController.animateToPage(index, duration:
                                  Duration(milliseconds: animDuration+50)
                                      , curve: Curves.ease).whenComplete(() => isClickDrive = false);
                                });
                              });
                            }else{
                              pageController.animateToPage(currentAvatarIndex-1, duration:
                              Duration(milliseconds: animDuration+50)
                                  , curve: Curves.ease).whenComplete((){
                                Future.delayed(Duration(milliseconds: 100))
                                    .then((value) {
                                  pageController.animateToPage(index, duration:
                                  Duration(milliseconds: animDuration+50)
                                      , curve: Curves.ease).whenComplete(() => isClickDrive = false);
                                });
                              });
                            }

                          }
                        }
                      },
                      child: Container(
                        width:getWidth(index),
                        height:getWidth(index),
                        decoration: BoxDecoration(
                          border:(index == currentAvatarIndex && showAvatarBorder)?
                          Border.all(color: Colors.blue,width: 4) : null,
                          shape: BoxShape.circle,
                          color: index%2 == 0 ? Colors.red : Colors.yellow,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool needReverse = false;///一个方向持续滑动时、动画需要reverse

  double getWidth(int index){
    logNotify('getwidth', '$delta');
    if(delta == null){
      //logNotify('null', '$delta');
      return index == currentAvatarIndex ? avatarSize2Small.value : norMalSize;
    }else if(scrollStatus == ScrollStatus.IDLE){
      logNotify('anima value', '${controller.value}');
      return index == currentAvatarIndex ? bigSize : norMalSize;
//      if(controller.value == 0){
//        return index == currentAvatarIndex ?  avatarSize2Small.value : avatarSize2Big.value;
//      }else{
//        return index == currentAvatarIndex ?  avatarSize2Big.value :avatarSize2Small.value;
//      }
    }
    logNotify('index info', '$index ----  $currentAvatarIndex');

    if(delta > 0){
      if(index == currentAvatarIndex){
        return needReverse ? avatarSize2Big.value : avatarSize2Small.value;
      }else if(index == (currentAvatarIndex +1)){
        return needReverse ? avatarSize2Small.value :  avatarSize2Big.value;
      }else{
        return norMalSize;
      }
    }else{
      if(index == currentAvatarIndex){
        return needReverse ?  avatarSize2Big.value : avatarSize2Small.value;
      }else if(index == (currentAvatarIndex - 1)){
        return needReverse ?  avatarSize2Small.value : avatarSize2Big.value ;
      }else{
        return norMalSize;
      }
    }
  }


  int currentAvatarIndex = 0;
  int temp = 0;

  ScrollStatus scrollStatus = ScrollStatus.IDLE;

  bool slideEnd = true;

  double lastSlidePos = 0.0;

  wrapWidgetWithNotify(Widget widget){
    return NotificationListener(
      onNotification: (ScrollNotification notification){
        if(notification is ScrollStartNotification){
          scrollStatus = ScrollStatus.TOUCH;
          ///触摸位置
          logNotify('start', 'global position    ${notification.dragDetails?.globalPosition}');

        }else if(notification is ScrollEndNotification){
          scrollStatus = ScrollStatus.IDLE;
          currentAvatarIndex = temp;
          showAvatarBorder = true;
          slideDistance = 0.0;
          lastSlidePos = 0.0;
          needReverse = controller.value == 1;
          ratio = 0.0;
          ///每个viewport的宽度
          logNotify('end', '${notification.metrics.pixels}');

        }else if(notification is ScrollUpdateNotification){
          delta = notification.scrollDelta;
          scrollStatus = ScrollStatus.SLIDE;
          if(notification.dragDetails != null && lastSlidePos != 0){
            slideDistance += notification.dragDetails.globalPosition.dx-lastSlidePos;
          }
          if(notification.dragDetails != null){
            lastSlidePos = notification.dragDetails.globalPosition.dx;
          }
          logNotify('slide distance', '$slideDistance');
          showAvatarBorder = false;
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























