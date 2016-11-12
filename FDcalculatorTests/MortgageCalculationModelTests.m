//
//  MortgageCalculationModelTests.m
//  FDcalculator
//
//  Created by 杨殿铭 on 2016/10/24.
//  Copyright © 2016年 杨殿铭. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MortgageCalculationModel.h"

#define zonge       300000
#define nianlilv    0.049
#define qishu       360

@interface MortgageCalculationModelTests : XCTestCase

@end

@implementation MortgageCalculationModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
/*
 monthBack=original*active*0.01/12*Math.pow((1+parseFloat(active*0.01/12)),parseFloat(timeSpan))/(Math.pow((1+parseFloat(active*0.01/12)),parseFloat(timeSpan))-1);
 var totalBack=monthBack*timeSpan;
 var totalInterest=totalBack-original;
 var monthInterest=totalInterest/timeSpan;
*/
//利息
- (void)testDengeLixi{
    MortgageCalculationModel * mc = [MortgageCalculationModel new];
    mc.LoanAmount = zonge;
    mc.LoanTerm = qishu;
    mc.LoanRatesYers = nianlilv;
    [mc InterestCalculation];
    NSString *str = [NSString stringWithFormat:@"%.2f",mc.TotalInterest];
    XCTAssertEqualObjects(str,@"273184.86",@"总利息-额期望值273184.86，实际值%f",mc.TotalInterest);
}
//总还款
- (void)testDengeZonghuankuan{
    MortgageCalculationModel * mc = [MortgageCalculationModel new];
    mc.LoanAmount = zonge;
    mc.LoanTerm = qishu;
    mc.LoanRatesYers = nianlilv;
    [mc InterestCalculation];
    NSString *str = [NSString stringWithFormat:@"%.2f",mc.TotalRepayment];
    XCTAssertEqualObjects(str,@"573184.86",@"总还款-期望值573184.86，实际值%f",mc.TotalRepayment);
}
//月供
- (void)testDengeYuegong{
    MortgageCalculationModel * mc = [MortgageCalculationModel new];
    mc.LoanAmount = zonge;
    mc.LoanTerm = qishu;
    mc.LoanRatesYers = nianlilv;
    [mc InterestCalculation];
    NSDecimalNumber * a = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",0.049]];
    NSDecimalNumber * b = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",300000]];
    
    NSLog(@"数字输出：%@",[[a decimalNumberByMultiplyingBy:b] stringValue]);
    NSString *str = [NSString stringWithFormat:@"%.2f",mc.MonthRepayment];
    XCTAssertEqualObjects(str,@"1592.18",@"月还款-期望值1592.18，实际值%f",mc.MonthRepayment);
}
//InterestCalculation
//月供
- (void)testDengeBenjin{
    MortgageCalculationModel * mc = [MortgageCalculationModel new];
    mc.LoanAmount = zonge;
    mc.LoanTerm = qishu;
    mc.LoanRatesYers = nianlilv;
    [mc PrincipalCalculation];
    //NSLog(@"本金判断%@",mc.principalArray);
    XCTAssertNotNil(mc.principalArray,@"本金判断%@",mc.principalArray);
}
//月供
- (void)testDengeBenjinYuegong{
    MortgageCalculationModel * mc = [MortgageCalculationModel new];
    mc.LoanAmount = zonge;
    mc.LoanTerm = qishu;
    mc.LoanRatesYers = nianlilv;
    [mc PrincipalCalculation];

    NSString *str = [NSString stringWithFormat:@"%.2f",mc.MonthRepayment];
    XCTAssertEqualObjects(str,@"2058.33",@"月还款-期望值2058.33，实际值%f",mc.MonthRepayment);
    NSString *str2 = [NSString stringWithFormat:@"%.2f",mc.TotalInterest];
    XCTAssertEqualObjects(str2,@"221112.50",@"总利息-期望值221112.51，实际值%f",mc.TotalInterest);
    NSString *str3 = [NSString stringWithFormat:@"%.2f",mc.TotalRepayment];
    XCTAssertEqualObjects(str3,@"521112.50",@"总还款-期望值521112.51，实际值%f",mc.TotalRepayment);
    NSString *str4 = [NSString stringWithFormat:@"%.2f",mc.MonthlyDecline];
    XCTAssertEqualObjects(str4,@"3.40",@"逐月递减-期望值3.40，实际值%f",mc.MonthlyDecline);
}

@end
