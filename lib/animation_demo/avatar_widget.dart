/*
* Author : LiJiqqi
* Date : 2020/7/1
*/

import 'package:flutter/material.dart';
import 'package:fluttercomplexswiper/animation_demo/page_model.dart';
import 'package:provider/provider.dart';

class AvatarWidget extends StatefulWidget{

  final Size size;
  final double normalSize;
  final double biggerSize;
  final Color color;
  final int index;

  AvatarWidget(this.size,this.normalSize,this.biggerSize,this.color,this.index);

  @override
  State<StatefulWidget> createState() {
    return AvatarWidgetState(size,normalSize,biggerSize,color,index,biggerSize/2);
  }

}

class AvatarWidgetState extends State<AvatarWidget> with TickerProviderStateMixin {

  final Size size;

  final double normalSize;///小头像
  final double biggerSize;///大头像
  final double halfOfBiggerSize;///大头像半径
  final Color color;
  final int index;

  ///上层头像 的top值
  double upperTop;
  ///下层头像 的top值
  double belowTop;

  AvatarWidgetState(this.size,this.normalSize,this.biggerSize,this.color,this.index,this.halfOfBiggerSize)
    :upperTop = 0,
      belowTop = 160;

  PageModel _pageModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<PageModel>(
      builder: (ctx,pageModel,child){
        _pageModel = pageModel;
        return Positioned(
          left: getLeft(),
          top: getTop(),
          child: Container(
            width: getSize(),
            height: getSize(),
            decoration: BoxDecoration(
                color:color ,
                shape: BoxShape.circle
            ),
          ),
        );
      },
    );
  }

  double getSize(){
    if(index == _pageModel.currentIndex){
      //左右滑动 都是缩小
      return biggerSize - getDValue();
    }else if(index == _pageModel.currentIndex-1 && _pageModel.slideDirection == SlideDirection.Right){
      ///前一个向中间划动
      return normalSize + getDValue();
    }else if(index == _pageModel.currentIndex +1 && _pageModel.slideDirection == SlideDirection.Left){
      ///后一个向中间划动
      return normalSize + getDValue();
    }else {
      return normalSize;
    }
  }

  double getDValue(){
    return ((biggerSize - normalSize) * _pageModel.pageSlideProgress);
  }

  /*
  * 暂定规则
  *       2   4
  *    1    3   5
  *
  * 1-5宽度是（屏幕宽度+nromalSize）。
  *
  * 以下统一计算距离屏幕的left的值
  * 1 ： - normalSize/2
  * 2 :    normalSize * 0.8
  * 3 :    (size.width-biggerSize) / 2
  * 4 :    size.width - normalSize*1.8
  * 5 :    size.width + normalSize*0.5
  *
  * */


  double getLeft(){
    if(index == _pageModel.currentIndex){
      if(_pageModel.slideDirection == SlideDirection.Left){
        ///中间向左滑动
        return biggerSize/2 *
      }
    }else{}
  }

  double getTop(){}
}























