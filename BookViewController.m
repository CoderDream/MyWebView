//
//  BookViewController.m
//  MyWebView
//
//  Created by Coder Dream on 12-7-4.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import "BookViewController.h"
//#import "Constants.h"

@interface BookViewController(PrivateMethod) {

}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;
-(void)handleTapFrom:(UITapGestureRecognizer *)recognizer;
@end

@implementation BookViewController

@synthesize myWebView;
@synthesize sectionName;

/*
@synthesize totalPages;
@synthesize currentPage;
@synthesize textLabel;
 */

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

/**/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  
  [super viewDidLoad];
  NSLog(@"viewDidLoad");
  
  //去掉最顶端的状态拦
  [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation: UIStatusBarAnimationSlide];
  
  UIImage *image=[UIImage imageNamed:@"bg.png"];
  
  //创建背景视图
  self.view=[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
  UIImageView *backgroudView=[[UIImageView alloc] initWithImage:image];
  [self.view addSubview:backgroudView];
  
  
  self.title = NSLocalizedString(@"WebTitle", @"Title for Web Page Window");
  
  CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
  webFrame.origin.y += 20.0 + 5.0;	// leave from the URL input field and its label
  // leave room for toolbar
  webFrame.size.height -= 40.0 + 30.0;
  
  self.myWebView = [[[UIWebView alloc] initWithFrame:webFrame] autorelease];
  //self.myWebView.backgroundColor = [UIColor whiteColor];
  //self.myWebView.scalesPageToFit = YES;
  //self.myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  self.myWebView.delegate = self;
  [self.view addSubview: self.myWebView];
  
  // 从 URL 上加载内容到 UIWebView
  /*  */
  // 初始化
  [[UIApplication sharedApplication] statusBarOrientation];
  [super viewDidLoad];
  // 从 URL 中载入一个 html 页面(sectionName)
  NSString *htmlPath = [[[NSBundle mainBundle] bundlePath]
                        stringByAppendingPathComponent: self.sectionName];
  [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
  
  
  
  /*
   UIToolbar *toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 1024-70, 768, 70)];
   toolBar.alpha=0.8;
   toolBar.tintColor = [UIColor colorWithRed:.3 green:.5 blue:.6 alpha:.1];
   
   NSArray *items=[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStyleDone target:self action:nil],nil];
   toolBar.items=items;
   [self.view addSubview:toolBar];
   */
  
  UIView *bottomView=[[UIView alloc]  initWithFrame:CGRectMake(0, 480-70, 360, 70)];
  bottomView.backgroundColor=[UIColor grayColor];
  bottomView.alpha=0.8;
  
  //UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 40)];
  UIButton *backButton=[UIButton buttonWithType: UIButtonTypeRoundedRect];
  [backButton setTitle:@"回目录" forState:UIControlStateNormal];
  backButton.frame=CGRectMake(10, 15, 100, 40);
  
  [bottomView addSubview:backButton];
  // TODO
  //添加点击按钮所执行的程式
  
  [backButton addTarget:self action:@selector(buttonClicked)forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:bottomView];
  
  /* 
  UIView *infoView=[[UIView alloc] initWithFrame:CGRectMake(200, 360, 360-100, 70)];
  infoView.backgroundColor=[UIColor blueColor];
  infoView.alpha=0.6;
  //infoView.layer.cornerRadius=6;
  //infoView.layer.masksToBounds=YES;
  
  [self.view addSubview:infoView];
 
  
  UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
  [infoView addGestureRecognizer:recognizer];
  [recognizer release];
   */
  /*
  // action direction
  UISwipeGestureRecognizer *recognizer;  
  recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];  
  [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];  
  [[self view] addGestureRecognizer:recognizer];  
  [recognizer release];  
  
  recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];  
  [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];  
  [[self view] addGestureRecognizer:recognizer];  
  [recognizer release];  
  
  recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];  
  [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];  
  [[self view] addGestureRecognizer:recognizer];  
  [recognizer release];  
  
  recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];  
  [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];  
  [[self view] addGestureRecognizer:recognizer];  
  [recognizer release];  
   */
  
  
  // 
  NSError *error = nil;
  /*
  NSString *html = @"<ul>"
  "<li><input type='image' name='input1' value='string1value' /></li>"
  "<li><input type='image' name='input2' value='string2value' /></li>"
  "</ul>"
  "<span class='spantext'><b>Hello World 1</b></span>"
  "<span class='spantext'><b>Hello World 2</b></span>";
  */
  // 加入htmlPath参数后，弹出窗口有页面来源信息，否则显示为null
  NSString *html = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"section-0003.html"];
  NSLog(@"html %@", html);
  
  //HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
  HTMLParser *parser = [[HTMLParser alloc] initWithContentsOfURL:[NSURL fileURLWithPath:html] error:&error];
  
  if (error) {
    NSLog(@"Error: %@", error);
    return;
  }
  /*  
  HTMLNode *bodyNode = [parser body];
  
  NSArray *inputNodes = [bodyNode findChildTags:@"input"];
  
  for (HTMLNode *inputNode in inputNodes) {
    if ([[inputNode getAttributeNamed:@"name"] isEqualToString:@"input2"]) {
      NSLog(@"%@", [inputNode getAttributeNamed:@"value"]); //Answer to first question
    }
  }
  
  NSArray *spanNodes = [bodyNode findChildTags:@"span"];
  
  for (HTMLNode *spanNode in spanNodes) {
    if ([[spanNode getAttributeNamed:@"class"] isEqualToString:@"spantext"]) {
      NSLog(@"%@", [spanNode rawContents]); //Answer to second question
    }
  }
   */
  
  // first get total
  HTMLNode *bodyNode = [parser body];  
  
  // get tag <title>  
  NSArray *spanNodesTitle = [bodyNode findChildTags:@"title"];
  
  for (HTMLNode *spanNodeTitle in spanNodesTitle) {
    //if ([[spanNode getAttributeNamed:@"class"] isEqualToString:@"spantext"]) {
      NSLog(@"%@", [spanNodeTitle rawContents]); //Answer to second question
    //}
  }
  
  // Paragraph
  NSArray *spanNodesP = [bodyNode findChildTags:@"p"];
  int pCount = [spanNodesP count];
  NSLog(@"count %d", pCount);
  for (HTMLNode *spanNodeP in spanNodesP) {
    //if ([[spanNode getAttributeNamed:@"class"] isEqualToString:@"spantext"]) {
    NSLog(@"%@", [spanNodeP rawContents]); //Answer to second question
    //}
  }
  
  [parser release];  
}

//访问网页源码  
-(NSString *)urlString:(NSString *)value{  
  NSURL *url = [NSURL URLWithString:value];  
  NSData *data = [NSData dataWithContentsOfURL:url];    
  //解决中文乱码,用GBK  
  NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);      
  NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];  
  return retStr;  
}  
/*  
 作用:截取从value1到value2之间的字符串  
 str:要处理的字符串  
 value1:左边匹配字符串  
 value2:右边匹配字符串  
 */  
-(NSString *)str:(NSString *)str value1:(NSString *)value1 value2:(NSString *)value2{  
  //i:左边匹配字符串在str中的下标  
  int i;  
  //j:右边匹配字符串在str1中的下标  
  int j;  
  //该类可以通过value1匹配字符串  
  NSRange range1 = [str rangeOfString:value1];  
  //判断range1是否匹配到字符串  
  if(range1.length>0){  
    //把其转换为NSString  
    NSString *result1 = NSStringFromRange(range1);  
    i = [self indexByValue:result1];  
    //原因:加上匹配字符串的长度从而获得正确的下标  
    i = i+[value1 length];  
  }  
  //通过下标，删除下标以前的字符  
  NSString *str1 = [str substringFromIndex:i];  
  NSRange range2 = [str1 rangeOfString:value2];  
  if(range2.length>0){  
    NSString *result2 = NSStringFromRange(range2);  
    j = [self indexByValue:result2];  
  }  
  NSString *str2 = [str1 substringToIndex:j];  
  return str2;  
}  

//过滤获得的匹配信息的下标  
-(int)indexByValue:(NSString *)str{  
  //使用NSMutableString类，它可以实现追加  
  NSMutableString *value = [[NSMutableString alloc] initWithFormat:@""];  
  NSString *colum2 = @"";  
  int j = 0;  
  //遍历出下标值  
  for(int i=1;i<[str length];i++){  
    NSString *colum1 = [str substringFromIndex:i];  
    [value appendString:colum2];  
    colum2 = [colum1 substringToIndex:1];  
    if([colum2 isEqualToString:@","]){  
      j = [value intValue];  
      break;  
    }  
  }  
  [value release];  
  return j;  
}  

-(void) buttonClicked {
  
   NSLog(@"get detail …, window.views: %@",self.view.window.subviews);
  //[self.view removeFromSuperview];
  [self dismissModalViewControllerAnimated:YES];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{  
  //UISwipeGestureRecognizerDirectionLeft   UISwipeGestureRecognizerDirectionRight  UISwipeGestureRecognizerDirectionUp  UISwipeGestureRecognizerDirectionDown  
  if (recognizer.direction==UISwipeGestureRecognizerDirectionLeft ) {  
    NSLog(@"Left");   
  }  
  
  if (recognizer.direction==UISwipeGestureRecognizerDirectionRight ) {  
    NSLog(@"Right");   
  }  
  
  if (recognizer.direction==UISwipeGestureRecognizerDirectionUp ) {  
    NSLog(@"Up");   
  }  
  
  if (recognizer.direction==UISwipeGestureRecognizerDirectionDown) {  
    NSLog(@"Down");   
  }  
  
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
  /*
  NSLog(@"loadView begin");
  //去掉最顶端的状态拦
  [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation: UIStatusBarAnimationSlide];
  
  UIImage *image=[UIImage imageNamed:@"bg.png"];
  
  //创建背景视图
  self.view=[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
  UIImageView *backgroudView=[[UIImageView alloc] initWithImage:image];
  [self.view addSubview:backgroudView];
  */
  /*
   UIToolbar *toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 1024-70, 768, 70)];
   toolBar.alpha=0.8;
   toolBar.tintColor = [UIColor colorWithRed:.3 green:.5 blue:.6 alpha:.1];
   
   NSArray *items=[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStyleDone target:self action:nil],nil];
   toolBar.items=items;
   [self.view addSubview:toolBar];
   */
  /*
  UIView *bottomView=[[UIView alloc]  initWithFrame:CGRectMake(0, 1024-70, 768, 70)];
  bottomView.backgroundColor=[UIColor grayColor];
  bottomView.alpha=0.8;
  
  //UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 40)];
  UIButton *backButton=[UIButton buttonWithType: UIButtonTypeRoundedRect];
  [backButton setTitle:@"ok" forState:UIControlStateNormal];
  backButton.frame=CGRectMake(10, 15, 100, 40);
  
  [bottomView addSubview:backButton];
  
  [self.view addSubview:bottomView];
  
  UIView *infoView=[[UIView alloc] initWithFrame:CGRectMake(200, 700, 768-400, 70)];
  infoView.backgroundColor=[UIColor blueColor];
  infoView.alpha=0.6;
  //infoView.layer.cornerRadius=6;
  //infoView.layer.masksToBounds=YES;
 
  [self.view addSubview:infoView];  
  
  UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
  [infoView addGestureRecognizer:recognizer];
  [recognizer release];
   */
  NSLog(@"loadView end");
}

-(void)handleTapFrom:(UITapGestureRecognizer *)recognizer{
  NSLog(@">>>tap it");
}


- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark UIViewController delegate methods

- (void)viewWillAppear:(BOOL)animated
{
	self.myWebView.delegate = self;	// setup the delegate as the web view is shown
}

- (void)viewWillDisappear:(BOOL)animated {
  [self.myWebView stopLoading];	// in case the web view is still loading its content
	self.myWebView.delegate = nil;	// disconnect the delegate as the webview is hidden
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// we support rotation in this view controller
	return YES;
}

// this helps dismiss the keyboard when the "Done" button is clicked
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	[self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[textField text]]]];
	
	return YES;
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
	// starting the load, show the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  NSLog(@"webViewDidFinishLoad begin");
	// finished loading, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  /*
  //去掉最顶端的状态拦
  [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation: UIStatusBarAnimationSlide];
  
  UIImage *image=[UIImage imageNamed:@"bg.png"];
  
  //创建背景视图
  self.view=[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
  UIImageView *backgroudView=[[UIImageView alloc] initWithImage:image];
  [self.view addSubview:backgroudView];
  
  
   UIToolbar *toolBar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 1024-70, 768, 70)];
   toolBar.alpha=0.8;
   toolBar.tintColor = [UIColor colorWithRed:.3 green:.5 blue:.6 alpha:.1];
   
   NSArray *items=[NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStyleDone target:self action:nil],nil];
   toolBar.items=items;
   [self.view addSubview:toolBar];
  
  
  UIView *bottomView=[[UIView alloc]  initWithFrame:CGRectMake(0, 1024-70, 768, 70)];
  bottomView.backgroundColor=[UIColor grayColor];
  bottomView.alpha=0.8;
  
  //UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 40)];
  UIButton *backButton=[UIButton buttonWithType: UIButtonTypeRoundedRect];
  [backButton setTitle:@"ok" forState:UIControlStateNormal];
  backButton.frame=CGRectMake(10, 15, 100, 40);
  
  [bottomView addSubview:backButton];
  
  [self.view addSubview:bottomView];
  
  UIView *infoView=[[UIView alloc] initWithFrame:CGRectMake(200, 700, 768-400, 70)];
  infoView.backgroundColor=[UIColor blueColor];
  infoView.alpha=0.6;
  //infoView.layer.cornerRadius=6;
  //infoView.layer.masksToBounds=YES;
  
  [self.view addSubview:infoView];
  
  
  UITapGestureRecognizer *recognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
  [infoView addGestureRecognizer:recognizer];
  [recognizer release];
  */
  NSLog(@"webViewDidFinishLoad end");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	// load error, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  
	// report the error inside the webview
	NSString* errorString = [NSString stringWithFormat:
                           @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
                           error.localizedDescription];
	[self.myWebView loadHTMLString:errorString baseURL:nil];
}


#pragma -

-(NSArray*)getPagesOfString:(NSString *)cache withFont:(UIFont *)font inRect:(CGRect)r{
  UILineBreakMode lineBreakMode = UILineBreakModeWordWrap;
  //返回一个数组, 包含每一页的字符串开始点和长度(NSRange)  
  NSMutableArray *ranges=[NSMutableArray array];  
  //显示字体的行高  
  CGFloat lineHeight=[@"Sample样本" sizeWithFont:font].height;  
  NSInteger maxLine=floor(r.size.height/lineHeight);  
  NSInteger totalLines=0;  
  NSLog(@"Max Line Per Page: %d (%.2f/%.2f)",maxLine,r.size.height,lineHeight);  
  NSString *lastParaLeft=nil;  
  NSRange range=NSMakeRange(0, 0);  
  //把字符串按段落分开, 提高解析效率  
  NSArray *paragraphs=[cache componentsSeparatedByString:@"/n"];  
  for (int p=0;p< [paragraphs count];p++) {  
    NSString *para;  
    if (lastParaLeft!=nil) {  
      //上一页完成后剩下的内容继续计算  
      para=lastParaLeft;  
      lastParaLeft=nil;  
    }else {  
      para=[paragraphs objectAtIndex:p];  
      if (p<[paragraphs count]-1)  
        para=[para stringByAppendingString:@"/n"]; //刚才分段去掉了一个换行,现在还给它  
    }  
    CGSize paraSize=[para sizeWithFont:font  
                     constrainedToSize:r.size  
                         lineBreakMode:lineBreakMode];  
    NSInteger paraLines=floor(paraSize.height/lineHeight);  
    if (totalLines+paraLines<maxLine) {  
      totalLines+=paraLines;  
      range.length+=[para length];  
      if (p==[paragraphs count]-1) {  
        //到了文章的结尾 这一页也算  
        [ranges addObject:[NSValue valueWithRange:range]];  
        //IMILog(@”===========Page Over=============”);  
      }  
    }else if (totalLines+paraLines==maxLine) {  
      //很幸运, 刚好一段结束,本页也结束, 有这个判断会提高一定的效率  
      range.length+=[para length];  
      [ranges addObject:[NSValue valueWithRange:range]];  
      range.location+=range.length;  
      range.length=0;  
      totalLines=0;  
      //IMILog(@”===========Page Over=============”);  
    }else{  
      //重头戏, 页结束时候本段文字还有剩余  
      NSInteger lineLeft=maxLine-totalLines;  
      CGSize tmpSize;  
      NSInteger i;  
      for (i=1; i<[para length]; i++) {  
        //逐字判断是否达到了本页最大容量  
        NSString *tmp=[para substringToIndex:i];  
        tmpSize=[tmp sizeWithFont:font  
                constrainedToSize:r.size  
                    lineBreakMode:lineBreakMode];  
        int nowLine=floor(tmpSize.height/lineHeight);  
        if (lineLeft<nowLine) {  
          //超出容量,跳出, 字符要回退一个, 应为当前字符已经超出范围了  
          lastParaLeft=[para substringFromIndex:i-1];  
          break;  
        }  
      }  
      range.length+=i-1;  
      [ranges addObject:[NSValue valueWithRange:range]];  
      range.location+=range.length;  
      range.length=0;  
      totalLines=0;  
      p--;  
      //IMILog(@”===========Page Over=============”);  
    }  
  }  
  return [NSArray arrayWithArray:ranges];  
}  


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.  
/*
- (void)viewDidLoad2 {  
  //[super viewDidLoad];  
  
  //  
  totalPages = 0;  
  currentPage = 0;  
  
  //  
  textLabel.numberOfLines = 0;  
  NSString *text;
  //  
 // if (!text) {  
    // 从文件里加载文本串  
  //  [self loadString];  
    
    // 计算文本串的大小尺寸  
    CGSize totalTextSize = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_MAX]  
                            constrainedToSize:CGSizeMake(textLabel.frame.size.width, CGFLOAT_MAX)  
                                lineBreakMode:UILineBreakModeWordWrap];  
    
    // 如果一页就能显示完，直接显示所有文本串即可。  
    if (totalTextSize.height < textLabel.frame.size.height) {  
      texttextLabel.text = text;  
    }  
    else {  
      // 计算理想状态下的页面数量和每页所显示的字符数量，只是拿来作为参考值用而已！  
      NSUInteger textLength = [text length];  
      referTotalPages = (int)totalTextSize.height/(int)textLabel.frame.size.height+1;  
      referCharatersPerPage = textLength/referTotalPages;  
      
      // 申请最终保存页面NSRange信息的数组缓冲区  
      int maxPages = referTotalPages;  
      rangeOfPages = (NSRange *)malloc(referTotalPages*sizeof(NSRange));  
      memset(rangeOfPages, 0x0, referTotalPages*sizeof(NSRange));  
      
      // 页面索引  
      int page = 0;  
      
      for (NSUInteger location = 0; location < textLength; ) {  
        // 先计算临界点（尺寸刚刚超过UILabel尺寸时的文本串）  
        NSRange range = NSMakeRange(location, referCharatersPerPage);  
        
        // reach end of text ?  
        NSString *pageText;  
        CGSize pageTextSize;  
        
        while (range.location + range.length < textLength) {  
          pageText = [text substringWithRange:range];  
          
          pageTextSize = [pageText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_MAX]  
                              constrainedToSize:CGSizeMake(textLabel.frame.size.width, CGFLOAT_MAX)  
                                  lineBreakMode:UILineBreakModeWordWrap];  
          
          if (pageTextSize.height > textLabel.frame.size.height) {  
            break;  
          }  
          else {  
            range.length += referCharatersPerPage;  
          }  
        }  
        
        if (range.location + range.length >= textLength) {  
          range.length = textLength - range.location;  
        }  
        
        // 然后一个个缩短字符串的长度，当缩短后的字符串尺寸小于textLabel的尺寸时即为满足  
        while (range.length > 0) {  
          pageText = [text substringWithRange:range];  
          
          pageTextSize = [pageText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_MAX]  
                              constrainedToSize:CGSizeMake(textLabel.frame.size.width, CGFLOAT_MAX)  
                                  lineBreakMode:UILineBreakModeWordWrap];  
          
          if (pageTextSize.height <= textLabel.frame.size.height) {  
            range.length = [pageText length];  
            break;  
          }  
          else {  
            range.length -= 2;  
          }  
        }  
        
        // 得到一个页面的显示范围  
        if (page >= maxPages) {  
          maxPages += 10;  
          rangeOfPages = (NSRange *)realloc(rangeOfPages, maxPages*sizeof(NSRange));  
        }  
        rangeOfPages[page++] = range;  
        
        // 更新游标  
        location += range.length;  
      }  
      
      // 获取最终页面数量  
      totalPages = page;  
      
      // 更新UILabel内容  
      textLabel.text = [text substringWithRange:rangeOfPages[currentPage]];  
    }  
  }  
  
  // 显示当前页面进度信息，格式为："8/100"  
  pageInfoLabel.text = [NSString stringWithFormat:@"%d/%d", currentPage+1, totalPages];  
}  


////////////////////////////////////////////////////////////////////////////////////////  
// 上一页  
- (IBAction)actionPrevious:(id)sender {  
  if (currentPage > 0) {  
    currentPage--;  
    
    NSRange range = rangeOfPages[currentPage];  
    NSString *pageText = [text substringWithRange:range];  
    
    textLabel.text = pageText;  
    
    //  
    pageInfoLabel.text = [NSString stringWithFormat:@"%d/%d", currentPage+1, totalPages];  
  }  
}  

////////////////////////////////////////////////////////////////////////////////////////  
// 下一页  
- (IBAction)actionNext:(id)sender {  
  if (currentPage < totalPages-1) {  
    currentPage++;  
    
    NSRange range = rangeOfPages[currentPage];  
    NSString *pageText = [text substringWithRange:range];  
    
    textLabel.text = pageText;  
    
    //  
    pageInfoLabel.text = [NSString stringWithFormat:@"%d/%d", currentPage+1, totalPages];  
  }  
}  
 */
@end
