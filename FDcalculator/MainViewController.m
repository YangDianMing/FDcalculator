//
//  MainViewController.m
//  FDcalculator
//
//  Created by 杨殿铭 on 2016/11/10.
//  Copyright © 2016年 杨殿铭. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic,strong) UIViewController *SyView;
@property (nonatomic,strong) UIViewController *GjjView;
@property (nonatomic,strong) UIViewController *HhView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _SyView = [board instantiateViewControllerWithIdentifier:@"SyView"];
    _GjjView = [board instantiateViewControllerWithIdentifier:@"GjjView"];
    _HhView = [board instantiateViewControllerWithIdentifier:@"HhView"];
    //[self.mainView addSubview:_HhView.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击切换
- (IBAction)segmentClick:(id)sender {
    UISegmentedControl* control = (UISegmentedControl*)sender;
    switch (control.selectedSegmentIndex) {
        case 0:
            NSLog(@"0");
            [self.mainView addSubview:_SyView.view];
            break;
        case 1:
            NSLog(@"1");
            [self.mainView addSubview:_GjjView.view];
            break;
        default:
            NSLog(@"2");
            [self.mainView addSubview:_HhView.view];
            break;
    }
}

@end
