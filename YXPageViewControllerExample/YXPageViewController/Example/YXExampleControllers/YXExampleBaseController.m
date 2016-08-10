//
//  YXExampleBaseController.m
//  YXPageViewControllerExample
//
//  Created by yuxiao on 16/8/10.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import "YXExampleBaseController.h"

@interface YXExampleBaseController ()

@end

@implementation YXExampleBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (NSString *)yxpage_registeCellClass{
    return @"YXExampleCell";
}






@end
