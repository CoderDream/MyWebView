//
//  OneLine.h
//  MyWebView
//
//  Created by Coder Dream on 12-7-12.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneLine : NSObject {
  
  NSInteger *lineIndex;
  NSString *lineContent;
  Boolean beginParaFlag;
  Boolean endParaFlag;
}

@property NSInteger *lineIndex;
@property (nonatomic, retain) NSString *lineContent;
@property  Boolean beginParaFlag;
@property  Boolean endParaFlag;

@end
