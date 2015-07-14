//
//  CXActionSheet.h
//  自定义actionsheet
//
//  Created by 洪晨希 on 15/7/13.
//  Copyright (c) 2015年 洪晨希. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXActionSheet;

@protocol CXActionDelegate <NSObject>

@optional

-(void)actionSheetCancel:(CXActionSheet *)actionSheetCancel;

-(void)actionSheet:(CXActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface CXActionSheet : UIView

@property (nonatomic, strong)NSString *title;

@property (nonatomic, strong)NSString *cancelButtonTitle;

@property (nonatomic, weak) id<CXActionDelegate>delegate;

-(id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle, ... NS_REQUIRES_NIL_TERMINATION;

-(void)show;

-(void)hide;

-(void)setTitleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize;

-(void)setButtonTitleColor:(UIColor *)buttonTitleColor fontSize:(CGFloat)fontSize atIndex:(int)atIndex;

-(void)setCancelButtonTitleColor:(UIColor *)cancelButtonTitleColor fontSize:(CGFloat)fontSize;

@end
