//
//  YXRefresh.h
//  YXPageViewControllerExample
//
//  Created by yuxiao on 16/8/10.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YXRefresh : NSObject
/**
 * 注册一个上拉刷新的回调
 */
+ (void)registeHeaderRefreshCallbackWithTarget:(id)target method:(SEL)method tableView:(UITableView *)tableview;
/**
 * 注册一个下拉刷新的回调
 */
+ (void)registeFooterRefreshCallbackWithTarget:(id)target method:(SEL)method tableView:(UITableView *)tableview;
/**
 * 开启进入动画
 */
+ (void)beginLoadRefresh:(UIView *)view;
/**
 * 关闭进入动画
 */
+ (void)endLoadRefresh;
/**
 * 加载失败时要显示的信息
 */
+ (void)loadError:(NSString *)error;
/**
 * 加载失败时，显示网络错误的信息，其实并没有什么卵用
 */
+ (void)loadNetError;

/**
 * 开启下拉表头动画
 */
+ (void)beginHeaderRefresh:(UITableView *)view;
/**
 * 结束下拉表头动画
 */
+ (void)endHeaderRefresh:(UITableView *)view;
/**
 * 开启上拉表脚动画
 */
+ (void)beginFooterRefresh:(UITableView *)view;
/**
 * 结束上拉表脚动画
 */
+ (void)endFooterRefresh:(UITableView *)view;



+ (void)hideFooter:(UITableView *)view hide:(BOOL)hide;
+(void)hideHeader:(UITableView *)view hide:(BOOL)hide;

+ (BOOL)isHeaderRefreshing:(UITableView *)tableView;
+ (BOOL)isFooterRefreshing:(UITableView *)tableView;
/**
 * 显示错误
 */
+ (void)showError:(NSString *)error;
/**
 * 显示消息
 */
+ (id)showMessage:(NSString *)message toView:(UIView *)view;
/**
 * 隐藏进度条
 */
+ (void)hideProgress:(id)progress;
/**
 * 显示成功的信息
 */
+ (void)showSuccess:(NSString *)string;
+ (id)showMessageWithBackground:(NSString *)message toView:(UIView *)view;
+ (void)showText:(NSString *)text toView:(UIView *)view;
+ (void)showText:(NSString *)text;
@end
