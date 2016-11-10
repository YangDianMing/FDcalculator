//
//  YCSlideView.m
//  youzer
//
//  Created by 王禹丞 on 15/12/16.
//  Copyright © 2015年 QXSX. All rights reserved.
//

#import "YCSlideView.h"

#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define kWindowWidth                        ([[UIScreen mainScreen] bounds].size.width)

#define kWindowHeight                       ([[UIScreen mainScreen] bounds].size.height)

#define KTopViewHight 100

@interface YCSlideView()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView * bottomScrollView;

@property (nonatomic,strong) UIView * topView;

@property (nonatomic,strong) UIScrollView * topScrollView;

@property (nonatomic,strong) UIView * slideView;




@end


@implementation YCSlideView


- (instancetype)initWithFrame:(CGRect)frame WithViewControllers:(NSMutableArray *)viewControllers{
  
    if (self = [super initWithFrame:frame]) {
        
        self.vcArray = viewControllers;
        
    }
   
    return self;
}

- (void)setVcArray:(NSMutableArray *)vcArray{

    _vcArray = vcArray;
    
    _btnArray = [NSMutableArray array];
    
    [self confingTopView];
    
    [self configBottomView];
    
    [self tabButton:[[_btnArray objectAtIndex:0] objectAtIndex:0]];

}



- (void)confingTopView{

    // 按钮宽度
    CGFloat buttonWight = kWindowWidth / _vcArray.count;
    // 按钮高度
    CGFloat buttonhight = KTopViewHight - 0;
    CGRect topViewFrame = CGRectMake(0, 0, kWindowWidth, KTopViewHight);
    
    self.topView = [[UIView alloc]initWithFrame:topViewFrame];
    self.topView.backgroundColor = UIColorRGBA(19, 27, 39, 1);//滑动背景颜色

    [self addSubview:self.topView];
    
    self.slideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonWight, KTopViewHight)];
    
    //滑动块颜色
    [_slideView setBackgroundColor:UIColorRGBA(50, 125, 220, 1)];
    //[_slideView setBackgroundColor:UIColorRGBA(37, 129, 233, 1)];
    
    //添加滑动窗口
    [_topView  addSubview:self.slideView];
 
     //添加按钮
    
    for (int i = 0; i < self.vcArray.count ; i ++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * buttonWight, 0, buttonWight, buttonhight)];
        
        UILabel *label_title = [[UILabel alloc] initWithFrame:CGRectMake(kWindowWidth/4-42, 20, 85, 20)];
        label_title.text = self.vcArray[i][0];
        //[label_title setTextColor:UIColorRGBA(184, 233, 134, 1)];//浅绿
        //[label_title setTextColor:UIColorRGBA(0, 136, 204, 1)];//蓝色
        [label_title setTextColor:[UIColor whiteColor]];//白色
        label_title.font = [UIFont systemFontOfSize:20];
        label_title.textAlignment = NSTextAlignmentCenter;
        
        if (i==0) {
            _labelBenxi = [[UILabel alloc] initWithFrame:CGRectMake(10, 51, kWindowWidth/2*0.5-10, 20)];
            _labelBenxi.text =  self.vcArray[i][2];
            //[_label_money setTextColor:UIColorRGBA(184, 233, 134, 1)];//浅绿
            //[_labelBenxi setTextColor:UIColorRGBA(243, 166, 39, 1)];//橙色
            _labelBenxi.font = [UIFont systemFontOfSize:20];
            _labelBenxi.textAlignment = NSTextAlignmentRight;
            [_labelBenxi setAdjustsFontSizeToFitWidth:YES];//自动适应行高
        } else {
            _labelBenjin = [[UILabel alloc] initWithFrame:CGRectMake(10, 51, kWindowWidth/2*0.5-10, 20)];
            _labelBenjin.text =  self.vcArray[i][2];
            //[_labelBenjin setTextColor:UIColorRGBA(184, 233, 134, 1)];//浅绿
            //[_labelBenjin setTextColor:UIColorRGBA(243, 166, 39, 1)];//橙色
            _labelBenjin.font = [UIFont systemFontOfSize:20];
            _labelBenjin.textAlignment = NSTextAlignmentRight;
            [_labelBenjin setAdjustsFontSizeToFitWidth:YES];//自动适应行高
        }
        
        UILabel *label_sign = [[UILabel alloc] initWithFrame:CGRectMake(kWindowWidth/2*0.5, 51, kWindowWidth/2*0.5-10, 20)];
        label_sign.text = @"(元)月供";
        //[label_sign setTextColor:UIColorRGBA(102, 102, 102, 1)];//灰色
        [label_sign setTextColor:[UIColor whiteColor]];//白色
        label_sign.font = [UIFont systemFontOfSize:20];
        label_sign.textAlignment = NSTextAlignmentLeft;
        [label_sign setAdjustsFontSizeToFitWidth:YES];
        
        _tmpButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWight, buttonhight)];
       // UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWight, buttonhight)];
        UIButton *button = _tmpButton;
        
        button.tag = i;
       
        //NSString * buttonTitle =  [self.vcArray[i] allKeys][0];
        
        //设置文字
        //[button setTitle:buttonTitle forState:UIControlStateNormal];
        
        
        //字体大小
        button.titleLabel.font = [UIFont systemFontOfSize:21];
        
        //默认字体颜色
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        if (i == 0) {
            //选中字体颜色
            [button setTitleColor:UIColorRGBA(15, 53, 15, 1) forState:UIControlStateNormal];
        }
        
        [button addTarget:self action:@selector(tabButton:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        if (i==0) {
            [view addSubview:label_title];
            [view addSubview:_labelBenxi];
            [view addSubview:label_sign];
            
            NSMutableArray *btnItemArray = [[NSMutableArray alloc] initWithObjects: button, label_title, _labelBenxi , label_sign ,nil];
            [_btnArray addObject:btnItemArray];
        } else {
            [view addSubview:label_title];
            [view addSubview:_labelBenjin];
            [view addSubview:label_sign];
            
            NSMutableArray *btnItemArray = [[NSMutableArray alloc] initWithObjects: button, label_title, _labelBenjin , label_sign ,nil];
            [_btnArray addObject:btnItemArray];
        }
        
        /*
        [_btnArray addObject:button];
        
        [_btnArray addObject:label_title];
        [_btnArray addObject:_label_money];
        [_btnArray addObject:label_sign];
        */
        [_topView addSubview:view];
        
    
    }
 
        //下划线长宽高
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,KTopViewHight - 1 , kWindowWidth, 1)];
    
        //下划线颜色
        lineView.backgroundColor = UIColorRGBA(242, 242, 242, 1);
    
        [_topView addSubview:lineView];

}

- (void)configBottomView{

    
    CGRect  bottomScrollViewFrame = CGRectMake(0, KTopViewHight, kWindowWidth, kWindowHeight-100  );//- KTopViewHightkWindowHeight-350
    
    self.bottomScrollView = [[UIScrollView alloc]initWithFrame:bottomScrollViewFrame];
    
    [self addSubview:_bottomScrollView];
    
    for (int i = 0; i < self.vcArray.count ; i ++) {
    
     CGRect  VCFrame = CGRectMake(i * kWindowWidth, 0, kWindowWidth, bottomScrollViewFrame.size.height);
    
        //NSString * key = self.vcArray[i][0];
        
        UIViewController * vc = _vcArray[i][1] ;
        
        vc.view.frame = VCFrame;
        
        [self.bottomScrollView addSubview:vc.view];
    }

    
    self.bottomScrollView.contentSize = CGSizeMake(self.vcArray.count * kWindowWidth, 0);


    self.bottomScrollView.pagingEnabled = YES;
    
    self.bottomScrollView.showsHorizontalScrollIndicator = NO;
    
    self.bottomScrollView.showsVerticalScrollIndicator = NO;

    self.bottomScrollView.directionalLockEnabled = YES;
    
    self.bottomScrollView.bounces = NO;

    self.bottomScrollView.delegate =self;

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGRect frame = _slideView.frame;
    
    frame.origin.x = scrollView.contentOffset.x/_vcArray.count;
    
    _slideView.frame = frame;

    double pagegps = scrollView.contentOffset.x / kWindowWidth;
    
    //NSLog(@"页数:%f", pagegps);
    
    for (NSMutableArray * btnItem in _btnArray){
        UIButton *btn = [btnItem objectAtIndex:0];
        if (btn.tag == pagegps ) {
            
            //[btn setTitleColor:UIColorRGBA(15, 153, 15, 1) forState:UIControlStateNormal];
            [btnItem[1] setTextColor:[UIColor whiteColor]];
            [btnItem[2] setTextColor:UIColorRGBA(241, 180, 62, 1)];
            [btnItem[3] setTextColor:[UIColor whiteColor]];
            
        }else{
        
            //[btn setTitleColor:UIColorRGBA(15, 153, 15, 1) forState:UIControlStateNormal];
            [[btnItem objectAtIndex:1] setTextColor:[UIColor grayColor]];
            [[btnItem objectAtIndex:2] setTextColor:[UIColor whiteColor]];
            [[btnItem objectAtIndex:3] setTextColor:[UIColor grayColor]];
        
        }
        
    }
}

-(void) tabButton: (id) sender{
   
    UIButton *button = sender;
    
    for (NSMutableArray * btnItem in _btnArray){
        
        UIButton *btn = [btnItem objectAtIndex:0];

        if ( btn == button ) {
            
            //[btn setTitleColor:UIColorRGBA(239, 93, 58, 1) forState:UIControlStateNormal];
            [[btnItem objectAtIndex:1] setTextColor:[UIColor whiteColor]];
            [[btnItem objectAtIndex:2] setTextColor:UIColorRGBA(241, 180, 62, 1)];
            [[btnItem objectAtIndex:3] setTextColor:[UIColor whiteColor]];
            
        }else{
            
            //[btn setTitleColor:UIColorRGBA(52, 52, 52, 1) forState:UIControlStateNormal];
            [[btnItem objectAtIndex:1] setTextColor:[UIColor grayColor]];
            [[btnItem objectAtIndex:2] setTextColor:[UIColor whiteColor]];
            [[btnItem objectAtIndex:3] setTextColor:[UIColor grayColor]];
            
        }
        
    }
    
    [_bottomScrollView setContentOffset:CGPointMake(button.tag * kWindowWidth, 0) animated:YES];
}

@end
