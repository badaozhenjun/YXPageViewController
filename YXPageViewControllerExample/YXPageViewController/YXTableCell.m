//
//  YXTableCell.m
//  YXPageViewControllerExample
//
//  Created by yuxiao on 16/8/10.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import "YXTableCell.h"

@implementation YXTableCell
-(void)awakeFromNib{
    [super awakeFromNib];
}

/**
 *  创建cell的实例方法的实现
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identify=[self identify];
    YXTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[[NSBundle mainBundle] loadNibNamed:identify owner:self options:nil] lastObject];
        ;
    }
    cell.yxpage_width=tableView.yxpage_width;
    return cell;
}
/**
 *  以类名称作为标识
 */
+ (NSString *)identify{
    return NSStringFromClass([self class]);
}

+ (UINib *)nib{
    return [UINib nibWithNibName:[self identify] bundle:[NSBundle mainBundle]];
}
+ (void)registerWithTable:(UITableView *)tableView{
    [tableView registerNib:[self nib] forCellReuseIdentifier:[self identify]];
}
- (void)setModel:(id)model{
    
}
@end

@implementation UIView (YXPageViewController)

- (void)setYxpage_x:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)yxpage_x
{
    return self.frame.origin.x;
}

- (void)setYxpage_y:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)yxpage_y
{
    return self.frame.origin.y;
}

- (void)setYxpage_centerX:(CGFloat)yxpage_centerX
{
    CGPoint center = self.center;
    center.x = yxpage_centerX;
    self.center = center;
}

- (CGFloat)yxpage_centerX
{
    return self.center.x;
}

- (void)setYxpage_centerY:(CGFloat)yxpage_centerY
{
    CGPoint center = self.center;
    center.y = yxpage_centerY;
    self.center = center;
}

- (CGFloat)yxpage_centerY
{
    return self.center.y;
}

- (void)setYxpage_width:(CGFloat)yxpage_width
{
    CGRect frame = self.frame;
    frame.size.width = yxpage_width;
    self.frame = frame;
}

- (CGFloat)yxpage_width
{
    return self.frame.size.width;
}

- (void)setYxpage_height:(CGFloat)yxpage_height
{
    CGRect frame = self.frame;
    frame.size.height = yxpage_height;
    self.frame = frame;
}

- (CGFloat)yxpage_height
{
    return self.frame.size.height;
}

- (void)setYxpage_size:(CGSize)yxpage_size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = yxpage_size;
    self.frame = frame;
}

- (CGSize)yxpage_size
{
    return self.frame.size;
}
- (void)yxpage_centerYToSuperView{
    UIView *superView = self.superview;
    self.yxpage_y=(superView.yxpage_height-self.yxpage_height)*0.5f;
}

- (void)yxpage_centerXToSuperView{
    UIView *superView = self.superview;
    self.yxpage_x=(superView.yxpage_width-self.yxpage_width)*0.5f;
}

- (void)yxpage_centerToSuperView{
    [self yxpage_centerXToSuperView];
    [self yxpage_centerYToSuperView];
    
    
}

@end