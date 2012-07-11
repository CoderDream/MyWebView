//
//  ContentsViewController.h
//  MyWebView
//
//  Created by Coder Dream on 12-7-6.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookViewController.h"

@interface ContentsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
  
  BookViewController *bookViewController;
}

@property (strong, nonatomic) BookViewController *bookViewController;

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) NSMutableArray *tableData; // holds the table data

@property (nonatomic, strong) NSMutableDictionary *contentsData;
@end
