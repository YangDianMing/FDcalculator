//
//  YDMDataTableViewCell.h
//  YDMDataTableView
//
//  Created by 杨殿铭 on 2016/10/31.
//  Copyright © 2016年 杨殿铭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDMDataTableViewCell : UITableViewCell
@property (nonatomic,strong) NSDictionary * dataDict;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemSize:(CGSize)size headerArray:(NSArray*)headerArray;

@end
