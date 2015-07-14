//
//  CXActionSheet.m
//  自定义actionsheet
//
//  Created by 洪晨希 on 15/7/13.
//  Copyright (c) 2015年 洪晨希. All rights reserved.
//

#import "CXActionSheet.h"

#define Margin 5
@interface CXActionSheet()

@property (nonatomic, strong)UIView *backgroudView;
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UIView *buttonView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)NSMutableArray *buttonArray;
@property (nonatomic, strong)NSMutableArray *buttonTitleArray;
@property (nonatomic, strong)UIButton *cancelButton;

@end

CGFloat contentViewWidth;
CGFloat contentViewHeight;

@implementation CXActionSheet


-(id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitles, ...{
    
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.title = title;
        self.delegate = delegate;
        self.cancelButtonTitle = cancelButtonTitle;
        self.buttonArray = [NSMutableArray array];
        self.buttonTitleArray = [NSMutableArray array];
        
        va_list args;
        va_start(args,otherButtonTitles);
        if (otherButtonTitles) {
            [self.buttonTitleArray addObject:otherButtonTitles];
            while (1) {
                NSString *otherButtonTitle = va_arg(args, NSString *);
                if (otherButtonTitle == nil) {
                    break;
                }else{
                    [self.buttonTitleArray addObject:otherButtonTitle];
                }
            }
        }
        va_end(args);
        
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        
        self.backgroudView = [[UIView alloc]initWithFrame:self.frame];
        self.backgroudView.backgroundColor = [UIColor blackColor];
        self.backgroudView.alpha = 0.2;
        [self.backgroudView addGestureRecognizer:tapGestureRecognizer];
        [self addSubview:self.backgroudView];
        
        [self initContentView];
    }
    return self;
}

-(void)initContentView{
    contentViewWidth = [UIScreen mainScreen].bounds.size.width;
    contentViewHeight = 0;
    
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:231.0/255.0 blue:232.0/255.0 alpha:1.0];
    
    self.buttonView = [[UIView alloc]init];
    self.buttonView.backgroundColor = [UIColor clearColor];
    
    [self initTitle];
    [self initButtons];
    [self initCancelButton];
    
    self.contentView.frame = CGRectMake((self.frame.size.width - contentViewWidth)/2, self.frame.size.height, contentViewWidth, contentViewHeight);
    [self addSubview:self.contentView];
    
}

-(void)initTitle{
    if (self.title !=nil && ![self.title isEqualToString:@""]) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, contentViewWidth, 53)];
        self.titleLabel.text = self.title;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor colorWithRed:90 / 255.0 green:90 / 255.0 blue:90 / 255.0 alpha:1.0];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        [self.buttonView addSubview:self.titleLabel];
        contentViewHeight += self.titleLabel.frame.size.height;
    }
}

-(void)initButtons{
    if (self.buttonTitleArray.count > 0) {
        NSInteger count = self.buttonTitleArray.count;
        for (int i = 0; i < count; i++) {
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, contentViewHeight, contentViewWidth, 1)];
            lineView.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:0.5];
            [self.buttonView addSubview:lineView];
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, contentViewHeight + 1, contentViewWidth, 53)];
            [button setBackgroundImage:[self resizedImage:@"resource.bundle/common_background"] forState:UIControlStateNormal];
            [button setBackgroundImage:[self resizedImage:@"resource.bundle/common_background_highlighted"] forState:UIControlStateHighlighted];
            button.titleLabel.font = [UIFont systemFontOfSize:18];
            [button setTitle:self.buttonTitleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
            
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.buttonArray addObject:button];
            [self.buttonView addSubview:button];
            contentViewHeight += lineView.frame.size.height + button.frame.size.height;
            
        }
        self.buttonView.frame = CGRectMake(0, 0, contentViewWidth, contentViewHeight);
        [self.contentView addSubview:self.buttonView];
        
        
    }

}

-(void)initCancelButton{
    if (self.cancelButtonTitle!= nil) {
        self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, contentViewHeight + Margin, contentViewWidth, 53)];
        [self.cancelButton setBackgroundImage:[self resizedImage:@"resource.bundle/common_background"] forState:UIControlStateNormal];
        [self.cancelButton setBackgroundImage:[self resizedImage:@"resource.bundle/common_background_highlighted"] forState:UIControlStateHighlighted];
        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:[UIColor colorWithRed:0 / 255.0 green:122 / 255.0 blue:255 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.cancelButton];
        contentViewHeight += Margin + self.cancelButton.frame.size.height;
        
    }

}

-(void)setTitle:(NSString *)title{
    _title = title;
    
    [self initContentView];
}

-(void)setCancelButtonTitle:(NSString *)cancelButtonTitle{
    _cancelButtonTitle = cancelButtonTitle;
    
    [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
}

-(void)show{

    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [window addSubview:self];
    [self addAnimation];
}

-(void)hide{
    
    [self removeAnimation];
    
}

-(void)addAnimation{

    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{

        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.frame.size.height - self.contentView.frame.size.height, self.contentView.frame.size.width, self.contentView.frame.size.height);
        
        self.backgroudView.alpha = 0.7;
        
    } completion:^(BOOL finished) {
        
    }];

}

-(void)removeAnimation{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.frame.size.height, self.contentView.frame.size.width, self.contentView.frame.size.height);
        
        self.backgroudView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        self.contentView = nil;
        
    }];
    
}


-(void)setTitleColor:(UIColor *)titleColor fontSize:(CGFloat)fontSize{
    if (titleColor != nil) {
        self.titleLabel.textColor = titleColor;
    }
    if (fontSize > 0) {
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
}

-(void)setButtonTitleColor:(UIColor *)buttonTitleColor fontSize:(CGFloat)fontSize atIndex:(int)atIndex{
    
    UIButton *btn = self.buttonArray[atIndex];
    if (buttonTitleColor != nil) {
        [btn setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    }
    
    if (fontSize > 0) {
        btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
   
}

-(void)setCancelButtonTitleColor:(UIColor *)cancelButtonTitleColor fontSize:(CGFloat)fontSize{
    
    if (cancelButtonTitleColor != nil) {
        [self.cancelButton setTitleColor:cancelButtonTitleColor forState:UIControlStateNormal];
    }
    if (fontSize > 0) {
        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }

}

-(void)buttonClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        for (int i = 0; i < self.buttonArray.count; i++) {
            if (btn == self.buttonArray[i]) {
                [self.delegate actionSheet:self clickedButtonAtIndex:i];
                break;
            }
        }
    }
    [self hide];

}

-(void)cancelButtonClick:(UIButton *)cancelBtn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheetCancel:)]) {
        [self.delegate actionSheetCancel:self];
    }
    [self hide];

}

-(UIImage *)resizedImage:(NSString *)name{
    UIImage *img = [UIImage imageNamed:name];
    return [img stretchableImageWithLeftCapWidth:img.size.width *0.5 topCapHeight:img.size.height *0.5];

}






@end
