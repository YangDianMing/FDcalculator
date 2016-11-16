//
//  MainViewController.m
//  FDcalculator
//
//  Created by 杨殿铭 on 2016/11/10.
//  Copyright © 2016年 杨殿铭. All rights reserved.
//

#import "MainViewController.h"

#define UIColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define kWindowWidth                        ([[UIScreen mainScreen] bounds].size.width)

#define kWindowHeight                       ([[UIScreen mainScreen] bounds].size.height)

@interface MainViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIViewController *SyView;
@property (nonatomic,strong) UIViewController *GjjView;
@property (nonatomic,strong) UIViewController *HhView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMainScrollView:(UIScrollView *)mainScrollView{
    CGFloat windowWidth = kWindowWidth;
    
    CGRect rect = mainScrollView.frame;
    rect.size.width = kWindowWidth;
    mainScrollView.frame = CGRectMake(0, 64, kWindowWidth, kWindowHeight-64);
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    _SyView = [board instantiateViewControllerWithIdentifier:@"SyView"];
    _GjjView = [board instantiateViewControllerWithIdentifier:@"GjjView"];
    _HhView = [board instantiateViewControllerWithIdentifier:@"HhView"];
    NSArray * viewControl = @[@[@"商业",_SyView],@[@"公积金",_GjjView],@[@"混合",_HhView]];
    self.vcArray = viewControl;
    
    mainScrollView.backgroundColor = [UIColor redColor];
    
    for (int i = 0; i < self.vcArray.count ; i ++) {
        
        CGRect  VCFrame = CGRectMake(i * kWindowWidth, 0, kWindowWidth, kWindowHeight-64);
        
        //NSString * key = self.vcArray[i][0];
        
        UIViewController * vc = self.vcArray[i][1] ;
        
        vc.view.frame = VCFrame;
        
        [mainScrollView addSubview:vc.view];
    }
    
    
    
    mainScrollView.contentSize = CGSizeMake(3 * kWindowWidth, 0);
    
    mainScrollView.pagingEnabled = YES;
    
    mainScrollView.showsHorizontalScrollIndicator = NO;
    
    mainScrollView.showsVerticalScrollIndicator = NO;
    
    mainScrollView.directionalLockEnabled = YES;
    
    mainScrollView.bounces = NO;
    
    mainScrollView.delegate =self;
    
    _mainScrollView = mainScrollView;
   
}

//点击切换
- (IBAction)segmentClick:(id)sender {
    UISegmentedControl* control = (UISegmentedControl*)sender;
    switch (control.selectedSegmentIndex) {
        case 0:
            NSLog(@"0");
            //[self.mainScrollView setContentOffset:CGPointMake(0, 0) ];
            [_mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            break;
        case 1:
            NSLog(@"1");
            [_mainScrollView setContentOffset:CGPointMake(kWindowWidth, 0) animated:YES];
            break;
        default:
            NSLog(@"2");
            [_mainScrollView setContentOffset:CGPointMake(kWindowWidth*2, 0) animated:YES];
            break;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double pages = _mainScrollView.contentOffset.x/kWindowWidth+0.5;
    [_mainSegmented setSelectedSegmentIndex:pages];
}

@end
