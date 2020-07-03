/*
* Author : LiJiqqi
* Date : 2020/7/1
*/


import 'package:flutter/material.dart';
import 'package:fluttercomplexswiper/animation_demo/avatar_widget.dart';
import 'package:fluttercomplexswiper/animation_demo/page_model.dart';
import 'package:provider/provider.dart';


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
  PageModel pageModel = PageModel(5);

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction:0.9 ,initialPage: 5);
  }

  int genNum = 30;

  @override
  Widget build(BuildContext context) {


    return Container(
      color: Colors.white,
      width: size.width,height: size.height,
      child: Column(
        children: <Widget>[
          ///avatar
          ChangeNotifierProvider<PageModel>.value(
            value: pageModel,
            child: Container(
              padding: EdgeInsets.only(top: 40),
              width: size.width,height: 300,
              color: Colors.grey,
              child: Stack(
                children: <Widget>[
                  ...List.generate(genNum, (index){
                    return AvatarWidget(Size(size.width,260), 70, 140,index % 2 == 0 ?  Colors.red : Colors.yellow,index);
                  }).toList(),
                ],
              ),
            ),
          ),

          SizedBox(width: 1,height: 20,),

          ///card
          Expanded(
            child: wrapWidget(
                PageView(
                  controller: pageController,
                  onPageChanged: (index){
                    tempIndex = index;
                  },
                  children: List.generate(genNum, (index){
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      width: size.width,height: size.height-320,
                      color: index % 2== 0 ? Colors.red : Colors.yellow,
                    );
                  }).toList(),
                )
            ),
          ),
        ],
      ),

    );
  }

  int tempIndex = 5;

  double lastPosition = 0.0;
  final double singleWidth = 353.454545;

  wrapWidget(Widget widget){
    return NotificationListener(
      onNotification: (ScrollNotification notification){
        if(notification is ScrollUpdateNotification){

          //debugPrint('--aaaaa---${notification.dragDetails.delta.direction}');
//          double delta = notification.scrollDelta;
//          debugPrint("$delta");
          if(notification.dragDetails != null){
            if(notification.dragDetails.delta.direction > 0){
              ///向左
              if(pageModel.slideDirection != SlideDirection.Left){
                pageModel.setDirection(SlideDirection.Left);
              }
            }else{
              if(pageModel.slideDirection != SlideDirection.Right){
                pageModel.setDirection(SlideDirection.Right);
              }
            }
          }

//          debugPrint('demension ${notification.metrics.viewportDimension}');
//          debugPrint('  -----${ notification.metrics.maxScrollExtent/10}');
          ///右滑动时 为负值
          lastPosition += notification.scrollDelta.abs();
          debugPrint('pos------------${lastPosition}');

          double progress = (lastPosition/ singleWidth).clamp(0.0,1.0);
          debugPrint('progress  : $progress');
          pageModel.setSlideProgress(progress);

        }
        if(notification is ScrollStartNotification){
          //debugPrint('${notification.metrics.maxScrollExtent / 10}');
          debugPrint('start');
          pageModel.isScrolling = true;
        }
        if(notification is ScrollEndNotification){
          debugPrint('end');
          pageModel.isScrolling = false;
          lastPosition = 0;
          debugPrint('${pageModel.currentIndex}-------$tempIndex');
          pageModel.pageSlideProgress = 0.0;
          pageModel.setCurrentIndex(tempIndex);

        }

        return true;

      },
      child: widget,
    );
  }

}























