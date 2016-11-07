//
//  MortgageCalculationModel.m
//  FDcalculator
//
//  Created by 杨殿铭 on 2016/10/24.
//  Copyright © 2016年 杨殿铭. All rights reserved.
//

#import "MortgageCalculationModel.h"

@implementation MortgageCalculationModel

//贷款金额LoanAmount;
//年贷款利率LoanRatesYers;
//月贷款利率LoanRatesMonth;
//贷款期限LoanTerm;
//月还款MonthRepayment;
//支付利息总额TotalInterest;
//还款总额TotalRepayment;
//逐月递减MonthlyDecline;

//等额本金数组principalArray ;NSMutableArray[n][期次,偿还本息,偿还本金,支付利息,剩余本金]
//等额本息计算方法
-(void)InterestCalculation
{
    
    //月利率
    _LoanRatesMonth = _LoanRatesYers / 12;
    
    //月供 = [贷款本金×月利率×（1+月利率）^还款月数]÷[（1+月利率）^还款月数－1]
    //_MonthRepayment = _LoanAmount * _LoanRatesMonth * powf((1 + _LoanRatesMonth) , _LoanTerm) / (powf((1 + _LoanRatesMonth) , _LoanTerm) -1);
    NSDecimalNumber *DN1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",1]];
    NSDecimalNumber *DN12 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",12]];
    NSDecimalNumber *DNLoanRatesYers = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",_LoanRatesYers]];
    NSDecimalNumber *DNLoanRatesMonth = [DNLoanRatesYers decimalNumberByDividingBy:DN12];
    NSDecimalNumber *DNLoanAmount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",_LoanAmount]];
    NSDecimalNumber *DNLoanTerm = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",_LoanTerm]];
   
    //月还款
    _MonthRepayment = [[[[DNLoanAmount decimalNumberByMultiplyingBy:DNLoanRatesMonth] decimalNumberByMultiplyingBy:[[DNLoanRatesMonth decimalNumberByAdding:DN1] decimalNumberByRaisingToPower:[DNLoanTerm integerValue]]] decimalNumberByDividingBy:[[[DNLoanRatesMonth decimalNumberByAdding:DN1] decimalNumberByRaisingToPower:[DNLoanTerm integerValue]] decimalNumberBySubtracting:DN1]] floatValue];
    
    /*
    //_LoanAmount * _LoanRatesMonth
    [DNLoanAmount decimalNumberByMultiplyingBy:DNLoanRatesMonth];
    [[DNLoanAmount decimalNumberByMultiplyingBy:DNLoanRatesMonth] decimalNumberByMultiplyingBy:[[DNLoanRatesMonth decimalNumberByAdding:DN1] decimalNumberByRaisingToPower:[DNLoanTerm integerValue]]];
    //powf((1 + _LoanRatesMonth) , _LoanTerm)
    [DNLoanRatesMonth decimalNumberByAdding:DN1];
    [[DNLoanRatesMonth decimalNumberByAdding:DN1] decimalNumberByRaisingToPower:[DNLoanTerm integerValue]];
    [[[DNLoanRatesMonth decimalNumberByAdding:DN1] decimalNumberByRaisingToPower:[DNLoanTerm integerValue]] decimalNumberBySubtracting:DN1];
     
    [[[[DNLoanAmount decimalNumberByMultiplyingBy:DNLoanRatesMonth] decimalNumberByMultiplyingBy:[[DNLoanRatesMonth decimalNumberByAdding:DN1] decimalNumberByRaisingToPower:[DNLoanTerm integerValue]]] decimalNumberByDividingBy:[[[DNLoanRatesMonth decimalNumberByAdding:DN1] decimalNumberByRaisingToPower:[DNLoanTerm integerValue]] decimalNumberBySubtracting:DN1]] floatValue];
    */
    
    //总还款额
    _TotalRepayment = _MonthRepayment * _LoanTerm;
    //总利息
    _TotalInterest = _TotalRepayment - _LoanAmount;
}
//等额本金计算方法
-(void)PrincipalCalculation
{
    //月利率
    _LoanRatesMonth = _LoanRatesYers / 12;
    CGFloat shengbenjin = _LoanAmount;
    _principalArray = [NSMutableArray new];
    [_principalArray addObject:[[NSArray alloc] initWithObjects:@"期次,偿还本息,偿还本金,支付利息,剩余本金",nil]];
    for (int i = 0 ; i<_LoanTerm; i++) {
        NSMutableArray *EachArray = [NSMutableArray new];
        
        //期次
        [EachArray addObject:[NSNumber numberWithFloat:i+1]];
        //偿还本息
        [EachArray addObject:[NSNumber numberWithFloat:shengbenjin * _LoanRatesMonth + _LoanAmount / _LoanTerm]];
        //偿还本金
        [EachArray addObject:[NSNumber numberWithFloat:_LoanAmount / _LoanTerm]];
        //支付利息
        [EachArray addObject:[NSNumber numberWithFloat:shengbenjin * _LoanRatesMonth]];
        //剩余本金
        [EachArray addObject:[NSNumber numberWithFloat:shengbenjin - _LoanAmount / _LoanTerm]];
        
        if (i==0) {
            //月还款
            _MonthRepayment = shengbenjin * _LoanRatesMonth + _LoanAmount / _LoanTerm;
            _MonthlyDecline = shengbenjin * _LoanRatesMonth;
        }else if (i==1){
            //逐月递减
            _MonthlyDecline -= shengbenjin * _LoanRatesMonth;
        }
        
        //总利息
        _TotalInterest += shengbenjin * _LoanRatesMonth;
        //总还款额
        _TotalRepayment += shengbenjin * _LoanRatesMonth + _LoanAmount / _LoanTerm;
        
        /*
        //期次
        [EachArray addObject:[NSString stringWithFormat:@"%d",i+1]];
        //偿还本息
        [EachArray addObject:[NSString stringWithFormat:@"%f",shenbenjin * _LoanRatesMonth + _LoanAmount / _LoanTerm]];
        //偿还本金
        [EachArray addObject:[NSString stringWithFormat:@"%f",_LoanAmount / _LoanTerm]];;
        //支付利息
        [EachArray addObject:[NSString stringWithFormat:@"%f",shenbenjin * _LoanRatesMonth]];
        //剩余本金
        [EachArray addObject:[NSString stringWithFormat:@"%f",shenbenjin - _LoanAmount / _LoanTerm]];
        */
        
        [_principalArray addObject:EachArray];
        shengbenjin = shengbenjin - (_LoanAmount / _LoanTerm);
    }
    //逐月递减
    _MonthlyDecline -= shengbenjin * _LoanRatesMonth;
    //NSLog(@"等额本息数组:%@",_principalArray);
}
//数组转换成 123,456,789.12
-(NSString*)YDMNumberFormatterCurrency:(CGFloat)number{
    NSString * string = [NSString stringWithFormat:@"%.2f",number];
    NSArray *array = [string componentsSeparatedByString:@"."];
    NSMutableString *outString = [[NSMutableString alloc] init];
    NSString *str = array[0];
    NSInteger length = str.length;
    int n = 1;
    while (length>0) {
        NSString *tmpStr = array[0];
        NSRange rang = {length-1, 1};
        NSString *subStr = [tmpStr substringWithRange:rang];
        [outString insertString:subStr atIndex:0];
        if (n%3 == 0 && n != str.length) {
            [outString insertString:@"," atIndex:0];
        }
        n++;
        length--;
    }
    [outString appendString:@"."];
    for (int i = 1; i<array.count; i++) {
        [outString appendString:array[i]];
    }
    return outString;
}
//数组转换成 123,456,789 整数
-(NSString*)YDMNumberFormatterCurrencyInt:(CGFloat)number{
    NSString * string = [NSString stringWithFormat:@"%.f",number];
    NSArray *array = [string componentsSeparatedByString:@"."];
    NSMutableString *outString = [[NSMutableString alloc] init];
    NSString *str = array[0];
    NSInteger length = str.length;
    int n = 1;
    while (length>0) {
        NSString *tmpStr = array[0];
        NSRange rang = {length-1, 1};
        NSString *subStr = [tmpStr substringWithRange:rang];
        [outString insertString:subStr atIndex:0];
        if (n%3 == 0 && n != str.length) {
            [outString insertString:@"," atIndex:0];
        }
        n++;
        length--;
    }
    return outString;
}

@end
