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

  double singleBlockWidth;

  AvatarWidgetState(this.size,this.normalSize,this.biggerSize,this.color,this.index,this.halfOfBiggerSize)
    :upperTop = 20,
      belowTop = 120,
      singleBlockWidth = size.width/4;

  PageModel _pageModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<PageModel>(
      builder: (ctx,pageModel,child){
        //debugPrint('build~~~ ${index} ---${pageModel.currentIndex}');
        _pageModel = pageModel;
        return Positioned(
          left: getLeft(),
          top: getTop(),
          child: Container(
            alignment: Alignment.center,
            width: getSize(),
            height: getSize(),
            decoration: BoxDecoration(
                color:color ,
                shape: BoxShape.circle
            ),
            child: Text('$index',style: TextStyle(color: Colors.black),),
          ),
        );
      },
    );
  }

  double getSize(){
    if(index == _pageModel.currentIndex){
      //左右滑动 都是缩小
      return biggerSize - getSizeDValue();
    }else if(index == _pageModel.currentIndex-1 && _pageModel.slideDirection == SlideDirection.Right){
      ///前一个向中间划动
      return normalSize + getSizeDValue();
    }else if(index == _pageModel.currentIndex +1 && _pageModel.slideDirection == SlideDirection.Left){
      ///后一个向中间划动
      return normalSize + getSizeDValue();
    }else {
      return normalSize;
    }
  }

  double getSizeDValue(){
    return ((biggerSize - normalSize) * _pageModel.pageSlideProgress);
  }

  /*
  * 暂定规则
  *       2   4
  *    1    3   5
  *
  * 1-5宽度是（屏幕宽度+nromalSize）。
  *
  * 左右平移距离 暂定为单步 size.width/4 :singleBlockWidth
  * */


  double getLeft(){
    if(index == _pageModel.currentIndex){
      if(_pageModel.slideDirection == SlideDirection.Left){
        ///中间向左滑动
        return (singleBlockWidth * 2 - biggerSize/2) - getLeftDValue();
      }else{
        ///中间向右滑动
        return (singleBlockWidth * 2 - biggerSize/2) + getLeftDValue();
      }
    }else if(index == (_pageModel.currentIndex - 1)){
      ///中间左1
      if(_pageModel.slideDirection == SlideDirection.Left){
        return (singleBlockWidth - normalSize/2) - getLeftDValue();
      }else{
        return (singleBlockWidth - normalSize/2) + getLeftDValue();
      }
    }else if(index == (_pageModel.currentIndex + 1)){
      ///中间右1
      if(_pageModel.slideDirection == SlideDirection.Left){
        return (singleBlockWidth * 3 - normalSize/2) - getLeftDValue();
      }else {
        return (singleBlockWidth * 3 - normalSize/2) + getLeftDValue();
      }
    }else if(index == (_pageModel.currentIndex - 2)){
      if(_pageModel.slideDirection == SlideDirection.Left){
        return -(normalSize/2) - getLeftDValue();
      }else{
        return -(normalSize/2) + getLeftDValue();
      }
    }else if(index == (_pageModel.currentIndex + 2)){
      if(_pageModel.slideDirection == SlideDirection.Left){
        return (singleBlockWidth * 4 - normalSize/2)  - getLeftDValue();
      }else {
        return (singleBlockWidth * 4 - normalSize/2)  + getLeftDValue();
      }
    }else if(index < (_pageModel.currentIndex - 2)){
      if(_pageModel.slideDirection == SlideDirection.Left){
        return (singleBlockWidth * (index-_pageModel.currentIndex-2))-normalSize/2 - getLeftDValue();
      }else{
        return (singleBlockWidth * (index-_pageModel.currentIndex-2))-normalSize/2 + getLeftDValue();
      }
    }else{
      if(_pageModel.slideDirection == SlideDirection.Left){
        return (singleBlockWidth * (index-_pageModel.currentIndex+2))-normalSize/2 - getLeftDValue();
      }else{
        return (singleBlockWidth * (index-_pageModel.currentIndex+2))-normalSize/2 + getLeftDValue();
      }
    }
  }

  double getLeftDValue(){
    if(index == _pageModel.currentIndex-1){
      if(_pageModel.slideDirection == SlideDirection.Left){
        return singleBlockWidth * _pageModel.pageSlideProgress;
      }else{
        return (singleBlockWidth - biggerSize/2) * _pageModel.pageSlideProgress;
      }
    }else if(index == _pageModel.currentIndex + 1){
      if(_pageModel.slideDirection == SlideDirection.Left){
        return (singleBlockWidth + normalSize/2) * _pageModel.pageSlideProgress;
      }else{
        return singleBlockWidth * _pageModel.pageSlideProgress;
      }
    }else if(index == _pageModel.currentIndex){
      return (singleBlockWidth - normalSize/2) * _pageModel.pageSlideProgress;
    }
    return singleBlockWidth * _pageModel.pageSlideProgress;
  }

  double getTop(){
    if((index -_pageModel.currentIndex)%2 == 0){
      return belowTop - getTopDValue();
    }else{
      return upperTop + getTopDValue();
    }
  }

  double getTopDValue(){
    return (belowTop - upperTop) * _pageModel.pageSlideProgress;
  }
}























