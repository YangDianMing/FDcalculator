//
//  ViewController.m
//  YCSlideViewDome
//
//  Created by 王禹丞 on 16/1/29.
//  Copyright © 2016年 wyc. All rights reserved.
//

#import "BenjinViewController.h"
#import "SJDataTableView.h"
#import "YDMDataTableView.h"
#import "MortgageCalculationModel.h"

#define kWindowWidth                        ([[UIScreen mainScreen] bounds].size.width)

#define kWindowHeight                       ([[UIScreen mainScreen] bounds].size.height)

#define KCount 300

@interface BenjinViewController ()



@end

@implementation BenjinViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /*
    self.mc = [MortgageCalculationModel new];
    self.mc.LoanAmount = 300000;
    self.mc.LoanTerm = 360;
    self.mc.LoanRatesYers = 0.049;
    [self.mc PrincipalCalculation];
     */
    [self setLableRectFram:_labelMonthRepayment];
    [self setLableRectFram:_labelTotalInterest];
    [self setLableRectFram:_labelTotalRepayment];
    [self setLableRectFram:_labelMonthlyDecline];
    
    //self.scrollViewTable = nil;
    
}

-(void)setLableRectFram:(UILabel*)label{
    CGRect labelRect = label.frame;
    labelRect.size.width = kWindowWidth/2-20;
    labelRect.origin.x = kWindowWidth/2;
    label.frame = labelRect;
}

-(void)viewDidLayoutSubviews{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)benjinload{
    [[self.view viewWithTag:22] removeFromSuperview];//清空表视图
    int Count = self.mc.LoanTerm+1;
    NSArray * headerAarray = [[NSArray alloc] initWithObjects:@"期次", @"偿还本息", @"偿还本金", @"支付利息", @"剩余本金", nil];
    NSMutableArray *dataArray = [NSMutableArray new];
    for (int i = 1 ; i< Count; i++) {
        NSMutableDictionary *dataDict = [NSMutableDictionary new];
        [dataDict setObject:[NSString stringWithFormat:@"%.0f",[self.mc.principalArray[i][0] floatValue]] forKey:[headerAarray objectAtIndex:0]];
        [dataDict setObject:[NSString stringWithFormat:@"%.2f",[self.mc.principalArray[i][1] floatValue]] forKey:[headerAarray objectAtIndex:1]];
        [dataDict setObject:[NSString stringWithFormat:@"%.2f",[self.mc.principalArray[i][2] floatValue]] forKey:[headerAarray objectAtIndex:2]];
        [dataDict setObject:[NSString stringWithFormat:@"%.2f",[self.mc.principalArray[i][3] floatValue]] forKey:[headerAarray objectAtIndex:3]];
        [dataDict setObject:[NSString stringWithFormat:@"%.2f",[self.mc.principalArray[i][4] floatValue]] forKey:[headerAarray objectAtIndex:4]];
        [dataArray addObject:dataDict];
    }
    
    YDMDataTableView * table =[[YDMDataTableView alloc] initWithFrame:CGRectMake(0, 160, kWindowWidth, Count*30+35) headerSize:CGSizeMake(kWindowWidth*0.2f, 30)];
    [table setTag:22];
    [table setHeaderArray:headerAarray dataArray:dataArray];
    self.scrollViewTable.contentSize = CGSizeMake(kWindowWidth, Count*30+35+160);//滚动内大小
    
    //self.scrollViewTable.frame.size.height;约等于下面
    CGRect scrollViewTableRect = self.scrollViewTable.frame;
    scrollViewTableRect.size.height = kWindowHeight - 350;
    scrollViewTableRect.size.width = kWindowWidth;
    self.scrollViewTable.frame = scrollViewTableRect;
    
    CGRect viewRect = self.viewTopView.frame;
    viewRect.size.width = kWindowWidth;
    self.viewTopView.frame = viewRect;
    
    //self.view.backgroundColor = [UIColor redColor];//调试红色背景
    
    [self.scrollViewTable addSubview:table];
    table = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
