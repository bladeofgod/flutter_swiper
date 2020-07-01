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
    return AvatarWidgetState(size,normalSize,biggerSize,color,index);
  }

}

class AvatarWidgetState extends State<AvatarWidget> with TickerProviderStateMixin {

  final Size size;
  final double normalSize;
  final double biggerSize;
  final Color color;
  final int index;

  AvatarWidgetState(this.size,this.normalSize,this.biggerSize,this.color,this.index);

  PageModel _pageModel;

  @override
  Widget build(BuildContext context) {
    return Consumer<PageModel>(
      builder: (ctx,pageModel,child){
        _pageModel = pageModel;
        return Positioned(
          left: getLeft(),
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
      return biggerSize - ((biggerSize - normalSize) * _pageModel.pageSlideProgress);
    }
  }

  double getLeft(){
    if(index == _pageModel.currentIndex){
      return size.width/2;
    }else{}
  }
}























