//
//  ViewController.h
//  FDcalculator
//
//  Created by 杨殿铭 on 16/10/8.
//  Copyright © 2016年 杨殿铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtJieDaiJinE;
@property (weak, nonatomic) IBOutlet UITextField *txtDaiKuanLiLv;
@property (weak, nonatomic) IBOutlet UITextField *txtDaiKuanQiXian;
@property (weak, nonatomic) IBOutlet UITextField *txtLiLvZheKou;

@end

