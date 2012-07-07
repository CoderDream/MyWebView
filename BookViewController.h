//
//  BookViewController.h
//  MyWebView
//
//  Created by Coder Dream on 12-7-4.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookViewController : UIViewController <UIWebViewDelegate> {
  UIWebView *myWebView;
  NSString *sectionName;
}
@property (nonatomic,retain) UIWebView *myWebView;
@property (nonatomic,retain) NSString *sectionName;
-(void) buttonClicked ;
@end
