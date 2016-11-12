//
//  HunheViewController.h
//  FDcalculator
//
//  Created by 杨殿铭 on 2016/11/11.
//  Copyright © 2016年 杨殿铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HunheViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtSyJieDaiJinE;
@property (weak, nonatomic) IBOutlet UITextField *txtSyDaiKuanLiLv;
@property (weak, nonatomic) IBOutlet UITextField *txtSyLiLvZheKou;
@property (weak, nonatomic) IBOutlet UITextField *txtGjjJieDaiJinE;
@property (weak, nonatomic) IBOutlet UITextField *txtGjjDaiKuanLiLv;
@property (weak, nonatomic) IBOutlet UITextField *txtDaiKuanQiXian;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@end
