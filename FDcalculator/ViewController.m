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
#import "myScrollView.h"

#define kWindowWidth                        ([[UIScreen mainScreen] bounds].size.width)

#define kWindowHeight                       ([[UIScreen mainScreen] bounds].size.height)

#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface ViewController ()

@property (nonatomic,strong) BenxiViewController * VCBenxi;
@property (nonatomic,strong) BenjinViewController * VCBenjin;
@property (nonatomic,strong) YCSlideView * Slideview;
@property (nonatomic,strong) UIButton * buttonFanhuidingbu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //监听事件
    [self UIControlEvent];
    
    UIStoryboard * mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.VCBenxi = [mainStoryboard instantiateViewControllerWithIdentifier:@"SyBenxi"];
    self.VCBenjin = [mainStoryboard instantiateViewControllerWithIdentifier:@"SyBenjin"];
    
    NSArray *viewControllers = @[@[@"等额本息",_VCBenxi,@"0"],@[@"等额本金",_VCBenjin,@"0"]];
    self.Slideview = [[YCSlideView alloc]initWithFrame:CGRectMake(0, 186, kWindowWidth, kWindowHeight) WithViewControllers:viewControllers];
    
    //滑块点击事件
    for (NSMutableArray * btnItem  in self.Slideview.btnArray) {
        UIButton * btn = [btnItem objectAtIndex:0];
        [btn addTarget:self
                action:@selector(HidenKeyBoard)
      forControlEvents:UIControlEventTouchDown];
    }
    
    self.VCBenjin.scrollViewTable.delegate = self;
    self.mainScrollView.delegate = self;
    self.mainScrollView.showsVerticalScrollIndicator = NO;//屏蔽纵向滚动条
    self.mainScrollView.bounces = NO;//反弹
    self.mainScrollView.alwaysBounceVertical = NO;//总是反弹垂直
    self.mainScrollView.pagingEnabled = YES;
    [self.mainScrollView addSubview:self.Slideview];
    self.mainScrollView.frame = CGRectMake(0, 64, kWindowWidth, kWindowHeight-64);
    
    NSLog(@"frame视图--高度:%f--宽度:%f",self.mainScrollView.frame.size.height,self.mainScrollView.frame.size.width);
    self.mainScrollView.contentSize = CGSizeMake(kWindowWidth, kWindowHeight+186-64);
    NSLog(@"2内滚动视图--高度:%f--宽度:%f",self.mainScrollView.contentSize.height,self.mainScrollView.contentSize.width);
    NSLog(@"3内滚动视图--高度:%f--宽度:%f",self.mainScrollView.frame.size.height,self.mainScrollView.frame.size.width);
    //[self.mainScrollView setContentSize:CGPointMake(0, 186)];
    //[self jisuan];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//监听事件
-(void)UIControlEvent{
    //输入改变时验证
    [self.txtJieDaiJinE addTarget:self
                           action:@selector(textFieldChanged)
                 forControlEvents:UIControlEventEditingChanged];//监听调用UIControlEventEditingChanged
    [self.txtDaiKuanQiXian addTarget:self
                              action:@selector(textFieldChanged)
                    forControlEvents:UIControlEventEditingChanged];//监听调用UIControlEventEditingDidEnd
    [self.txtDaiKuanLiLv addTarget:self
                            action:@selector(textFieldChanged)
                  forControlEvents:UIControlEventEditingChanged];//监听调用
    [self.txtLiLvZheKou addTarget:self
                           action:@selector(textFieldChanged)
                 forControlEvents:UIControlEventEditingChanged];//监听调用
    
    [self.txtJieDaiJinE addTarget:self
                           action:@selector(textFieldDidEnd)
                 forControlEvents:UIControlEventEditingDidEnd];//监听调用UIControlEventEditingChanged
    [self.txtDaiKuanQiXian addTarget:self
                              action:@selector(textFieldDidEnd)
                    forControlEvents:UIControlEventEditingDidEnd];//监听调用UIControlEventEditingDidEnd
    [self.txtDaiKuanLiLv addTarget:self
                            action:@selector(textFieldDidEnd)
                  forControlEvents:UIControlEventEditingDidEnd];//监听调用
    [self.txtLiLvZheKou addTarget:self
                           action:@selector(textFieldDidEnd)
                 forControlEvents:UIControlEventEditingDidEnd];//监听调用
    
    //返回顶部按钮
    self.buttonFanhuidingbu = [[UIButton alloc] initWithFrame:CGRectMake(kWindowWidth - 50,kWindowHeight - 114, 40, 40)];
    [self.buttonFanhuidingbu setImage:[UIImage imageNamed:@"fanhuidingbu"] forState:UIControlStateNormal];
    [self.view addSubview:self.buttonFanhuidingbu];
    [self.buttonFanhuidingbu addTarget:self action:@selector(Fanhuidingbu) forControlEvents:UIControlEventTouchDown];
    self.buttonFanhuidingbu.hidden = YES;
    
    
    //设置键盘右上角计算按钮
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, kWindowWidth,44)];
    UIButton *buttonJisuan = [[UIButton alloc] initWithFrame:CGRectMake(kWindowWidth - 140,7,60, 30)];
    UIButton *buttonWancheng = [[UIButton alloc] initWithFrame:CGRectMake(kWindowWidth - 70,7,60, 30)];
    [buttonJisuan addTarget:self action:@selector(jisuan) forControlEvents:UIControlEventTouchDown];
    [buttonWancheng addTarget:self action:@selector(HidenKeyBoard) forControlEvents:UIControlEventTouchDown];
    [buttonJisuan setTitle:@"计算" forState:UIControlStateNormal];
    [buttonWancheng setTitle:@"完成" forState:UIControlStateNormal];

    [buttonJisuan setTitleColor: UIColorRGBA(0, 136, 204, 1) forState:UIControlStateNormal];
    [buttonWancheng setTitleColor: UIColorRGBA(0, 136, 204, 1) forState:UIControlStateNormal];
    buttonJisuan.layer.borderWidth = 1;
    //buttonJisuan.backgroundColor = [UIColor whiteColor];
    buttonJisuan.layer.borderColor = UIColorRGBA(0, 136, 204, 1).CGColor;
    buttonJisuan.layer.cornerRadius = 5;
    [bar addSubview:buttonJisuan];
    [bar addSubview:buttonWancheng];
    self.txtJieDaiJinE.inputAccessoryView = bar;
    self.txtDaiKuanLiLv.inputAccessoryView = bar;
    self.txtDaiKuanQiXian.inputAccessoryView = bar;
    self.txtLiLvZheKou.inputAccessoryView = bar;
}

//滚动事件
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //[self HidenKeyBoard];
    //CGFloat y = scrollView.contentOffset.y;
    //CGFloat mainScrollView_y = self.mainScrollView.contentOffset.y;
    CGFloat vcBenjin_y = self.VCBenjin.scrollViewTable.contentOffset.y;
    CGFloat active_y = vcBenjin_y - 160;
    CGPoint point = self.mainScrollView.contentOffset;
    
    if (vcBenjin_y > 160) {
        
        if (active_y < 185) {
            point.y = active_y;
            self.mainScrollView.contentOffset = point;
        }else{
            point.y = 185;
            self.mainScrollView.contentOffset = point;
        }
        
        //头部标题跟随
        CGRect rect = self.VCBenjin.tbHead.frame;
        rect.origin.y = vcBenjin_y;
        self.VCBenjin.tbHead.frame = rect;
        [self.VCBenjin.scrollViewTable bringSubviewToFront:self.VCBenjin.tbHead];//置顶
        
        //返回顶部
        self.buttonFanhuidingbu.hidden = NO;
        
    }else{
        //CGPoint point = self.mainScrollView.contentOffset;
        point.y = 0;
        self.mainScrollView.contentOffset = point;
        
        //头部标题复位
        CGRect rect = self.VCBenjin.tbHead.frame;
        rect.origin.y = 160;
        self.VCBenjin.tbHead.frame = rect;
        
        //返回顶部
        self.buttonFanhuidingbu.hidden = YES;
        
    }
   
    NSLog(@"滚动条位置%f",vcBenjin_y);
}

//编写监听函数
-(void)textFieldChanged{
    NSString *txtJieDaiJinE = self.txtJieDaiJinE.text;
    NSString *txtDaiKuanLiLv = self.txtDaiKuanLiLv.text;
    NSString *txtDaiKuanQiXian = self.txtDaiKuanQiXian.text;
    NSString *txtLiLvZheKou = self.txtLiLvZheKou.text;
    
    if ([txtJieDaiJinE floatValue] > 9999) {
        self.txtJieDaiJinE.text = @"9999";
        NSLog(@"贷款金额小于9999万");
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
    else if ([txtJieDaiJinE length] > 4) {
        NSString * string = self.txtJieDaiJinE.text;
        self.txtJieDaiJinE.text = [string substringToIndex:4];
    }
    else if ([txtDaiKuanLiLv length] > 7) {
        NSString * string = self.txtDaiKuanLiLv.text;
        self.txtDaiKuanLiLv.text = [string substringToIndex:7];
    }
    else if ([txtDaiKuanQiXian length] > 2) {
        NSString * string = self.txtDaiKuanQiXian.text;
        self.txtDaiKuanQiXian.text = [string substringToIndex:2];
    }
    else if ([txtLiLvZheKou length] > 7) {
        NSString * string = self.txtLiLvZheKou.text;
        self.txtLiLvZheKou.text = [string substringToIndex:7];
    }
}

//编写监听函数
-(void)textFieldDidEnd{
    //NSString *txtJieDaiJinE = self.txtJieDaiJinE.text;
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
    
}
//计算
-(void)jisuan{
    [self HidenKeyBoard];
    [self benxifuzhi];
    [self benjinfuzhi];
}
//滑块隐藏键盘
-(void)HidenKeyBoard{
    [self.txtJieDaiJinE resignFirstResponder];
    [self.txtDaiKuanLiLv resignFirstResponder];
    [self.txtDaiKuanQiXian resignFirstResponder];
    [self.txtLiLvZheKou resignFirstResponder];
}
//返回顶部
-(void)Fanhuidingbu{
    [self.VCBenjin.scrollViewTable setContentOffset:CGPointMake(0, 0) animated:YES];
}
//滚动隐藏
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self HidenKeyBoard];
}

//隐藏键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self HidenKeyBoard];
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
    
    //格式化输出数字
    /*
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    _Slideview.labelBenxi.text = [formatter stringFromNumber:[NSNumber numberWithInt:mc.MonthRepayment]];
    _VCBenxi.labelMonthRepayment.text = [formatter stringFromNumber:[NSNumber numberWithInt:mc.MonthRepayment]];
    _VCBenxi.labelTotalRepayment.text = [formatter stringFromNumber:[NSNumber numberWithInt:mc.TotalRepayment]];
    _VCBenxi.labelTotalInterest.text = [formatter stringFromNumber:[NSNumber numberWithInt:mc.TotalInterest]];
    */
    //滑动块
    _Slideview.labelBenxi.text = [mc YDMNumberFormatterCurrencyInt:mc.MonthRepayment];
    //月还款
    _VCBenxi.labelMonthRepayment.text = [mc YDMNumberFormatterCurrency:mc.MonthRepayment];
    //总还款
    _VCBenxi.labelTotalRepayment.text = [mc YDMNumberFormatterCurrency:mc.TotalRepayment];
    //总利息
    _VCBenxi.labelTotalInterest.text = [mc YDMNumberFormatterCurrency:mc.TotalInterest];
    
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
    _Slideview.labelBenjin.text = [mc YDMNumberFormatterCurrencyInt:mc.MonthRepayment];
    //月还款
    _VCBenjin.labelMonthRepayment.text = [mc YDMNumberFormatterCurrency:mc.MonthRepayment];
    //总还款
    _VCBenjin.labelTotalRepayment.text = [mc YDMNumberFormatterCurrency:mc.TotalRepayment];
    //总利息
    _VCBenjin.labelTotalInterest.text = [mc YDMNumberFormatterCurrency:mc.TotalInterest];
    //逐月递减
    _VCBenjin.labelMonthlyDecline.text = [mc YDMNumberFormatterCurrency:mc.MonthlyDecline];
    
    _VCBenjin.mc = mc;
    [_VCBenjin benjinload];
    
    


}
@end
