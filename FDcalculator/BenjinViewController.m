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

#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define KCount 300

@interface BenjinViewController ()<UIScrollViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIView * tbHead;

@end

@implementation BenjinViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //self.headerAarray = array;
    /*
    self.mc = [MortgageCalculationModel new];
    self.mc.LoanAmount = 300000;
    self.mc.LoanTerm = 360;
    self.mc.LoanRatesYers = 0.049;
    [self.mc PrincipalCalculation];
     */
    
    [self setupView];
}

//视图初始化
-(void)setupView{
    
    //初始化视图位置
    [self setLableRectFram:_labelMonthRepayment];
    [self setLableRectFram:_labelTotalInterest];
    [self setLableRectFram:_labelTotalRepayment];
    [self setLableRectFram:_labelMonthlyDecline];
    self.scrollViewTable.delegate = self;
    
    //UI生成headerAarray浮动表头
    NSArray * headerAarray = @[@"期次", @"偿还本息", @"偿还本金", @"支付利息", @"剩余本金"];
    self.tbHead =[[UIView alloc]initWithFrame:CGRectMake(0, 160, kWindowWidth, 30)];
    [self.tbHead setBackgroundColor:UIColorRGBA(25, 37, 51, 1)];//[UIColor whiteColor]
    for(int i = 0 ; i < [headerAarray count] ; i++){
        UILabel *headLabel=[[UILabel alloc]initWithFrame:CGRectMake(i*kWindowWidth*0.2f, 0, kWindowWidth*0.2f, 30)];
        [headLabel setText:[headerAarray objectAtIndex:i]];
        [headLabel setTextAlignment:NSTextAlignmentCenter];
        [headLabel setAdjustsFontSizeToFitWidth:YES];//自动适应行高
        headLabel.font = [UIFont systemFontOfSize:14];//头行字体
        headLabel.textColor = [UIColor whiteColor];
        [self.tbHead addSubview:headLabel];
    }
    [self.scrollViewTable addSubview:self.tbHead];
}

-(void)setLableRectFram:(UILabel*)label{
    CGRect labelRect = label.frame;
    labelRect.size.width = kWindowWidth/2-20;
    labelRect.origin.x = kWindowWidth/2;
    label.frame = labelRect;
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
    MortgageCalculationModel * mc = [MortgageCalculationModel new];
    for (int i = 1 ; i< Count; i++) {
        NSMutableDictionary *dataDict = [NSMutableDictionary new];
        [dataDict setObject:[NSString stringWithFormat:@"%.0f",[self.mc.principalArray[i][0] floatValue]] forKey:[headerAarray objectAtIndex:0]];
        [dataDict setObject:[mc YDMNumberFormatterCurrency:[self.mc.principalArray[i][1] floatValue]] forKey:[headerAarray objectAtIndex:1]];
        [dataDict setObject:[mc YDMNumberFormatterCurrency:[self.mc.principalArray[i][2] floatValue]] forKey:[headerAarray objectAtIndex:2]];
        [dataDict setObject:[mc YDMNumberFormatterCurrency:[self.mc.principalArray[i][3] floatValue]] forKey:[headerAarray objectAtIndex:3]];
        [dataDict setObject:[mc YDMNumberFormatterCurrency:[self.mc.principalArray[i][4] floatValue]] forKey:[headerAarray objectAtIndex:4]];
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
    
    [self.scrollViewTable addSubview:table];

}

//滚动跟踪
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if (y > 160) {
        CGRect rect = self.tbHead.frame;
        rect.origin.y = y;
        self.tbHead.frame = rect;
        [self.scrollViewTable bringSubviewToFront:self.tbHead];//置顶
    }else{
        CGRect rect = self.tbHead.frame;
        rect.origin.y = 160;
        self.tbHead.frame = rect;
    }
    NSLog(@"滚动条位置%f",y);
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
