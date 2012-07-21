//
//  CDLabel.m
//  MyWebView
//
//  Created by Coder Dream on 12-7-19.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import "CDLabel.h"

@implementation CDLabel

@synthesize backgroundColor;
@synthesize textColor;
@synthesize lineBreakMode; 
@synthesize font;
@synthesize numberOfLines;

- (void)setDefaults {
  //设置背景色
 // backgroundColor = [UIColor redColor];
  //textColor = [UIColor yellowColor];
  //lineBreakMode = UILineBreakModeCharacterWrap;    // 不可少Label属性之二
  //lineBreakMode = UILineBreakModeWordWrap; 
  //numberOfLines = 0;
  //text = curPageStr;  
    
  //font = [UIFont boldSystemFontOfSize:17.0f];  
  //numberOfLines = 0;     // 不可少Label属性之一  
  
  NSLog(@"#### setDefaults ####");
  
  backgroundColor = [UIColor clearColor];  
  font = [UIFont boldSystemFontOfSize:17.0f];  
  numberOfLines = 0;     // 不可少Label属性之一  
  lineBreakMode = UILineBreakModeCharacterWrap;    // 不可少Label属性之二
  backgroundColor = [UIColor redColor];
  textColor = [UIColor yellowColor];
  /*
  CGSize     _size;
  NSString  *_text;
  UIColor   *_color;
  UIColor   *_highlightedColor;
  UIColor   *_shadowColor;
  UIFont    *_font;
  CGSize     _shadowOffset;
  CGFloat    _minFontSize;
  CGFloat    _actualFontSize;
  NSInteger  _numberOfLines;
  CGFloat    _lastLineBaseline;
  NSInteger  _lineSpacing;
   */
}

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    //self.backgroundColor = nil;
    [self setDefaults];
  }
  return self;
}

@end
