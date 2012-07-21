//
//  MyLabelDelegate.h
//  MyUILabel
//
//  Created by Coder Dream on 12-7-20.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyLabel;
@protocol MyLabelDelegate <NSObject>
@required
- (void)myLabel:(MyLabel *)myLabel touchesWtihTag:(NSInteger)tag;
@end