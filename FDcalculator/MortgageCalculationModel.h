//
//  MortgageCalculationModel.h
//  FDcalculator
//
//  Created by 杨殿铭 on 2016/10/24.
//  Copyright © 2016年 杨殿铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MortgageCalculationModel : NSObject

//贷款金额
@property (nonatomic,assign) CGFloat LoanAmount;
//年贷款利率
@property (nonatomic,assign) CGFloat LoanRatesYers;
//月贷款利率
@property (nonatomic,assign) CGFloat LoanRatesMonth;
//贷款期限
@property (nonatomic,assign) CGFloat LoanTerm;
//月还款
@property (nonatomic,assign) CGFloat MonthRepayment;
//支付利息总额
@property (nonatomic,assign) CGFloat TotalInterest;
//还款总额
@property (nonatomic,assign) CGFloat TotalRepayment;
//逐月递减
@property (nonatomic,assign) CGFloat MonthlyDecline;
//等额本金数组[n][期次,偿还本息,偿还本金,支付利息,剩余本金]
@property (nonatomic,strong) NSMutableArray * principalArray ;
//等额本息计算方法
-(void)PrincipalCalculation;
//等额本金计算方法
-(void)InterestCalculation;
@end
