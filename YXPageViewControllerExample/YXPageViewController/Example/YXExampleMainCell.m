//
//  YXExampleCell.m
//  YXPageViewControllerExample
//
//  Created by yuxiao on 16/8/10.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import "YXExampleMainCell.h"

@interface YXExampleMainCell ()
@property (weak, nonatomic) IBOutlet UILabel *mLabel;

@end

@implementation YXExampleMainCell

- (void)setModel:(id)model{
    
    self.mLabel.text =model;
   
}
@end
