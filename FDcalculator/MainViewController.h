//
//  MainViewController.h
//  FDcalculator
//
//  Created by 杨殿铭 on 2016/11/10.
//  Copyright © 2016年 杨殿铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *mainSegmented;

@property (weak, nonatomic) IBOutlet UIView *mainView;
- (IBAction)segmentClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (nonatomic,strong)NSArray * vcArray;


@end
