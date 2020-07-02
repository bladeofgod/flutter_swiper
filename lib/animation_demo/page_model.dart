/*
* Author : LiJiqqi
* Date : 2020/7/1
*/


import 'package:flutter/foundation.dart';

enum SlideDirection{
  Left,Right
}

class PageModel extends ChangeNotifier{

  int initIndex = 0;

  PageModel(this.initIndex):currentIndex = initIndex;

  int currentIndex = 0;

  ///页面滑动百分比
  double pageSlideProgress = 0.0;
  setSlideProgress(double progress){
    pageSlideProgress = progress;
    notifyListeners();
  }

  SlideDirection slideDirection;

  setDirection(SlideDirection direction){
    slideDirection = direction;
    notifyListeners();
  }

}


















