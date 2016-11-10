//
//  MainViewController.m
//  FDcalculator
//
//  Created by 杨殿铭 on 2016/11/10.
//  Copyright © 2016年 杨殿铭. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击切换
- (IBAction)segmentClick:(id)sender {
    UISegmentedControl* control = (UISegmentedControl*)sender;
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *SyView = [board instantiateViewControllerWithIdentifier:@"SyView"];
    UIViewController *GjjView = [board instantiateViewControllerWithIdentifier:@"GjjView"];
    
    switch (control.selectedSegmentIndex) {
        case 0:
            NSLog(@"0");
            //OneViewController  *oneView = [[[OneViewController alloc] init] autorelease];
            
            [self.mainView addSubview:SyView.view];
            
            //[self.view removeFromSuperview];
            break;
        case 1:
            NSLog(@"1");
            [self.mainView addSubview:GjjView.view];
            break;
        default:
            NSLog(@"2");
            break;
    }
}

@end
