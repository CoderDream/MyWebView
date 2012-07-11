//
//  BookViewController.m
//  MyWebView02
//
//  Created by Coder Dream on 12-7-8.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import "BookViewController.h"

@implementation BookViewController

//@synthesize myCycleScrollView = _myCycleScrollView;
@synthesize myCycleView = _myCycleView;
@synthesize sectionName = _sectionName;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  /*
   CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
   webFrame.origin.y += 20.0 + 5.0;	// leave from the URL input field and its label
   webFrame.size.height -= 40.0;
   self.myCycleScrollView = [[[CycleScrollView alloc] initWithFrame:webFrame fileName:@"a0" pages:1 scrollDirection:2] autorelease];
   //(id)initWithFrame:(CGRect)frame fileName:(NSString*)name pages:(int)pages scrollDirection:(CycleDirection)direction
   [self.view addSubview:self.myCycleScrollView];
   */
  
  // NSArray *imagesArray=[[NSArray alloc] initWithObjects: [UIImage  imageNamed:@"a01.png"],[UIImage imageNamed:@"a02.png"],[UIImage imageNamed:@"a03.png"],nil];
  
  // CycleScrollView *cycle = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) cycleDirection:0 pictures:imagesArray];
  
  // second method
  NSError *error;
  //stringWithContentsOfURL
  NSString *txtPath = [[[NSBundle mainBundle] bundlePath]
                       stringByAppendingPathComponent: self.sectionName];
  NSString *textFileContents = [NSString stringWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error: &error];
  
  //  NSString *textFileContents = [NSString stringWithContentsOfURL:[NSURL txtPath] encoding:NSUTF8StringEncoding error: &error];
  
  // If there are no results, something went wrong
  if (textFileContents == nil) {
    // an error occurred
    NSLog(@"Error reading text file. %@", [error localizedFailureReason]);
  }
  
  NSArray *lines = [textFileContents componentsSeparatedByString:@"\n"];
  NSLog(@"Number of lines in the file:%d", [lines count] );
  NSInteger lineSize;
  NSInteger idx;
  for (idx = 0; idx < lines.count; idx++){
    NSString *currentContent = [lines objectAtIndex:idx];
    lineSize = [currentContent length];
    //NSLog(@"%d: size: %d %@", idx, lineSize, currentContent);
    NSLog(@"%d: size: %d", idx, lineSize);
  }
  
  NSString *secondLineContent = [lines objectAtIndex:1];

  
  self.myCycleView = [[[CycleView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) fileName:@"a00" pages:5 scrollDirection:LandscapeDirection] autorelease ];
  [self.view addSubview:self.myCycleView];
  
  UIView *bottomView=[[ UIView alloc ]  initWithFrame :CGRectMake (0, 480-70, 360, 70 )];
  bottomView.backgroundColor=[ UIColor grayColor ];
  bottomView.alpha= 0.8 ;
  
  //UIButton *backButton=[[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 40)];
  UIButton *backButton=[ UIButton buttonWithType : UIButtonTypeRoundedRect ];
  [backButton setTitle: @"回目录" forState: UIControlStateNormal ];
  backButton.frame= CGRectMake (10 , 15, 100, 40 );
  
  [bottomView addSubview:backButton];
  // TODO
  //添加点击按钮所执行的程式
  
  [backButton addTarget: self action :@selector (buttonClicked)forControlEvents: UIControlEventTouchUpInside ];
  [self. view addSubview :bottomView];

  
  //cycle.delegate = self;
  // [self.view addSubview:cycle];
  // [imagesArray release];
  // [cycle release];
}

-(void) buttonClicked {
  
  NSLog( @"get detail …, window.views: %@",self. view .window .subviews);
  //[self.view removeFromSuperview];
  [self dismissModalViewControllerAnimated :YES];
}


-(void)pageViewClicked:(NSInteger)pageIndex {
  NSLog(@"pageViewClicked");
}


- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
