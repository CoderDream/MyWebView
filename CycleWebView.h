//
//  CycleWebView.h
//  MyWebView
//
//  Created by Coder Dream on 12-7-12.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface CycleWebView : UIView {
  UIView *contentView;
  
  CycleDirection cycleDirection; //滚动方向
  
 // NSString *fileName;
  
  int totalPage;  //循环滚动图片张数
  
  CGRect contentFrame;  
  
  int curPage;
  
  int scrollCurPage;
  
  float pagePersent;  //翻页百分比  
  
  CGPoint beginPoint;
  
  CGPoint prePoint;
  
  CGPoint curPoint;
  
  CGPoint endPoint; 
  
  NSArray *contentArray;
}

//@property (strong, nonatomic) NSArray *contentArray;

- (id)initWithFrame:(CGRect)frame contentArray:(NSArray *)stringArray pages:(int)pages scrollDirection:(CycleDirection)direction;
;

@end
