//
//  MyLabel.h
//  MyUILabel
//
//  Created by Coder Dream on 12-7-20.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLabelDelegate.h"

@interface MyLabel : UILabel {
  id<MyLabelDelegate> delegate;
}

@property (nonatomic, assign) id <MyLabelDelegate> delegate;
- (id)initWithFrame:(CGRect)frame;

@end
