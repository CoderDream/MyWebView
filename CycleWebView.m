//
//  CycleWebView.m
//  MyWebView
//
//  Created by Coder Dream on 12-7-12.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import "CycleWebView.h"

@interface CycleWebView()

- (void) initContentView;
- (void) refreshContentView;
- (void) updateContentviewFrame;
- (int) getValidPage:(int)page;

@end

@implementation CycleWebView

- (id)initWithFrame:(CGRect)frame contentArray:(NSArray *)stringArray pages:(int)pages scrollDirection:(CycleDirection)direction {
  self = [super initWithFrame:frame];
  
  if (self) {    
    curPage = 1;    
    scrollCurPage = 1;    
    pagePersent = 0.2;
    
    contentFrame = frame;    
    
    
    NSMutableArray *viewArray = [NSMutableArray array];
    NSMutableString *htmlString;
    int onePageLineCount = 15;
    int arraySize = [stringArray count];
    int pageSize = arraySize / onePageLineCount;
    NSLog(@"####  arraySize: %d, pageSize: %d", arraySize, pageSize);
    int idxLine;
    for (idxLine = 0; idxLine < pageSize * onePageLineCount; idxLine+=onePageLineCount){
     // NSString *currentContent = [stringArray objectAtIndex:idxLine];
      htmlString = [[NSMutableString alloc] initWithCapacity:1024];
      [htmlString appendString:@"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">"];
      [htmlString appendString:@"<html>"];
      [htmlString appendString:@"<head>"];
      [htmlString appendString:@"<title> New Document </title>"];
      [htmlString appendString:@"</head>"];
      [htmlString appendString:@"<body>"];
      [htmlString appendString:@"<p>"];
      
      int pageIndex;
      for (pageIndex = 0; pageIndex < onePageLineCount; pageIndex++) {
        NSString *currentContent = [stringArray objectAtIndex:idxLine + pageIndex];
        [htmlString appendString:currentContent];
      }
      
      [htmlString appendString:@"</p>"];
      [htmlString appendString:@"</body>"];
      [htmlString appendString:@"</html>"];
      //NSLog(@"idxLine: %d : htmlString:  %@", idxLine, htmlString);
      [viewArray addObject:htmlString];
    } 
    
    //contentArray = viewArray;    
    contentArray = viewArray;
    NSLog(@"contentArray count:  %d", [contentArray count]);
    
    totalPage = pages;
    
    cycleDirection = direction;  
    
    [self initContentView];
    
    [self refreshContentView];    
    NSLog(@"####");
  }
  
  return self;  
}


- (void) initContentView {
  //竖直方向滚动
  if(cycleDirection == PortraitDirection) {    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentFrame.size.width, contentFrame.size.height * 3)];//可以存储三张图片    
  }
  
  if(cycleDirection == LandscapeDirection)  {    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentFrame.size.width*3, contentFrame.size.height)];    
  }
  
  if(contentView != nil) {    
    [self addSubview:contentView];    
    [contentView release];    
  }
  
  contentView.backgroundColor=[UIColor redColor];  
}


- (void) refreshContentView {
  NSLog(@"refreshContentView begin");
  scrollCurPage = 2;    //每次刷新contentview后显示的都是contentview中三张图片的第二张  
  
  NSArray *subViews = [contentView subviews];
  
  if([subViews count]!=0) {
    [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  }
  
  int prePage = [self getValidPage:curPage - 1]; 
  int lastPage = [self getValidPage:curPage + 1];
  NSLog(@"%d, %d", prePage, lastPage);
 
  NSLog(@"%d: ", [contentArray count]);
    
  // 加入htmlPath参数后，弹出窗口有页面来源信息，否则显示为null
  CGRect viewFrame = [[UIScreen mainScreen] applicationFrame];
  viewFrame.origin.y += 20.0 + 5.0;	// leave from the URL input field and its label
  viewFrame.size.height -= 40.0;
  
  //CGRectMake(10, 10, 300, 460);
  UIWebView *preView = [[UIWebView alloc] initWithFrame:viewFrame]; 
  NSString *preHtmlString = [contentArray objectAtIndex:prePage];
  NSString *curHtmlString = [contentArray objectAtIndex:curPage];
  NSString *lastHtmlString = [contentArray objectAtIndex:lastPage];
  NSLog(@"preHtmlString: %@ ", preHtmlString);
  NSLog(@"curHtmlString: %@ ", curHtmlString);
  NSLog(@"lastHtmlString: %@ ", lastHtmlString);
  
  
  UILabel *pre = [[UILabel alloc] init];
  [pre setText:preHtmlString];
  UILabel *cur = [[UILabel alloc] init];
  [cur setText:curHtmlString];
  UILabel *last = [[UILabel alloc] init];
  [last setText:lastHtmlString];
  
  //[preView loadHTMLString:preHtmlString baseURL:nil];
  //UIWebView *curView = [[UIWebView alloc] initWithFrame:viewFrame]; 
  //[preView loadHTMLString:curHtmlString baseURL:nil];  
  //UIWebView *lastView = [[UIWebView alloc] initWithFrame:viewFrame]; 
  //[preView loadHTMLString:lastHtmlString baseURL:nil];
  
  //[contentView addSubview:preView];  
  //[contentView addSubview:curView];  
  //[contentView addSubview:lastView];
  //[preView release];  
 // [curView release];  
  //[lastView release];
  NSLog(@"########contentView#######");
  [contentView addSubview:pre];  
  [contentView addSubview:cur];  
  [contentView addSubview:last];
  
  [pre release];  
  [cur release];  
  [last release];
  
  
  if(cycleDirection == LandscapeDirection)  {    
    pre.frame = CGRectOffset(pre.frame, 0, 0);    
    cur.frame = CGRectOffset(cur.frame, contentFrame.size.width, 0);    
    last.frame = CGRectOffset(last.frame, contentFrame.size.width * 2, 0);    
  }

  /*
  if(cycleDirection == LandscapeDirection)  {    
    preView.frame = CGRectOffset(preView.frame, 0, 0);    
    curView.frame = CGRectOffset(curView.frame, contentFrame.size.width, 0);    
    lastView.frame = CGRectOffset(lastView.frame, contentFrame.size.width * 2, 0);    
  }*/
  
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
