//
//  ViewController.m
//  YCSlideViewDome
//
//  Created by 王禹丞 on 16/1/29.
//  Copyright © 2016年 wyc. All rights reserved.
//

#import "BenjinViewController.h"
#import "SJDataTableView.h"
#import "MortgageCalculationModel.h"

#define kWindowWidth                        ([[UIScreen mainScreen] bounds].size.width)

#define kWindowHeight                       ([[UIScreen mainScreen] bounds].size.height)

#define KCount 300

@interface BenjinViewController ()

@end

@implementation BenjinViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    MortgageCalculationModel * mc = [MortgageCalculationModel new];
    mc.LoanAmount = 300000;
    mc.LoanTerm = 360;
    mc.LoanRatesYers = 0.049;
    [mc PrincipalCalculation];
    int Count = mc.LoanTerm+1;
    NSArray * headerAarray = [[NSArray alloc] initWithObjects:@"期次", @"偿还本息", @"偿还本金", @"支付利息", @"剩余本金", nil];
    NSMutableArray *dataArray = [NSMutableArray new];
    for (int i = 1 ; i< Count; i++) {
        NSMutableDictionary *dataDict = [NSMutableDictionary new];
        [dataDict setObject:[NSString stringWithFormat:@"%.0f",[mc.principalArray[i][0] floatValue]] forKey:[headerAarray objectAtIndex:0]];
        [dataDict setObject:[NSString stringWithFormat:@"%.2f",[mc.principalArray[i][1] floatValue]] forKey:[headerAarray objectAtIndex:1]];
        [dataDict setObject:[NSString stringWithFormat:@"%.2f",[mc.principalArray[i][2] floatValue]] forKey:[headerAarray objectAtIndex:2]];
        [dataDict setObject:[NSString stringWithFormat:@"%.2f",[mc.principalArray[i][3] floatValue]] forKey:[headerAarray objectAtIndex:3]];
        [dataDict setObject:[NSString stringWithFormat:@"%.2f",[mc.principalArray[i][4] floatValue]] forKey:[headerAarray objectAtIndex:4]];
        [dataArray addObject:dataDict];
    }
    
    SJDataTableView * table =[[SJDataTableView alloc] initWithFrame:CGRectMake(0, 186, 375, Count*30+35) headerSize:CGSizeMake(82, 30)];
    [table setHeaderArray:headerAarray dataArray:dataArray];
    
    self.scrollViewTable.contentSize = CGSizeMake(kWindowWidth, Count*30+55+180);//滚动内大小
    self.scrollViewTable.frame = CGRectMake(0, 0, kWindowWidth, kWindowHeight-370);//滚动视图适应
    
    [self.scrollViewTable addSubview:table];
    //[self.view addSubview:table];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
