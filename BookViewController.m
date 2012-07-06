//
//  BookViewController.m
//  MyWebView
//
//  Created by Coder Dream on 12-7-4.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import "BookViewController.h"
//#import "Constants.h"

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
  // 从 URL 中载入一个 html 页面
  //NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
  //[self.myWebView loadRequest:[NSURLRequest requestWithURL:url]];
  // 从 APP 包内 载入一个 html 页面
  //NSString *htmlPath = [[[NSBundle mainBundle] bundlePath]                      stringByAppendingPathComponent:@"section-0003.html"];
  
  //sectionName
  NSString *htmlPath = [[[NSBundle mainBundle] bundlePath]
                        stringByAppendingPathComponent: self.sectionName];
  // NSString *htmlPath = [[[NSBundle mainBundle] resourcePath]
  // stringByAppendingPathComponent:@"webapp/index.html"];
  [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
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
@end
