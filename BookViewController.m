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
@end
