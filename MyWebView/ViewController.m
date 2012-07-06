//
//  ViewController.m
//  MyWebView
//
//  Created by Coder Dream on 12-6-30.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
/**
 * 引入 Reachability 用来检测网络 */
#import "Reachability.h"
#import "GDataXMLNode.h"

@implementation ViewController

@synthesize myWebView;

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// 程序主流程
- (void)viewDidLoad { 
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
  //self.myWebView.delegate = self;
  //[self.view addSubview: self.myWebView];
  
  // 从 URL 上加载内容到 UIWebView
  /* 
   // 初始化
   [[UIApplication sharedApplication] statusBarOrientation];
   [super viewDidLoad];
   // 从 URL 中载入一个 html 页面
   NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
   [self.myWebView loadRequest:[NSURLRequest requestWithURL:url]];
   */
  
  // 从 APP 包内读取加载一个 HTML 文件
  /*
   // 初始化
   [[UIApplication sharedApplication] statusBarOrientation];
   [super viewDidLoad];
   // 从 APP 包内 载入一个 html 页面
   // NSString *htmlPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"webapp/index.html"];
   //webapp/
   NSString *htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"index.html"];
   [self.myWebview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
   */
  
  // 直接在 UIWebView 中写入一段 HTML 代码
  // 
  /* 
  // 读入一个 HTML section-0003
  //NSString *htmlPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"index.html"];
  NSString *htmlPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"section-0003.html"];
  NSString *htmlString = [NSString stringWithContentsOfFile: htmlPath encoding:NSUTF8StringEncoding error:NULL];
  [self.myWebview loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:htmlPath]];
  //self.myWebview set    
  */
  /*
   htmlPath 是一个必须的参数，而 htmlString 是可以可以直接写成  NSString *htmlString = @”<html ….”；不是必须从一个文件来获取 HTML 串的
   */
  /*  */
   // \"
   NSMutableString *htmlString = [[NSMutableString alloc] initWithCapacity:1024];
   [htmlString appendString:@"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">"];
   [htmlString appendString:@"<html>"];
   [htmlString appendString:@"<head>"];
   [htmlString appendString:@"<title> New Document </title>"];
   [htmlString appendString:@"<meta name=\"Generator\" content=\"EditPlus\">"];
   [htmlString appendString:@"</head>"];
   [htmlString appendString:@"<body>"];
   [htmlString appendString:@"Hello World! <a href=\"javascript:alert('Hello World!');\">Hello World!</a>"];
   [htmlString appendString:@"</body>"];
   [htmlString appendString:@"</html>"];
   //[self.myWebview loadHTMLString:htmlString baseURL:nil];
   
   // 加入htmlPath参数后，弹出窗口有页面来源信息，否则显示为null
   NSString *htmlPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"index.html"];
   [self.myWebView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:htmlPath]];
  
  
  /*
  NSLog(@"#### 1");
  // 读入配置文件
  NSArray *cookiesNodes = [self getConfigFromXml:@"config.xml" xmlNodePath:@"//configs/cookies/cookie"];
  NSLog(@"#### 2  %d", [cookiesNodes count]);

  // 循环操作
  for (int i=0; i<[cookiesNodes count]; i++) {
    // 取值
    NSString *cookieName = [[cookiesNodes objectAtIndex:i] stringValue]; // 在 GDB 窗口输出 LOG
    NSLog(@"%@", cookieName);
  }
  
  NSLog(@"#### 3  end");  
   
   */
}

- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
  myWebView = nil;
}

- (void)dealloc {
  [myWebView release];
  [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

// 仅仅允许横屏显示,如果要四个面都能旋转,return YES; 即可
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // return YES;
  return ((interfaceOrientation == UIInterfaceOrientationLandscapeRight) || (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)) ? NO : YES; 
}
/*
#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
  // starting the load, show the activity indicator in the status bar
  [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// 页面加载完时执行
- (void)webViewDidFinishLoad:(UIWebView *)webView {
  NSLog(@"webViewDidFinishLoad begin");
  // 引入全局变量
  AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
  // 如果是第一次加载
  if (appDelegate.webViewAction == @"loading") {
    // 效验网络链接
    //BOOL netConnect = [self checkNetworkStatus]; // 如果网络通畅
    BOOL netConnect = [self isReachabilitable]; // 如果网络通畅
    if (netConnect == YES) {
      // 标记状态改变 appDelegate.WebviewAction = @"login"; // 开始进入游戏,代码略
      NSLog(@"netConnect == YES");
    }
    else {
      // 网络链接失败,操作显示,代码略 
      NSLog(@"netConnect == NO");
    }
  } else if (appDelegate.webViewAction == @"login") {
    // 
    NSLog(@"不是第一次加载");
  }
  
  NSArray *nCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
  NSHTTPCookie *cookie;
  for (id c in nCookies) {
    if ([c isKindOfClass:[NSHTTPCookie class]]) {
      cookie=(NSHTTPCookie *)c;
      NSLog(@"%@: %@", cookie.name, cookie.value);
    }
  }
  NSLog(@"webViewDidFinishLoad end");
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
  
  return YES;
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

*/
#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
	// starting the load, show the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  NSLog(@"webViewDidFinishLoad");
	// finished loading, hide the activity indicator in the status bar
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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

// 网络检查
- (BOOL) checkNetworkStatus {
  //NSString *hostName = @"www.google.com";
  //- (SCNetworkReachabilityRef)  reachabilityRefForHostName:(NSString *)hostName;
  //- (SCNetworkReachabilityRef)  reachabilityRefForAddress:(NSString *)address;
  //  Reachability *r = [Reachability reachabilityWithHostName:hostName]; 
  //  if ([r currentReachabilityStatus] == NotReachable) {
  //    return NO; }
  //  else {
  return YES;
  //  } 
}

- (BOOL)isReachabilitable{
	// Check if the network is available, if not, show the hint and return.
	Reachability *reachability = [Reachability sharedReachability];
	NSString *ip = @"www.google.com";//[self getIPAddressForHost: webservice.serviceURL];
	if(ip == NULL) return FALSE;
	reachability.address = ip;
	NSLog(@"address ==>%@",reachability.address);
	//NetworkStatus connectionStatus = [reachability internetConnectionStatus];
	NetworkStatus connectionStatus = [reachability remoteHostStatus];
	if( connectionStatus == NotReachable ){
		return FALSE;
	}else{
		return TRUE;
	}
}

// 从 XML 中读取配置信息
// 使用 GData Client 库来解释 XML
- (NSArray *)getConfigFromXml:(NSString *)xmlFilePath xmlNodePath:(NSString *)xmlNodePath {
  NSLog(@"getConfigFromXml begin");
  NSString *xmlPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:xmlFilePath];
  NSString *xmlString = [NSString stringWithContentsOfFile: xmlPath encoding:NSUTF8StringEncoding error:NULL];
  NSError *error;
  GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithXMLString:xmlString options:0 error:&error];
  GDataXMLElement *rootNode = [document rootElement];
  // get cookie key by xpath
  NSArray *nodeList = [rootNode nodesForXPath:xmlNodePath error:&error];
  NSLog(@"getConfigFromXml end");
  return nodeList; 
}

@end
