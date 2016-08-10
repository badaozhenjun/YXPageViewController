//
//  YXNormalController.m
//  YXPageViewControllerExample
//
//  Created by yuxiao on 16/8/10.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import "YXNormalController.h"
#import "YXExampleModel.h"

@interface YXNormalController ()

@end

@implementation YXNormalController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)yxpage_getModelsWithPage:(NSUInteger)page success:(void (^)(id, NSUInteger))success failure:(void (^)(NSString *))failure{
    
    
    NSMutableArray *models = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++) {
        YXExampleModel * model = [[YXExampleModel alloc] init];
        model.text = @"邓薇打破世界纪录 中国女举夺得里约奥运会首金";
        model.imageUrl = @"https://ss2.baidu.com/6ONYsjip0QIZ8tyhnq/it/u=2271128873,1805523585&fm=80";
        [models addObject:model];
    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
              success(models,1);
        });
    });
    
    
    
    
    
    
    
}


@end
