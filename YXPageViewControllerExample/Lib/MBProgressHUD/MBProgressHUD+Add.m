//
//  MBProgressHUD+ADD.m
//  yuxiao
//
//  Created by 玉潇 on 16/2/24.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import "MBProgressHUD+Add.h"

@implementation MBProgressHUD (Add)


+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the label text.
    hud.label.text = message;
    // You can also adjust other label properties if needed.
    // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
    
    return hud;

}
+ (MBProgressHUD *)showMessageWithBackground:(NSString *)message toView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the label text.
    hud.label.text = message;
    // You can also adjust other label properties if needed.
    // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
    
    return hud;
    
}
+ (MBProgressHUD *)showMessage:(NSString *)message view:(UIView *)view {
    return [self showMessage:message toView:view];
}

+ (void)showError:(NSString *)error {
    [self showError:error toView:[UIApplication sharedApplication].keyWindow];

}
+ (void)showError:(NSString *)error toView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:@"hud_error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = NO;
    // Optional label text.
    hud.label.text = error;
    
    [hud hideAnimated:YES afterDelay:2.f];
    
}
+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success toView:[UIApplication sharedApplication].keyWindow];
    
}
+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:@"hud_success"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    // Looks a bit nicer if we make it square.
    hud.square = NO;
    // Optional label text.
    hud.label.text = success;
    
    [hud hideAnimated:YES afterDelay:2.f];
}
@end
