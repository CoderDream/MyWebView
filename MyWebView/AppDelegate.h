//
//  AppDelegate.h
//  MyWebView
//
//  Created by Coder Dream on 12-6-30.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class ViewController;
@class ContentsViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
  UIWindow *window;
  //ViewController *viewController;
  ContentsViewController *viewController;
}

// 记录当次运行实例中 WebView 当前动作
@property (nonatomic, retain) NSString *webViewAction;

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) ContentsViewController *viewController;

@end
