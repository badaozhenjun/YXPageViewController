//
//  YXTableCell.h
//  YXPageViewControllerExample
//
//  Created by yuxiao on 16/8/10.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  所有Cell的公共类
 */
@interface YXTableCell : UITableViewCell
+ (void)registerWithTable:(UITableView *)tableView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (NSString *)identify;
+ (UINib *)nib;
- (void)setModel:(id)model;
@property (nonatomic,assign)  NSUInteger row;
@property (nonatomic,assign)  NSUInteger  section;
@property (nonatomic,weak)  UIViewController *controller;
@property (nonatomic,strong)  NSIndexPath *indexPath;
@property (nonatomic,weak) UITableView *tableView;
@end







@interface UIView (YXPageViewController)
@property (nonatomic, assign) CGFloat yxpage_x;
@property (nonatomic, assign) CGFloat yxpage_y;
@property (nonatomic, assign) CGFloat yxpage_centerX;
@property (nonatomic, assign) CGFloat yxpage_centerY;
@property (nonatomic, assign) CGFloat yxpage_width;
@property (nonatomic, assign) CGFloat yxpage_height;
@property (nonatomic, assign) CGSize yxpage_size;

- (void)yxpage_centerYToSuperView;
- (void)yxpage_centerXToSuperView;
- (void)yxpage_centerToSuperView;

@end