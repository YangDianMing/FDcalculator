//
//  YCSlideView.h
//  youzer
//
//  Created by 王禹丞 on 15/12/16.
//  Copyright © 2015年 QXSX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCSlideView : UIView

@property (nonatomic,strong)NSArray * vcArray;

- (instancetype)initWithFrame:(CGRect)frame WithViewControllers:(NSArray *)viewControllers;

@property (nonatomic,strong)UILabel *labelBenxi;

@property (nonatomic,strong)UILabel *labelBenjin;

@property (nonatomic,strong)UIButton * tmpButton;

@property (nonatomic,strong) NSMutableArray * btnArray;

@end
