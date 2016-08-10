//
//  ViewController.m
//  YXPageViewControllerExample
//
//  Created by yuxiao on 16/8/10.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import "YXExampleMainController.h"
#import "YXNormalController.h"
#import "YXFirstProgressController.h"
#import "YXSectionTypeController.h"
#import "YXNoDataController.h"

@interface YXExampleMainController ()

@end

@implementation YXExampleMainController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (NSString *)yxpage_registeCellClass{
    return @"YXExampleMainCell";
}

- (void)yxpage_getModelsWithPage:(NSUInteger)page success:(void (^)(id, NSUInteger))success failure:(void (^)(NSString *))failure{
    success(@[@"普通的分页",@"进度条加载",@"无数据显示",@"SectionType"],1);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *controller;
    switch (indexPath.row) {
        case 0:
            controller = [[YXNormalController alloc] init];
            break;
        case 1:
            controller = [[YXFirstProgressController alloc] init];
            break;
        case 2:
            controller = [[YXNoDataController alloc] init];
            break;
        case 3:
            controller = [[YXSectionTypeController alloc] init];
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}


@end
