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

@synthesize preLabel;
@synthesize curLabel;
@synthesize lastLabel;

- (id)initWithFrame:(CGRect)frame contentArray:(NSArray *) contents scrollDirection:(CycleDirection)direction {
  
  self = [super initWithFrame:frame];
  
  if (self) {    
    curPage = 1;    
    scrollCurPage = 1;    
    pagePersent = 0.2;
    
    contentFrame = frame;    
    //fileName = name;  //循环图片的前缀名字
    //Copy and sort     
    
    NSMutableArray *newArray = [[NSMutableArray alloc] init]; 
    NSLog(@"oldArray:%@",contents);
    NSInteger pageLines = 15;
    //NSMutableString pageContent;
    NSMutableString *pageContent = [[NSMutableString alloc] initWithString:@""];     
    //[String1 appendString:@", I will be adding some character"];     
      
    for (int idx = 0; idx < contents.count; idx++){
      NSString *currentLineContent = [contents objectAtIndex:idx];
      
      [pageContent appendFormat:[NSString stringWithFormat:currentLineContent]];
      [pageContent appendFormat:[NSString stringWithFormat:@"\n"]];   
     // NSString *urlString = [currentLineContent stringValue];  
      if (0 < [currentLineContent length]) {   
        //NSLog(@"NO INPUT." ); 
        if(idx % pageLines == 0) {
          [newArray addObject: pageContent];
          pageContent = [[NSMutableString alloc] initWithString:@""];
        }        
      }      
    }     
    //[newArray sortUsingSelector:@selector(compare:)];     
    //NSLog(@"newArray:%@", newArray); 
    
    contentArray = newArray;
    //[newArray release];
    totalPage = [contentArray count];
    NSLog(@"content line count: %d", totalPage);
    
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
  
  //String
  NSMutableString *prePageStr = [contentArray objectAtIndex:prePage - 1];
 NSMutableString *curPageStr = [contentArray objectAtIndex:curPage - 1];
    NSMutableString *lastPageStr = [contentArray objectAtIndex:lastPage - 1];
  
  //创建uilabel
  /*
  CDLabel *label1 = [[CDLabel alloc] initWithFrame:CGRectMake(10, 10, 300, 440)];
  CDLabel *label2 = [[CDLabel alloc] initWithFrame:CGRectMake(10, 10, 300, 440)];
  CDLabel *label3 = [[CDLabel alloc] initWithFrame:CGRectMake(10, 10, 300, 440)];
  label1.numberOfLines = 0;     // 不可少Label属性之一  
  label1.lineBreakMode = UILineBreakModeCharacterWrap;
  label2.numberOfLines = 0;     // 不可少Label属性之一  
  label2.lineBreakMode = UILineBreakModeCharacterWrap;  
  label3.numberOfLines = 0;     // 不可少Label属性之一  
  label3.lineBreakMode = UILineBreakModeCharacterWrap;  
  */
  /*  CGSize prePageStrSize = [prePageStr sizeWithFont:[UIFont boldSystemFontOfSize:17.0f]
                     constrainedToSize:CGSizeMake(280, 100) 
                    lineBreakMode:UILineBreakModeCharacterWrap];   // str是要显示的字符串
   */

  UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 440)];
  label1.text = prePageStr;  
  //label1.backgroundColor = [UIColor clearColor];  
  label1.font = [UIFont fontWithName:@"STHeiti-Medium" size:17.0f];  
  label1.numberOfLines = 0;     // 不可少Label属性之一  
  label1.lineBreakMode = UILineBreakModeCharacterWrap;    // 不可少Label属性之二
  //label1.backgroundColor = [UIColor redColor];
  label1.textColor = [UIColor yellowColor];
  
  UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 440)];
  label2.text = curPageStr;  
  //label2.backgroundColor = [UIColor clearColor];  
  label2.font = [UIFont fontWithName:@"STHeiti-Medium" size:17.0f];   
  label2.numberOfLines = 0;     // 不可少Label属性之一  
  label2.lineBreakMode = UILineBreakModeCharacterWrap;    // 不可少Label属性之二
  //label2.backgroundColor = [UIColor redColor];
  label2.textColor = [UIColor yellowColor];

  UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 440)];
  label3.text = prePageStr;  
  //label3.backgroundColor = [UIColor clearColor];  
  label3.font = [UIFont fontWithName:@"STHeiti-Medium" size:17.0f];   
  label3.numberOfLines = 0;     // 不可少Label属性之一  
  label3.lineBreakMode = UILineBreakModeCharacterWrap;    // 不可少Label属性之二
  //label3.backgroundColor = [UIColor redColor];
  label3.textColor = [UIColor yellowColor];
  
  
  label1.tag = 11;
  label2.tag = 12;
  label3.tag = 13;
  //设置标签文本
  label1.text = prePageStr;
  label2.text = curPageStr;
  label3.text = lastPageStr;
  [contentView addSubview:label1];
  [contentView addSubview:label2];
  [contentView addSubview:label3];
  [label1 release];
  [label2 release];
  [label3 release];  
  
  
  //@synthesize preLabel;
  //@synthesize curLabel;
  //@synthesize lastLabel;
    
  NSLog(@"prePageStr: %@ ; curPageStr: %@ ; lastPageStr: %@ ; ", prePageStr, curPageStr, lastPageStr);
  
  /* */
  if(cycleDirection == LandscapeDirection)  {
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
