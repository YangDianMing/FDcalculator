//
//  ViewController.m
//  FDcalculator
//
//  Created by 杨殿铭 on 16/10/8.
//  Copyright © 2016年 杨殿铭. All rights reserved.
//

#import "ViewController.h"
#import "YCSlideView.h"

#import "BenxiViewController.h"
#import "BenjinViewController.h"

#define kWindowWidth                        ([[UIScreen mainScreen] bounds].size.width)

#define kWindowHeight                       ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 将控制器已Key = 标题 Value = 控制器 存入数组
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController * SyBenxiController = [mainStoryboard instantiateViewControllerWithIdentifier:@"SyBenxi"];
    UIViewController * SyBenjinController = [mainStoryboard instantiateViewControllerWithIdentifier:@"SyBenjin"];
    
    NSArray *viewControllers = @[@[@"等额本息",SyBenxiController,@"1305"],@[@"等额本金",SyBenjinController,@"1645"]];
    
    YCSlideView * view = [[YCSlideView alloc]initWithFrame:CGRectMake(0, 275, kWindowWidth, kWindowHeight) WithViewControllers:viewControllers];
    
    [self.view addSubview:view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
