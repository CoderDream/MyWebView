//
//  CDLabel.h
//  MyWebView
//
//  Created by Coder Dream on 12-7-19.
//  Copyright (c) 2012年 CoderDream's Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDLabel : UILabel

@property (nonatomic, retain) UIFont *font;
@property (nonatomic) NSInteger numberOfLines;
@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic) UILineBreakMode lineBreakMode;    // 不可少Label属性之二
/*
//设置标签文本
label1.text =  prePageStr;
//设置标签文本字体和字体大小
label1.font = [UIFont fontWithName:@"Arial" size:30];
//设置文本对其方式
label1.textAlignment = UITextAlignmentCenter;
//文本对齐方式有以下三种
//typedef enum {
//    UITextAlignmentLeft = 0,左对齐
//    UITextAlignmentCenter,居中对齐
//    UITextAlignmentRight, 右对齐                 
//} UITextAlignment;

//文本颜色
label1.textColor = [UIColor blueColor];
//超出label边界文字的截取方式
label1.lineBreakMode = UILineBreakModeTailTruncation;
//截取方式有以下6种
//typedef enum {       
//    UILineBreakModeWordWrap = 0,    以空格为边界，保留整个单词         
//    UILineBreakModeCharacterWrap,   保留整个字符         
//    UILineBreakModeClip,            到边界为止         
//    UILineBreakModeHeadTruncation,  省略开始，以……代替       
//    UILineBreakModeTailTruncation,  省略结尾，以……代替      
//    UILineBreakModeMiddleTruncation,省略中间，以……代替，多行时作用于最后一行       
//} UILineBreakMode;

//文本文字自适应大小
label1.adjustsFontSizeToFitWidth = YES;
//当adjustsFontSizeToFitWidth=YES时候，如果文本font要缩小时
//baselineAdjustment这个值控制文本的基线位置，只有文本行数为1是有效
label1.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
//有三种方式
//typedef enum {
//    UIBaselineAdjustmentAlignBaselines = 0, 默认值文本最上端于label中线对齐
//    UIBaselineAdjustmentAlignCenters,//文本中线于label中线对齐
//    UIBaselineAdjustmentNone,//文本最低端与label中线对齐
//} UIBaselineAdjustment;

//文本最多行数，为0时没有最大行数限制
label1.numberOfLines = 2;
//最小字体，行数为1时有效，默认为0.0
label1.minimumFontSize = 10.0;
//文本高亮
label1.highlighted = YES;
//文本是否可变
label1.enabled = YES;
 */
@end
