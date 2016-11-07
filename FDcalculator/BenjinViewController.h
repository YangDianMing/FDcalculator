//
//  RedViewController.h
//  YCSlideViewDome
//
//  Created by 王禹丞 on 16/1/29.
//  Copyright © 2016年 wyc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MortgageCalculationModel.h"

@interface BenjinViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewTable;
@property (weak, nonatomic) IBOutlet UIView *viewTopView;
@property (weak, nonatomic) NSArray * headerAarray;



//月还款MonthRepayment;
@property (weak, nonatomic) IBOutlet UILabel *labelMonthRepayment;

//支付利息总额TotalInterest;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalInterest;

//还款总额TotalRepayment;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalRepayment;

//逐月递减MonthlyDecline
@property (weak, nonatomic) IBOutlet UILabel *labelMonthlyDecline;

//本金列表PrincipalCalculation
@property (strong, nonatomic) NSMutableArray * principalArray;

//计算类
@property (weak, nonatomic) MortgageCalculationModel * mc;

//本金表加载
-(void) benjinload;

@end
