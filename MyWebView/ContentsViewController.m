//
//  ContentsViewController.m
//  MyWebView
//
//  Created by Coder Dream on 12-7-6.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import "ContentsViewController.h"
#import "BookViewController.h"
#import "Contents.h"

@implementation ContentsViewController
@synthesize myTableView;
@synthesize tableData;
@synthesize contentsData;
@synthesize bookViewController = _bookViewController;

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

/* */
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"viewDidLoad");
  
  self.title = NSLocalizedString(@"WebTitle", @"");
  
  CGRect webFrame = [[UIScreen mainScreen] applicationFrame];
  webFrame.origin.y += 20.0 + 5.0;	// leave from the URL input field and its label
  webFrame.size.height -= 40.0;
  self.myTableView = [[[UITableView alloc] initWithFrame:webFrame] autorelease];
  self.myTableView.backgroundColor = [UIColor whiteColor];
  //self.tableView.scalesPageToFit = YES;
  self.myTableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  self.myTableView.delegate = self;
  [self.view addSubview:self.myTableView];
  
  /*
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
   [self.bookWebView loadHTMLString:htmlString baseURL:nil];
   */
  
  // Create the array to hold the table data
  self.tableData = [[NSMutableArray alloc] init];
  
  /*
   // Create and add 10 data items to the table data array
   for (NSUInteger i=0; i<10; i++) {
   
   // The cell will contain a string "Item X"
   NSString *dataString = [NSString stringWithFormat:@"Item %d", i];
   
   // Here the new string is added to the end of the array
   [self.tableData addObject:dataString];
   
   }
   [self readWritePlist];
   */
  
  /* TODO
   
   // Create dummy data    
   NSUInteger numberOfNames = 25;
   
   self.tableData = [[NSMutableArray alloc] initWithCapacity:numberOfNames];
   
   // Create a temporary array of tableData
   for (NSUInteger i = 0; i < numberOfNames; i++) {        
   // Create a new name with nonsense data
   // BNName *tempName = [self createNameWithNonsenseDataWithIndex:i];
   NSString *string = @"test";
   // Add it to the temporary array
   [self.tableData addObject:string];        
   }
   */
  
  NSString *homePath = [[NSBundle mainBundle] executablePath];
	NSArray *strings = [homePath componentsSeparatedByString: @"/"];
	NSString *executableName  = [strings objectAtIndex:[strings count]-1];	
	NSString *baseDirectory = [homePath substringToIndex:
                             [homePath length]-[executableName length]-1];	
	
	NSString *filePath = [NSString stringWithFormat:@"%@/contents.plist",baseDirectory];
  NSLog(@"filePath: %@",filePath);
	//NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
	NSMutableDictionary *dataDict = 
	[[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
	NSLog(@"dataDict: %@",dataDict);
  self.contentsData = dataDict;
	//change the value
	//[dataDict setObject:@"YES" forKey:@"Trial"];
	//write back to file
	//[dataDict writeToFile:filePath atomically:NO];
  
  /*
   NSMutableArray* tempArray = [NSMutableArray arrayWithArray:[dataDict allKeys]]; 
   
   NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"key" ascending:YES];
   NSArray *sortDescriptors=[[NSArray alloc] initWithObjects:&sortDescriptor count:1];
   [tempArray sortUsingDescriptors:sortDescriptors]; 
   for (NSObject *object in tempArray) {
   NSLog(@"遍历Value的值: %@",object);
   [self.tableData addObject:object];  
   }
   */
  
  NSArray *keys = [dataDict allKeys];
  
  NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
    return [obj1 compare:obj2 options:NSNumericSearch];    
  }];
  
  int countOfContents = [sortedArray count];
  // Create a temporary array of tableData
  for (NSUInteger i = 0; i < countOfContents; i++) {  
    
    NSString *categoryId = [sortedArray objectAtIndex:i];
    NSString *strValue = [dataDict objectForKey:categoryId];
    // Create a new name with nonsense data     
    
    // Create a new name with nonsense data
    //Contents *tempName = [self createNameWithNonsenseDataWithIndex:i];
    Contents *tempName = [[Contents alloc] init];
    tempName.sectionName = categoryId;
    tempName.contentName = strValue;
    // Add it to the temporary array
    [self.tableData addObject:tempName]; 
  }
  /*
  for (NSString *categoryId in sortedArray) {
   
    NSLog(@"[dataDict objectForKey:categoryId] === %@",strValue);
    [self.tableData addObject:strValue]; 
  }
   */
  /* TODO*/

  
     
  // 把表视图添加到窗口
  myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
  [myTableView setDelegate:self];
  [myTableView setDataSource:self];
  [self.view addSubview: myTableView];
  [myTableView release];
  
  /*
   //得到词典的数量
   int count = [dataDict count];
   NSLog(@"词典的数量为： %d",count);
   
   //得到词典中所有KEY值
   NSEnumerator * enumeratorKey = [dataDict keyEnumerator];
   
   //快速枚举遍历所有KEY的值
   for (NSObject *object in enumeratorKey) {
   NSLog(@"遍历KEY的值: %@",object);
   }
   
   //得到词典中所有Value值
   NSEnumerator * enumeratorValue = [dataDict objectEnumerator];
   
   //快速枚举遍历所有Value的值
   for (NSObject *object in enumeratorValue) {
   NSLog(@"遍历Value的值: %@",object);
   // [self.tableData addObject:object];  
   }
   
   myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
   [myTableView setDelegate:self];
   [myTableView setDataSource:self];
   [self.view addSubview: myTableView];
   [myTableView release];
   
   
   
   // Create an instance of BNViewController
   //BNViewController *bnViewController = [[BNViewController alloc] initWithNibName:@"BNViewController" bundle:nil];
   
   // Pass the array of dummy names into the view controller
   //bnViewController.tableData = (NSArray *)self.tableData;
   
   // Print out the contents of the array into the log
   NSLog(@"The tableData array contains %@", self.tableData);
   }
   
   - (void)readWritePlist {
   NSMutableArray *tempTableData = [[NSMutableArray alloc] init];
   NSString *homePath = [[NSBundle mainBundle] executablePath];
   NSArray *strings = [homePath componentsSeparatedByString: @"/"];
   NSString *executableName  = [strings objectAtIndex:[strings count]-1];	
   NSString *baseDirectory = [homePath substringToIndex:
   [homePath length]-[executableName length]-1];	
   
   NSString *filePath = [NSString stringWithFormat:@"%@/content.plist",baseDirectory];
   NSLog(@"filePath: %@",filePath);
   //NSDictionary *dataDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
   NSMutableDictionary *dataDict = 
   [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
   NSLog(@"dataDict: %@",dataDict);
   //change the value
   //[dataDict setObject:@"YES" forKey:@"Trial"];
   //write back to file
   //[dataDict writeToFile:filePath atomically:NO];
   //得到词典的数量
   int count = [dataDict count];
   NSLog(@"词典的数量为： %d",count);
   
   //得到词典中所有KEY值
   NSEnumerator * enumeratorKey = [dataDict keyEnumerator];
   
   //快速枚举遍历所有KEY的值
   for (NSObject *object in enumeratorKey) {
   NSLog(@"遍历KEY的值: %@",object);
   }
   
   //得到词典中所有Value值
   NSEnumerator * enumeratorValue = [dataDict objectEnumerator];
   
   //快速枚举遍历所有Value的值
   for (NSObject *object in enumeratorValue) {
   NSLog(@"遍历Value的值: %@",object);
   [self.tableData addObject:object];  
   }
   */
  /*
   //通过KEY找到value
   NSObject *object = [dataDict objectForKey:@"name"];
   
   if (object != nil) {
   NSLog(@"通过KEY找到的value是: %@",object);
   }
   */
  
	[dataDict release];	
  
  //return tempTableData;
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


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.tableData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  /*
  static NSString *cellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  
  cell.textLabel.text = [self.tableData objectAtIndex:indexPath.row];
  
  return cell;  
   */
  static NSString *cellIdentifier = @"ContentsCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  
  // Extract the BNName object from the tableData
  Contents *tempName = [self.tableData objectAtIndex:indexPath.row];
  
  // Update the cell's textLabel
  cell.textLabel.text = tempName.contentName;
  
  return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  NSLog(@"Table row %d has been tapped", indexPath.row);
   
  bookViewController = [[BookViewController alloc] initWithNibName:nil bundle:NULL];
 // bookViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
  bookViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
  NSString *tempSectionName = [[self.tableData objectAtIndex:indexPath.row] sectionName];
  NSLog(@"tempSectionName: %@", tempSectionName);
  bookViewController.sectionName = tempSectionName;
  [self presentModalViewController:bookViewController animated:YES];
  [bookViewController release];
}

@end
