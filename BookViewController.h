//
//  BookViewController.h
//  MyWebView02
//
//  Created by Coder Dream on 12-7-8.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CycleScrollView.h"
//#import "CycleWebView.h"
//#import "OneLine.h"
#import "CycleUILabelView.h"

@interface BookViewController : UIViewController {
  //  CycleScrollView *myCycleScrollView;
  NSString *sectionName;
  CycleUILabelView *myCycleUILabelView;
}

//@property (strong, nonatomic) CycleScrollView *myCycleScrollView;
@property (strong, nonatomic) CycleUILabelView *myCycleUILabelView;
@property (strong, nonatomic) NSString *sectionName;

-(void) buttonClicked;
@end
