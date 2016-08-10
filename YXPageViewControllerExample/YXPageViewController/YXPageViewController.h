//
//  YXPageViewController.h
//  YXPageViewControllerExample
//
//  Created by yuxiao on 16/8/10.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, YXPageViewControllerType) {
    YXPageViewControllerTypeSection,
    YXPageViewControllerTypeRow,
    
};
typedef NS_ENUM(NSUInteger, YXPageViewControllerHeaderRefreshType) {
    YXPageViewControllerHeaderRefreshTypePull,
    YXPageViewControllerHeaderRefreshTypeProgress
};
typedef NS_ENUM(NSUInteger,  YXPageViewControllerRefreshType) {
    YXPageViewControllerRefreshTypeHeader,
    YXPageViewControllerRefreshTypeFooter
};
@interface YXPageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *models;
@property (nonatomic,weak)  UIViewController *parentController;
/**
 *  - 1: 返回值不为0   section作为row值
 *  - 2: 返回值为0     row作为row值
 *  如果其他复杂的情况，请重写tableview的两个代理方法
 *  @return
 */
- (YXPageViewControllerType)yxpage_type;

/**
 *  返回表格控件的类型
 *
 */
- (UITableViewStyle)yxpage_style;



/**
 *
 *
 *  @return 本类对应的cell的类型名称
 */
- (NSString *)yxpage_cellClassForIndexPath:(NSIndexPath*)indexPath;
/**
 *  为cell设置model，有一个默认的实现
 *
 *  @param model
 *  @param cell
 *  @param indexPath
 */
- (void)yxpage_setCell:(id)cell indexPath:(NSIndexPath*)indexPath;

/**
 *  返回要注册的单个的class对象，如果只有一种cell，只需要再实现yxpage_getModelsWithPage,获取数据即可
 *
 *  @return <#return value description#>
 */
- (NSString *)yxpage_registeCellClass;
/**
 *  返回要注册的class的数组
 *
 *  @return
 */
- (NSArray *)yxpage_registeCellClasses;

/**
 *
 *
 *  @return 是否可分页
 */
- (BOOL)yxpage_pageable;

/**
 * 是否有section
 */
- (BOOL)yxpage_sectionable;
/**是否有上拉刷新*/
- (BOOL)yxpage_refreshenable;

- (UITableView *)yxpage_tableView;



@property (nonatomic,assign)  NSUInteger yxpage_pageNum;

/**
 *  获取数据
 *
 *  @param page    页码
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)yxpage_getModelsWithPage:(NSUInteger)page success:(void (^)(id models,NSUInteger totalPage))success failure:(void (^)(NSString *error))failure;
/**
 *  @return 是否可以分页
 */
- (BOOL)yxpage_pageable;
/**当没有数据是显示什么内容*/
- (NSString *)yxpage_noDataText;
/** noDataText显示控件与上端的距离 */
- (float)yxpage_noDataTextPadding;
/** 上拉刷新调用的函数 */
- (void)onHeaderRefresh;
/** 第一页的刷新方式 默认为下拉刷新*/
- (YXPageViewControllerHeaderRefreshType)yxpage_headerRefreshType;
/** 是否自动刷新第一页 ，默认为YES 刷新*/
- (BOOL)yxpage_autoRefreshFirst;
/** 是否在没有刷新第一页的时候就实现noDataText ,默认为NO 不显示*/
- (BOOL) yxpage_showNoDataTextFirst;
- (void)yxpage_hideText;
- (void)yxpage_showText:(NSString *)text;

/** 实现了这个方法，会自动加上缓存第一页的功能 */
- (NSString *)yxpage_cacheType;
- (UIImageView *)yxpage_noDataImageView;

@end
