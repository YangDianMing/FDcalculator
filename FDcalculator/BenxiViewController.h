//
//  BlueViewController.h
//  YCSlideViewDome
//
//  Created by 王禹丞 on 16/1/29.
//  Copyright © 2016年 wyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BenxiViewController : UIViewController

//月还款MonthRepayment;
@property (weak, nonatomic) IBOutlet UILabel *labelMonthRepayment;

//支付利息总额TotalInterest;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalInterest;

//还款总额TotalRepayment;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalRepayment;

@end
