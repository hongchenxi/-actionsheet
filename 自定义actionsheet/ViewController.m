//
//  ViewController.m
//  自定义actionsheet
//
//  Created by 洪晨希 on 15/7/13.
//  Copyright (c) 2015年 洪晨希. All rights reserved.
//

#import "ViewController.h"
#import "CXActionSheet.h"
@interface ViewController ()<CXActionDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutAction:(id)sender {
    
    CXActionSheet *sheet = [[CXActionSheet alloc]initWithTitle:@"退出账号将中断当前未发送完的内容" delegate:self cancelButtonTitle:@"取消" otherButtonTitle:@"退出", nil];
    [sheet setCancelButtonTitleColor:[UIColor blackColor] fontSize:0];
    [sheet setButtonTitleColor:[UIColor redColor] fontSize:0 atIndex:0];
    [sheet show];
    
    
}
-(void)actionSheet:(CXActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            NSLog(@"点击了第一个");
            break;
            
        default:
            break;
    }
}


@end
