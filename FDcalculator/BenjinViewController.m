//
//  ViewController.m
//  YCSlideViewDome
//
//  Created by 王禹丞 on 16/1/29.
//  Copyright © 2016年 wyc. All rights reserved.
//

#import "BenjinViewController.h"
#import "SJDataTableView.h"

#define kWindowWidth                        ([[UIScreen mainScreen] bounds].size.width)

#define kWindowHeight                       ([[UIScreen mainScreen] bounds].size.height)

#define KCount 300

@interface BenjinViewController ()

@end

@implementation BenjinViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSArray * headerAarray = [[NSArray alloc] initWithObjects:@"期次", @"偿还本息", @"偿还本金", @"支付利息", @"剩余本金", nil];
    NSMutableArray *dataArray = [NSMutableArray new];
    for (int i = 0 ; i< KCount; i++) {
        NSMutableDictionary *dataDict = [NSMutableDictionary new];
        [dataDict setObject:[NSString stringWithFormat:@"%d",i] forKey:[headerAarray objectAtIndex:0]];
        [dataDict setObject:[NSString stringWithFormat:@"value1_%d",i] forKey:[headerAarray objectAtIndex:1]];
        [dataDict setObject:[NSString stringWithFormat:@"value2_%d",i] forKey:[headerAarray objectAtIndex:2]];
        [dataDict setObject:[NSString stringWithFormat:@"value3_%d",i] forKey:[headerAarray objectAtIndex:3]];
        [dataDict setObject:[NSString stringWithFormat:@"1234567890_%d",i] forKey:[headerAarray objectAtIndex:4]];
        [dataArray addObject:dataDict];
    }
    
    SJDataTableView * table =[[SJDataTableView alloc] initWithFrame:CGRectMake(0, 186, 375, KCount*30+35) headerSize:CGSizeMake(82, 30)];
    [table setHeaderArray:headerAarray dataArray:dataArray];
    
    self.scrollViewTable.contentSize = CGSizeMake(kWindowWidth, KCount*30+55+180);//滚动内大小
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
