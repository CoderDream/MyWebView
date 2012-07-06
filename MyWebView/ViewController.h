//
//  ViewController.h
//  MyWebView
//
//  Created by Coder Dream on 12-6-30.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate> {
  UIWebView *myWebView;
}
@property (nonatomic,retain) IBOutlet UIWebView *myWebView;

- (BOOL) checkNetworkStatus;
- (BOOL) isReachabilitable;
- (NSArray *)getConfigFromXml:(NSString *)xmlFilePath xmlNodePath:(NSString *)xmlNodePath;
@end
