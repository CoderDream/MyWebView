//
//  CycleUILabelView.h
//  MyWebView02
//
//  Created by Coder Dream on 12-7-18.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "CDLabel.h"
#import "MyLabel.h"

@interface CycleUILabelView : UIView {
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
  
  MyLabel *preLabel;
  MyLabel *curLabel;
  MyLabel *lastLabel;
  
  NSArray *contentArray;
  
  
}

@property (nonatomic, retain) MyLabel *preLabel;
@property (nonatomic, retain) MyLabel *curLabel;
@property (nonatomic, retain) MyLabel *lastLabel;

- (id)initWithFrame:(CGRect)frame contentArray:(NSArray *)contents scrollDirection:(CycleDirection)direction;

@end
