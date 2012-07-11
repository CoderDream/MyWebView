//
//  CycleView.h
//  MyWebView02
//
//  Created by Coder Dream on 12-7-8.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _CycleDirection {  
  PortraitDirection,
  LandscapeDirection  
} CycleDirection;

@interface CycleView : UIView {  
  UIView *contentView;
  
  CycleDirection cycleDirection; //滚动方向
  
  NSString *fileName;
  
  int totalPage;  //循环滚动图片张数
  
  CGRect contentFrame;  
  
  int curPage;
  
  int scrollCurPage;
  
  float pagePersent;  //翻页百分比  
  
  CGPoint beginPoint;
  
  CGPoint prePoint;
  
  CGPoint curPoint;
  
  CGPoint endPoint;  
}

- (id)initWithFrame:(CGRect)frame fileName:(NSString *)name pages:(int)pages scrollDirection:(CycleDirection)direction;

@end