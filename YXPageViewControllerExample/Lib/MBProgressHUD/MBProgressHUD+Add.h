//
//  MBProgressHUD+ADD.h
//  yuxiao
//
//  Created by 玉潇 on 16/2/24.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message view:(UIView *)view;
+ (void)showError:(NSString *)error;
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (MBProgressHUD *)showMessageWithBackground:(NSString *)message toView:(UIView *)view;
@end
