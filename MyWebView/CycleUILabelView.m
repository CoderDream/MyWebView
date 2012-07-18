//
//  CycleUILabelView.m
//  MyWebView02
//
//  Created by Coder Dream on 12-7-18.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import "CycleUILabelView.h"

@interface CycleUILabelView()

- (void) initContentView;
- (void) refreshContentView;
- (void) updateContentviewFrame;
- (int) getValidPage:(int)page;

@end

@implementation CycleUILabelView

- (id)initWithFrame:(CGRect)frame fileName:(NSString*)name pages:(int)pages scrollDirection:(CycleDirection)direction {
  
  self = [super initWithFrame:frame];
  
  if (self) {    
    curPage = 1;    
    scrollCurPage = 1;    
    pagePersent = 0.2;
    
    contentFrame = frame;    
    fileName = name;  //循环图片的前缀名字    
    totalPage = pages;
    
    cycleDirection = direction;     
    [self initContentView];    
    [self refreshContentView];    
  }
  
  return self;  
}

- (id)initWithFrame:(CGRect)frame contentArray:(NSArray *) contents scrollDirection:(CycleDirection)direction {
  
  self = [super initWithFrame:frame];
  
  if (self) {    
    curPage = 1;    
    scrollCurPage = 1;    
    pagePersent = 0.2;
    
    contentFrame = frame;    
    //fileName = name;  //循环图片的前缀名字
    contentArray = contents;
    totalPage = [contentArray count];
    
    cycleDirection = direction;     
    [self initContentView];    
    [self refreshContentView];    
  }
  
  return self;  
}

- (void) initContentView {
  //竖直方向滚动
  if(cycleDirection == PortraitDirection) {    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentFrame.size.width, contentFrame.size.height*3)];//可以存储三张图片    
  }
  
  if(cycleDirection == LandscapeDirection)  {
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentFrame.size.width*3, contentFrame.size.height)];    
  }
  
  if(contentView != nil) {
    
    [self addSubview:contentView];    
    [contentView release];    
  }
  
  contentView.backgroundColor = [UIColor redColor];  
}


- (void) refreshContentView {
  NSLog(@"refreshContentView begin");
  scrollCurPage = 2;    //每次刷新contentview后显示的都是contentview中三张图片的第二张  
  
  NSArray *subViews = [contentView subviews];
  
  if([subViews count] != 0) {
    [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  }
  
  
  int prePage = [self getValidPage:curPage - 1];
  int lastPage = [self getValidPage:curPage + 1];
   
  //创建uilabel
  UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 440)];
  
  //设置背景色
  label1.backgroundColor = [UIColor grayColor];
  
  //设置tag
  label1.tag = 91;  
  
  //设置标签文本字体和字体大小
  label1.font = [UIFont fontWithName:@"Arial" size:30];
  //设置文本对其方式
  label1.textAlignment = UITextAlignmentCenter;
  //文本对齐方式有以下三种
  //typedef enum {
  //    UITextAlignmentLeft = 0,左对齐
  //    UITextAlignmentCenter,居中对齐
  //    UITextAlignmentRight, 右对齐                 
  //} UITextAlignment;
  
  //文本颜色
  label1.textColor = [UIColor blueColor];
  //超出label边界文字的截取方式
  label1.lineBreakMode = UILineBreakModeTailTruncation;
  //截取方式有以下6种
  //typedef enum {       
  //    UILineBreakModeWordWrap = 0,    以空格为边界，保留整个单词         
  //    UILineBreakModeCharacterWrap,   保留整个字符         
  //    UILineBreakModeClip,            到边界为止         
  //    UILineBreakModeHeadTruncation,  省略开始，以……代替       
  //    UILineBreakModeTailTruncation,  省略结尾，以……代替      
  //    UILineBreakModeMiddleTruncation,省略中间，以……代替，多行时作用于最后一行       
  //} UILineBreakMode;
  
  //文本文字自适应大小
  label1.adjustsFontSizeToFitWidth = YES;
  //当adjustsFontSizeToFitWidth=YES时候，如果文本font要缩小时
  //baselineAdjustment这个值控制文本的基线位置，只有文本行数为1是有效
  label1.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
  //有三种方式
  //typedef enum {
  //    UIBaselineAdjustmentAlignBaselines = 0, 默认值文本最上端于label中线对齐
  //    UIBaselineAdjustmentAlignCenters,//文本中线于label中线对齐
  //    UIBaselineAdjustmentNone,//文本最低端与label中线对齐
  //} UIBaselineAdjustment;
  
  //文本最多行数，为0时没有最大行数限制
  label1.numberOfLines = 2;
  //最小字体，行数为1时有效，默认为0.0
  label1.minimumFontSize = 10.0;
  //文本高亮
  label1.highlighted = YES;
  //文本是否可变
  label1.enabled = YES;
  //去掉label背景色
  //label1.backgroundColor = [UIColor clearColor];
  
  //文本阴影颜色
  label1.shadowColor = [UIColor grayColor];
  //阴影大小
  label1.shadowOffset = CGSizeMake(1.0, 1.0);
  
  //是否能与用户交互
  label1.userInteractionEnabled = YES;
  
  [contentView addSubview:label1];
  [label1 release];
  
  
  //创建uilabel
  UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 440)];
  
  //设置背景色
  label2.backgroundColor = [UIColor grayColor];
  
  //设置tag
  label2.tag = 92;
  
  //设置标签文本字体和字体大小
  label2.font = [UIFont fontWithName:@"Arial" size:30];
  //设置文本对其方式
  label2.textAlignment = UITextAlignmentCenter;
  //文本对齐方式有以下三种
  //typedef enum {
  //    UITextAlignmentLeft = 0,左对齐
  //    UITextAlignmentCenter,居中对齐
  //    UITextAlignmentRight, 右对齐                 
  //} UITextAlignment;
  
  //文本颜色
  label2.textColor = [UIColor blueColor];
  //超出label边界文字的截取方式
  label2.lineBreakMode = UILineBreakModeTailTruncation;
  //截取方式有以下6种
  //typedef enum {       
  //    UILineBreakModeWordWrap = 0,    以空格为边界，保留整个单词         
  //    UILineBreakModeCharacterWrap,   保留整个字符         
  //    UILineBreakModeClip,            到边界为止         
  //    UILineBreakModeHeadTruncation,  省略开始，以……代替       
  //    UILineBreakModeTailTruncation,  省略结尾，以……代替      
  //    UILineBreakModeMiddleTruncation,省略中间，以……代替，多行时作用于最后一行       
  //} UILineBreakMode;
  
  //文本文字自适应大小
  label2.adjustsFontSizeToFitWidth = YES;
  //当adjustsFontSizeToFitWidth=YES时候，如果文本font要缩小时
  //baselineAdjustment这个值控制文本的基线位置，只有文本行数为1是有效
  label2.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
  //有三种方式
  //typedef enum {
  //    UIBaselineAdjustmentAlignBaselines = 0, 默认值文本最上端于label中线对齐
  //    UIBaselineAdjustmentAlignCenters,//文本中线于label中线对齐
  //    UIBaselineAdjustmentNone,//文本最低端与label中线对齐
  //} UIBaselineAdjustment;
  
  //文本最多行数，为0时没有最大行数限制
  label2.numberOfLines = 2;
  //最小字体，行数为1时有效，默认为0.0
  label2.minimumFontSize = 10.0;
  //文本高亮
  label2.highlighted = YES;
  //文本是否可变
  label2.enabled = YES;
  //去掉label背景色
  //label2.backgroundColor = [UIColor clearColor];
  
  //文本阴影颜色
  label2.shadowColor = [UIColor grayColor];
  //阴影大小
  label2.shadowOffset = CGSizeMake(1.0, 1.0);
  
  //是否能与用户交互
  label2.userInteractionEnabled = YES;
  
  [contentView addSubview:label2];
  [label2 release];
  
  //创建uilabel
  UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 440)];
  
  //设置背景色
  label3.backgroundColor = [UIColor grayColor];
  
  //设置tag
  label3.tag = 93;
  
  //设置标签文本字体和字体大小
  label3.font = [UIFont fontWithName:@"Arial" size:30];
  //设置文本对其方式
  label3.textAlignment = UITextAlignmentCenter;
  //文本对齐方式有以下三种
  //typedef enum {
  //    UITextAlignmentLeft = 0,左对齐
  //    UITextAlignmentCenter,居中对齐
  //    UITextAlignmentRight, 右对齐                 
  //} UITextAlignment;
  
  //文本颜色
  label3.textColor = [UIColor blueColor];
  //超出label边界文字的截取方式
  label3.lineBreakMode = UILineBreakModeTailTruncation;
  //截取方式有以下6种
  //typedef enum {       
  //    UILineBreakModeWordWrap = 0,    以空格为边界，保留整个单词         
  //    UILineBreakModeCharacterWrap,   保留整个字符         
  //    UILineBreakModeClip,            到边界为止         
  //    UILineBreakModeHeadTruncation,  省略开始，以……代替       
  //    UILineBreakModeTailTruncation,  省略结尾，以……代替      
  //    UILineBreakModeMiddleTruncation,省略中间，以……代替，多行时作用于最后一行       
  //} UILineBreakMode;
  
  //文本文字自适应大小
  label3.adjustsFontSizeToFitWidth = YES;
  //当adjustsFontSizeToFitWidth=YES时候，如果文本font要缩小时
  //baselineAdjustment这个值控制文本的基线位置，只有文本行数为1是有效
  label3.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
  //有三种方式
  //typedef enum {
  //    UIBaselineAdjustmentAlignBaselines = 0, 默认值文本最上端于label中线对齐
  //    UIBaselineAdjustmentAlignCenters,//文本中线于label中线对齐
  //    UIBaselineAdjustmentNone,//文本最低端与label中线对齐
  //} UIBaselineAdjustment;
  
  //文本最多行数，为0时没有最大行数限制
  label3.numberOfLines = 2;
  //最小字体，行数为1时有效，默认为0.0
  label3.minimumFontSize = 10.0;
  //文本高亮
  label3.highlighted = YES;
  //文本是否可变
  label3.enabled = YES;
  //去掉label背景色
  //label3.backgroundColor = [UIColor clearColor];
  
  //文本阴影颜色
  label3.shadowColor = [UIColor grayColor];
  //阴影大小
  label3.shadowOffset = CGSizeMake(1.0, 1.0);
  
  //是否能与用户交互
  label3.userInteractionEnabled = YES;
  
  [contentView addSubview:label3];
  [label3 release];
  
  
  //String
  NSMutableString *prePageStr = [contentArray objectAtIndex:prePage - 1];
  //设置标签文本
  label1.text = prePageStr;
  
  //设置标签文本
  NSMutableString *curPageStr = [contentArray objectAtIndex:curPage - 1];
  label2.text = curPageStr;
  
  //设置标签文本
  NSMutableString *lastPageStr = [contentArray objectAtIndex:lastPage - 1];
  label3.text = lastPageStr;
  
  /* */
  if(cycleDirection==LandscapeDirection)  {
    label1.frame=CGRectOffset(label1.frame, 0, 0);    
    label2.frame=CGRectOffset(label2.frame, contentFrame.size.width, 0);    
    label3.frame=CGRectOffset(label3.frame, contentFrame.size.width * 2, 0); 
  }  
  
  contentView.frame = CGRectMake(0, 0, -contentFrame.size.width, 0);
  
  NSLog(@"refreshContentView end");
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {  
  NSLog(@"touchesBegan begin");
  UITouch *touch = [touches anyObject];
  
  beginPoint = [touch locationInView:self];
  
  prePoint = beginPoint;  
  NSLog(@"touchesBegan end");
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  NSLog(@"touchesMoved begin");
  /*  UITouch *touch = [touches anyObject];  
   endPoint = [touch locationInView:self];  
   float changeX,changeY;  
   changeX = endPoint.x - beginPoint.x;  
   changeY = endPoint.y - beginPoint.y;  
   NSLog(@"changeX %f.2 , changeY %f.2", changeX, changeY);
   if(cycleDirection == LandscapeDirection) {
   
   //翻页
   if(fabs(changeX) >= contentFrame.size.width * pagePersent)  {
   int tempPage;
   if(changeX > 0) {        
   scrollCurPage--;
   tempPage = [self getValidPage:curPage - 1];       
   }
   
   if(changeX < 0) {        
   scrollCurPage++;    
   tempPage = [self getValidPage:curPage + 1];        
   }
   
   // 如果页数改变，则更新，否则停留（首页和尾页不动）
   if(tempPage != curPage) {        
   NSLog(@"$$$$$ curPage %d , tempPage %d $$$$$", curPage, tempPage);
   curPage = tempPage;
   */
  UITouch *touch = [touches anyObject];  
  curPoint = [touch locationInView:self];  
  float offsetX,offsetY;
  
  offsetX = (curPoint.x - prePoint.x)*1;  
  offsetY = (curPoint.y - prePoint.y)*1;  
  if(cycleDirection == LandscapeDirection) {    
    contentView.center = CGPointMake(contentView.center.x + offsetX, contentView.center.y);    
  }
  
  prePoint = curPoint; 
  /*
   }      
   }  
   } 
   
   
   NSLog(@"touchesMoved end");  */
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {  
  NSLog(@"touchesEnded begin");  
  UITouch *touch = [touches anyObject];  
  endPoint = [touch locationInView:self];  
  float changeX,changeY;  
  changeX = endPoint.x - beginPoint.x;  
  changeY = endPoint.y - beginPoint.y;  
  NSLog(@"changeX %f.2 , changeY %f.2", changeX, changeY);
  
  if(cycleDirection == LandscapeDirection) {
    
    //翻页
    if(fabs(changeX) >= contentFrame.size.width * pagePersent)  {
      int tempPage;
      if(changeX > 0) {        
        scrollCurPage--;
        tempPage = [self getValidPage:curPage - 1];       
      }
      
      if(changeX < 0) {        
        scrollCurPage++;    
        tempPage = [self getValidPage:curPage + 1];        
      }
      
      // 如果页数改变，则更新，否则停留（首页和尾页不动）
      if(tempPage != curPage) {        
        NSLog(@"#### curPage %d , tempPage %d ####", curPage, tempPage);
        curPage = tempPage;
        [self updateContentviewFrame];  
      }      
    }  
  } 
  
  NSLog(@"touchesEnded end"); 
}

- (void) updateContentviewFrame {
  NSLog(@"updateContentviewFrame begin");
  float offsetX, offsetY;
  
  offsetY = 0.0;
  
  if(cycleDirection == LandscapeDirection) {
    offsetX =- contentFrame.size.width * (scrollCurPage - 1);
  }
  
  [UIView beginAnimations:nil context:nil];  
  [UIView setAnimationDelegate:self];  
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];  
  [UIView setAnimationDuration:0.3];  
  contentView.frame=CGRectMake(offsetX, offsetY, contentView.frame.size.width, contentView.frame.size.height);
  
  NSLog(@"updateContentviewFrame end");
  [UIView commitAnimations];
}

- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {  
  [self refreshContentView];  
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {  
  NSLog(@"touch cancel");  
}

- (int) getValidPage:(int)page {  
  int realPage = page;
  
  if(page == 0) {
    //realPage = totalPage;
    realPage = 1;
  }
  
  if(page == totalPage+1){
    //realPage = 1;
    realPage = totalPage;
  }
  
  return realPage;  
}

- (void)dealloc {  
  [super dealloc];  
}

@end
