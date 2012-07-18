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
@synthesize myCycleUILabelView = _myCycleUILabelView;
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
  // make many paragraphe
  // NSString *secondParaContent = [lines objectAtIndex:1];
  int oneLineSize = 10; 
  
  // NSArray *stringArray = [[NSArray alloc] arrayWithCapacity:times];
  NSMutableArray *stringArray = [NSMutableArray array];
  //  res = [str1 substringWithRange: NSMakeRange (8, 6)];
  NSString *res;//
  NSInteger lineSize;
  NSInteger idx;
  for (idx = 0; idx < lines.count; idx++){
    NSString *currentLineContent = [lines objectAtIndex:idx];
    lineSize = [currentLineContent length];
    //NSLog(@"%d: size: %d %@", idx, lineSize, currentContent);
    // NSLog(@"%d: size: %d", idx, lineSize);
    
    NSUInteger lineLength = [currentLineContent length];
    //  NSLog(@"line length: %u : %@", lineLength, currentLineContent);
    NSInteger mod = lineLength % oneLineSize;
    NSInteger times = lineLength / oneLineSize;
    int begin = 0;
    
    int idxLine;
    for (idxLine = 0; idxLine < times; idxLine++){
      // NSString *currentContent = [lines objectAtIndex:idx];
      // stringArray[idx] = res;
      begin = idxLine * oneLineSize;
      //NSLog(@"begin:  %d: ", begin);
      res = [currentLineContent substringWithRange: NSMakeRange (begin, oneLineSize)];
      //NSLog(@"size:  %d: count: %@", idxLine, res);
      [stringArray addObject:res];
      // lineSize = [currentContent length];
      //NSLog(@"%d: size: %d %@", idx, lineSize, currentContent);
      // NSLog(@"%d: size: %d", idx, lineSize);
    }     
    
    if (0 != mod) {
      // times += 1;
      res = [currentLineContent substringWithRange: NSMakeRange (idxLine * oneLineSize, lineLength - idxLine * oneLineSize)];
      [stringArray addObject:res];
      //NSLog(@"size:  %d: count: %@", idxLine, res);
    }
  }
  
  NSLog(@"### stringArray count: %d", [stringArray count]);
  
  // = [str1 substringWithRange: NSMakeRange (8, 6)];
  /*
   res = [secondLineContent substringWithRange: NSMakeRange (0, 50)];
   NSLog(@"size:  1:    count: %@", res);
   //res = [secondLineContent substringWithRange: NSMakeRange (0, 49)];
   res = [secondLineContent substringWithRange: NSMakeRange (50, 50)];
   NSLog(@"size:  2:    count: %@", res);
   res = [secondLineContent substringWithRange: NSMakeRange (100, 50)];
   //res = [secondLineContent substringWithRange: NSMakeRange (100, 149)];
   NSLog(@"size:  3:    count: %@", res);
   res = [secondLineContent substringWithRange: NSMakeRange (150, 50)];
   //res = [secondLineContent substringWithRange: NSMakeRange (150, 199)];
   NSLog(@"size:  4:    count: %@", res);
   
   
   int begin;
   
   int idxLine;
   for (idxLine = 0; idxLine < times; idxLine++){
   // NSString *currentContent = [lines objectAtIndex:idx];
   // stringArray[idx] = res;
   begin = idxLine * lineSize;
   NSLog(@"begin:  %d: ", begin);
   res = [secondParaContent substringWithRange: NSMakeRange (begin, lineSize)];
   NSLog(@"size:  %d: count: %@", idxLine, res);
   [stringArray addObject:res];
   // lineSize = [currentContent length];
   //NSLog(@"%d: size: %d %@", idx, lineSize, currentContent);
   // NSLog(@"%d: size: %d", idx, lineSize);
   }   
   
   
   if (0 != mod) {
   // times += 1;
   res = [secondParaContent substringWithRange: NSMakeRange (idxLine * lineSize, lineLength - idxLine * lineSize)];
   [stringArray addObject:res];
   NSLog(@"size:  %d: count: %@", idxLine, res);
   }
   */
  //self.myCycleUILabelView = [[[CycleUILabelView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) contentArray:stringArray pages:5 scrollDirection:LandscapeDirection] autorelease ];
  // [self.view addSubview:self.myCycleUILabelView];
  
  //self.myCycleUILabelView = [[[CycleUILabelView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) fileName:@"a00" pages:5 scrollDirection:LandscapeDirection] autorelease ];
  //[self.view addSubview:self.myCycleUILabelView];
  NSArray *contents= [[NSArray alloc] initWithObjects:
                      @"One",@"Two",@"Three",@"Four",@"Five",@"Six",@"Seven",@"Eghit",nil];
  self.myCycleUILabelView =  [[[CycleUILabelView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) contentArray:contents scrollDirection:LandscapeDirection] autorelease];
  [self.view addSubview:self.myCycleUILabelView];
  
  UIView *bottomView = [[ UIView alloc ]  initWithFrame :CGRectMake (0, 480-70, 360, 70 )];
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
