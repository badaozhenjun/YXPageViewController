//
//  YXRefresh.m
//  YXPageViewControllerExample
//
//  Created by yuxiao on 16/8/10.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import "YXRefresh.h"
#import "MJRefresh.h"

#import "MBProgressHUD.h"
#import "MBProgressHUD+Add.h"
@implementation YXRefresh
+ (void)registeHeaderRefreshCallbackWithTarget:(id)target method:(SEL)method tableView:(UITableView *)tableview {
    //    [tableview headerWithRefreshingTarget:target action:method];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:method];
    header.lastUpdatedTimeLabel.hidden=YES;
    header.stateLabel.textColor=[UIColor grayColor];
    header.stateLabel.text=@"正在努力加载...";
    [header setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyleGray)];
    header.arrowView.image=[UIImage imageNamed:@"index_icon_notice"];
    tableview.mj_header=header;
    
}

+ (void)registeFooterRefreshCallbackWithTarget:(id)target method:(SEL)method tableView:(UITableView *)tableview {
    //       [tableview addFooterWithTarget:target action:method];
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:method];
    [footer setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyleGray)];
    footer.stateLabel.textColor=[UIColor grayColor];
        footer.stateLabel.text=@"正在努力加载更多数据...";
    tableview.mj_footer=footer;
}

+ (void)beginLoadRefresh:(UIView *)view {
//    [self showText:@"正在加载" toView:view];
}

+ (void)endLoadRefresh {
//    [YXProgressBar hide];
}

+ (void)loadError:(NSString *)error{
//    [YXProgressBar showError:error];
}
+ (void)loadNetError{
//    [YXProgressBar showNetError];
}

+ (void)beginHeaderRefresh:(UITableView *)view {
    //    [view headerBeginRefreshing];
    [view.mj_header beginRefreshing];
}

+ (void)endHeaderRefresh:(UITableView *)view {
    //    [view headerEndRefreshing];
    [view.mj_header endRefreshing];
}

+ (void)beginFooterRefresh:(UITableView *)view {
    //    [view footerBeginRefreshing];
    [view.mj_footer beginRefreshing];
}

+ (void)endFooterRefresh:(UITableView *)view {
    //    [view footerEndRefreshing];
    [view.mj_footer endRefreshing];
}
+ (void)hideFooter:(UITableView *)view hide:(BOOL)hide{
    view.mj_footer.hidden=hide;
}
+(void)hideHeader:(UITableView *)view hide:(BOOL)hide{
    view.mj_header.hidden=hide;
}
+ (void)showError:(NSString *)error{
    
    [MBProgressHUD showError:error];
}
+ (id)showMessage:(NSString *)message toView:(UIView *)view{
    
    return  [MBProgressHUD showMessage:message toView:view];
}
+ (void)hideProgress:(id)progress{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *progressHUD =progress;
        [progressHUD hideAnimated:YES];
    });
}
+ (void)showText:(NSString *)text toView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:3.f];
}
+ (void)showText:(NSString *)text{
    //      dispatch_async(dispatch_get_main_queue(), ^{
    [self showText:text toView:[UIApplication sharedApplication].keyWindow];
    //      });
}
+ (void)showSuccess:(NSString *)success {
    [MBProgressHUD showSuccess:success];
}
+ (id)showMessageWithBackground:(NSString *)message toView:(UIView *)view{
    
    return  [MBProgressHUD showMessageWithBackground:message toView:view];
}
+ (BOOL)isHeaderRefreshing:(UITableView *)tableView{
    return tableView.mj_header.isRefreshing;
}
+ (BOOL)isFooterRefreshing:(UITableView *)tableView{
    return tableView.mj_footer.isRefreshing;
}

@end
