//
//  ViewController.m
//  FDcalculator
//
//  Created by 杨殿铭 on 16/10/8.
//  Copyright © 2016年 杨殿铭. All rights reserved.
//

#import "ViewController.h"
#import "YCSlideView.h"

#import "BenxiViewController.h"
#import "BenjinViewController.h"
#import "MortgageCalculationModel.h"
#import "SJDataTableView.h"

#define kWindowWidth                        ([[UIScreen mainScreen] bounds].size.width)

#define kWindowHeight                       ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()

@property (nonatomic,strong) BenxiViewController * VCBenxi;
@property (nonatomic,strong) BenjinViewController * VCBenjin;
@property (nonatomic,strong) YCSlideView * Slideview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.txtJieDaiJinE addTarget:self
                           action:@selector(textFieldDidChange)
                 forControlEvents:UIControlEventEditingDidEnd];//监听调用UIControlEventEditingChanged
    [self.txtDaiKuanQiXian addTarget:self
                           action:@selector(textFieldDidChange)
                 forControlEvents:UIControlEventEditingDidEnd];//监听调用
    [self.txtDaiKuanLiLv addTarget:self
                           action:@selector(textFieldDidChange)
                 forControlEvents:UIControlEventEditingDidEnd];//监听调用
    [self.txtLiLvZheKou addTarget:self
                            action:@selector(textFieldDidChange)
                  forControlEvents:UIControlEventEditingDidEnd];//监听调用
    
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.VCBenxi = [mainStoryboard instantiateViewControllerWithIdentifier:@"SyBenxi"];
    self.VCBenjin = [mainStoryboard instantiateViewControllerWithIdentifier:@"SyBenjin"];
    
    /*
    CGSize tmpSize = CGSizeMake(kWindowWidth, kWindowHeight-375);
    CGRect rect;
    rect.size = tmpSize;
    self.VCBenjin.view.frame = rect;
    */
    NSArray *viewControllers = @[@[@"等额本息",_VCBenxi,@"1305"],@[@"等额本金",_VCBenjin,@"1645"]];
    self.Slideview = [[YCSlideView alloc]initWithFrame:CGRectMake(0, 250, kWindowWidth, kWindowHeight) WithViewControllers:viewControllers];
    
    [self.view addSubview:self.Slideview];
    [self textFieldDidChange];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//编写监听函数
-(void)textFieldDidChange{
    NSString *txtJieDaiJinE = self.txtJieDaiJinE.text;
    NSString *txtDaiKuanLiLv = self.txtDaiKuanLiLv.text;
    NSString *txtDaiKuanQiXian = self.txtDaiKuanQiXian.text;
    NSString *txtLiLvZheKou = self.txtLiLvZheKou.text;

    //空值判断
    if ( txtDaiKuanLiLv == nil || txtDaiKuanLiLv == NULL || [txtDaiKuanLiLv isEqualToString:@""] == YES) {
        self.txtDaiKuanLiLv.text = @"4.9";
        NSLog(@"贷款利率不能为空");
    }
    else if ( txtDaiKuanQiXian == nil || txtDaiKuanQiXian == NULL || [txtDaiKuanQiXian isEqualToString:@""] == YES) {
        self.txtDaiKuanQiXian.text = @"1";
        NSLog(@"贷款期限不能为空");
    }
    else if ( txtLiLvZheKou == nil || txtLiLvZheKou == NULL || [txtLiLvZheKou isEqualToString:@""] == YES) {
        self.txtLiLvZheKou.text = @"1.0";
        NSLog(@"利率倍率不能为空");
    }
    else if ([txtDaiKuanLiLv floatValue] <= 0) {
        self.txtDaiKuanLiLv.text = @"1";
        NSLog(@"贷款利率需要大于0");
    }
    else if ([txtDaiKuanQiXian floatValue] <= 0){
        self.txtDaiKuanQiXian.text = @"1";
        NSLog(@"贷款期限需要大于0");
    }
    else if ([txtLiLvZheKou floatValue] <= 0) {
        self.txtLiLvZheKou.text = @"1";
        NSLog(@"利率倍率需要大于0");
    }
    else if ([txtDaiKuanLiLv floatValue] > 99) {
        self.txtDaiKuanLiLv.text = @"99";
        NSLog(@"贷款利率需要小于99之间");
    }
    else if ([txtDaiKuanQiXian floatValue] > 30 ){
        self.txtDaiKuanQiXian.text = @"30";
        NSLog(@"贷款期限需要小于30之间");
    }
    else if ([txtLiLvZheKou floatValue] > 2) {
        self.txtLiLvZheKou.text = @"2";
        NSLog(@"利率倍率需要在小于2之间");
    }
    
    [self benxifuzhi];
    [self benjinfuzhi];
    
}
//隐藏键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.txtJieDaiJinE resignFirstResponder];
    [self.txtDaiKuanLiLv resignFirstResponder];
    [self.txtDaiKuanQiXian resignFirstResponder];
    [self.txtLiLvZheKou resignFirstResponder];
}

//本息赋值
-(void)benxifuzhi{
    CGFloat txtJieDaiJinE = [self.txtJieDaiJinE.text floatValue];
    CGFloat txtDaiKuanLiLv = [self.txtDaiKuanLiLv.text floatValue];
    CGFloat txtDaiKuanQiXian = [self.txtDaiKuanQiXian.text floatValue];
    CGFloat txtLiLvZheKou = [self.txtLiLvZheKou.text floatValue];
    MortgageCalculationModel * mc = [MortgageCalculationModel new];
    mc.LoanAmount = txtJieDaiJinE * 10000;
    mc.LoanTerm = txtDaiKuanQiXian * 12;
    mc.LoanRatesYers = txtDaiKuanLiLv * 0.01 * txtLiLvZheKou;
    [mc InterestCalculation];
    //label_money
    _Slideview.labelBenxi.text = [NSString stringWithFormat:@"%.2f",mc.MonthRepayment];
    //月还款
    _VCBenxi.labelMonthRepayment.text = [NSString stringWithFormat:@"%.2f",mc.MonthRepayment];
    //总还款
    _VCBenxi.labelTotalRepayment.text = [NSString stringWithFormat:@"%.2f",mc.TotalRepayment];
    //总利息
    _VCBenxi.labelTotalInterest.text = [NSString stringWithFormat:@"%.2f",mc.TotalInterest];

}
//本金赋值
-(void)benjinfuzhi{
    CGFloat txtJieDaiJinE = [self.txtJieDaiJinE.text floatValue];
    CGFloat txtDaiKuanLiLv = [self.txtDaiKuanLiLv.text floatValue];
    CGFloat txtDaiKuanQiXian = [self.txtDaiKuanQiXian.text floatValue];
    CGFloat txtLiLvZheKou = [self.txtLiLvZheKou.text floatValue];
    MortgageCalculationModel * mc = [MortgageCalculationModel new];
    mc.LoanAmount = txtJieDaiJinE * 10000;
    mc.LoanTerm = txtDaiKuanQiXian * 12;
    mc.LoanRatesYers = txtDaiKuanLiLv * 0.01 * txtLiLvZheKou;
    [mc PrincipalCalculation];

    //label_money
    _Slideview.labelBenjin.text = [NSString stringWithFormat:@"%.2f",mc.MonthRepayment];
    //月还款
    _VCBenjin.labelMonthRepayment.text = [NSString stringWithFormat:@"%.2f",mc.MonthRepayment];
    //总还款
    _VCBenjin.labelTotalRepayment.text = [NSString stringWithFormat:@"%.2f",mc.TotalRepayment];
    //总利息
    _VCBenjin.labelTotalInterest.text = [NSString stringWithFormat:@"%.2f",mc.TotalInterest];
    //逐月递减
    _VCBenjin.labelMonthlyDecline.text = [NSString stringWithFormat:@"%.2f",mc.MonthlyDecline];    
    
    _VCBenjin.mc = mc;
    [_VCBenjin benjinload];

}
@end
