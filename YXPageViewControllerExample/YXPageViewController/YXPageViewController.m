//
//  YXPageViewController.m
//  YXPageViewControllerExample
//
//  Created by yuxiao on 16/8/10.
//  Copyright © 2016年 yuxiao. All rights reserved.
//

#import "UITableView+FDTemplateLayoutCell.h"
#import "YXPageViewController.h"
#import "YXRefresh.h"
#import "YXTableCell.h"

#define yx_dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}
@interface YXPageViewController ()

@property (nonatomic,weak) UILabel *label;
@property (nonatomic,weak) UIImageView *nodataImageView;
@property (nonatomic,assign)  BOOL hasNext;
@end

@implementation YXPageViewController
#pragma mark- 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    if([self respondsToSelector:@selector(yxpage_registeCellClass)]){
        NSString *cellClass= [self yxpage_registeCellClass];
        [self.tableView registerNib:[UINib nibWithNibName:cellClass bundle:[NSBundle mainBundle]]forCellReuseIdentifier:cellClass];
    }else{
        NSArray *cellClasses = [self yxpage_registeCellClasses];
        //注册cellClass
        for(NSString *cellClass in cellClasses){
            [self.tableView registerNib:[UINib nibWithNibName:cellClass bundle:[NSBundle mainBundle]]forCellReuseIdentifier:cellClass];
        }
    }
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
    
    if([self yxpage_pageable]){
        if([self yxpage_refreshenable])
            if([self page_headerRefreshType]==YXPageViewControllerHeaderRefreshTypePull){
                [YXRefresh registeHeaderRefreshCallbackWithTarget:self method:@selector(onHeaderRefresh) tableView:self.tableView];
            }
        
        [YXRefresh registeFooterRefreshCallbackWithTarget:self method:@selector(onFooterRefresh) tableView:self.tableView];
        
        if([self yxpage_autoRefreshFirst]){
            //第一次刷新
            [YXRefresh beginHeaderRefresh:self.tableView];
        }
        [YXRefresh hideFooter:self.tableView hide:YES];
    }
    //    dispatch_async(dispatch_get_main_queue(), ^{
    [self yxpage_showFirstPageCache];
    if([self yxpage_showNoDataTextFirst]&&!self.models.count)
        [self showText:[self yxpage_noDataText]];
    //    });
    

    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSIndexPath*    selection = [self.tableView indexPathForSelectedRow];
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}

#pragma mark -tableview的代理和源

/* 每个section中row的数量 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    if([self yxpage_type]==YXPageViewControllerTypeRow){
        
        if(self.models.count>0&&[self.models[section] isKindOfClass:[NSArray class]])
        {
            return ((NSArray *)self.models[section]).count;
        }
        return self.models.count;
    }
    return 1;
    
}

/* section的数量*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  
    if([self yxpage_type]==YXPageViewControllerTypeSection){
        return self.models.count;
    }
    
    return 1;
}

/* cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id cell = [self.tableView dequeueReusableCellWithIdentifier:[self yxpage_cellClassForIndexPath:indexPath]];
    [self yxpage_setCell:cell indexPath:indexPath];
    //cell的创建
    return cell;
}

/* 行高 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *classStr = [self yxpage_cellClassForIndexPath:indexPath];
    return  [self.tableView fd_heightForCellWithIdentifier:classStr cacheByIndexPath:indexPath configuration:^(id cell) {
        [self yxpage_setCell:cell indexPath:indexPath];
    }];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor=[UIColor clearColor];
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor=[UIColor clearColor];
    return view;
}

#pragma mark- page 配置选项

/**
 *  配置uitableview的UITableViewStyle Group或者Plain 默认是Plain
 */
-(UITableViewStyle)yxpage_style{
    return UITableViewStylePlain;
}

/**
 *  设置是否有多个section
 *  YXPageViewControllerTypeRow:
 *      models中每个元素对应一个row,整个tableview只有一个section
 *
 *  YXPageViewControllerTypeSection:
 *       1.1 判断models中每个元素是否是nsarray
 *       1.2 如果是,每个NSArray对应一个section,NSArray中每个元素对应一个row
 *       1.3 如果不是,models中每个元素对应一个section,这个section只有一行
 */

- (YXPageViewControllerType)yxpage_type{
    return YXPageViewControllerTypeRow;
}

/**
 *  是否可以刷新，即 是否有头部刷新
 */
-(BOOL)yxpage_refreshenable{
    return YES;
}

- (void)yxpage_getModelsWithPage:(NSUInteger)page success:(void (^)(id models,NSUInteger totalPage))success failure:(void (^)(NSString *))failure{
    success(nil,1);
}
/**
 *  是否可以分页
 */
- (BOOL)yxpage_pageable{
    return YES;
}

/**
 *  头部刷新的类型
 *    YXPageViewControllerHeaderRefreshTypePull       //下拉类型
 *    YXPageViewControllerHeaderRefreshTypeProgress   //进度条类型
 */
- (YXPageViewControllerHeaderRefreshType)page_headerRefreshType{
    return YXPageViewControllerHeaderRefreshTypePull;
}

/**
 *  第一次进入页面是否自动刷新
 */
-(BOOL)yxpage_autoRefreshFirst{
    return YES;
}

#pragma mark- 无数据默认显示文字 相关配置

/**
 *  第一次进入页面,是否在还未获取数据时 直接显示text
 */
- (BOOL)yxpage_showNoDataTextFirst{
    return NO;
}

/**
 *  无数据时显示的文字
 */
- (NSString *)yxpage_noDataText{
    return @"";
}

/**
 *   无数据时显示的图片view
 */
- (UIImageView *)yxpage_noDataImageView{
    return nil;
}
/**
 *   如果默认的label的样式无法满足需求,可以用此方式返回一个满足你需求的一个label
 *   此方法只会执行一次
 */
- (UILabel *)yxpage_noDataLabel{
    UILabel *label =[[UILabel alloc] init];
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=[UIColor grayColor];
    label.numberOfLines=0;
    label.textAlignment=NSTextAlignmentCenter;
    return label;
}
/**
 *  显示无数据的文字和图片距离上方的位置,默认居中
 */
- (float)yxpage_noDataTextPadding{
    return 80;
}

#pragma mark- 缓存第一页相关配置

/** 当第一页获取网络失败的时候会利用此方法获取到缓存 */
- (NSArray *)page_getFirstPageCache{
    //    if([self page_cacheType]){
    //        return [YXModelTool getFirstPageCacheWithType:[self page_cacheType]];
    //    }
    return nil;
}
/** 适当时机 会调用此方法缓存第一页的所有models */

- (void)yxpage_saveFirstPageCacheWithModels:(NSArray *)models{
    //    if([self page_cacheType]){
    //            [YXModelTool saveFirstPageCacheWithType:[self page_cacheType] data:models];
    //    }
}

//page 配置相关
#pragma mark- 私有

- (void)onHeaderRefresh{
    [self refreshWithType:YXPageViewControllerRefreshTypeHeader];
}

- (void)onFooterRefresh{
    
    [self refreshWithType:YXPageViewControllerRefreshTypeFooter];
}

-(void)refreshWithType:(YXPageViewControllerRefreshType)type{
    __weak __typeof(self) weakSelf = self;
    id progress;
    if(type== YXPageViewControllerRefreshTypeHeader){
        self.yxpage_pageNum=1;
        [YXRefresh hideFooter:self.tableView hide:YES];
        if([weakSelf page_headerRefreshType]==YXPageViewControllerHeaderRefreshTypeProgress){
            progress=[YXRefresh showMessage:@"请稍等" toView:weakSelf.view];
        }
    }
    //上拉刷新
    [self yxpage_getModelsWithPage:self.yxpage_pageNum success:^(NSArray *models, NSUInteger totalPage) {
        yx_dispatch_main_sync_safe(^(){
            if(type== YXPageViewControllerRefreshTypeHeader){
                if([weakSelf page_headerRefreshType]==YXPageViewControllerHeaderRefreshTypeProgress){
                    [YXRefresh hideProgress:progress];
                }else{
                    [YXRefresh endHeaderRefresh:weakSelf.tableView];
                }
                
            }else{
                [YXRefresh endFooterRefresh:weakSelf.tableView];
            }
            
            if(models.count){
                //有数据
                NSUInteger startIndex;
                [weakSelf hideText];
                if(weakSelf.yxpage_pageNum==1){
                    //第一页
                    [weakSelf yxpage_saveFirstPageCacheWithModels:models];
                    [weakSelf.models removeAllObjects];
                }else{
                    //非第一页
                    startIndex=weakSelf.models.count;
                }
                [weakSelf.models addObjectsFromArray:models];
                [weakSelf.tableView reloadData];
                
            }else{
                //没有数据的时候
                if(weakSelf.yxpage_pageNum==1){
                    //第一页
                    [weakSelf showText:[weakSelf yxpage_noDataText]];
                    [weakSelf.models removeAllObjects];
                    [weakSelf.tableView reloadData];
                }
            }
            
            //如果页码大于等于总页数,隐藏footer
            if(weakSelf.yxpage_pageNum>=totalPage){
                //当加载全部的数据的时候隐藏上拉刷新
                [YXRefresh hideFooter:self.tableView hide:YES];
                return ;
            }
            
            //当尚未加载全部数据的时候显示上拉刷新
            [YXRefresh hideFooter:self.tableView hide:NO];
            [weakSelf.tableView setNeedsDisplay];
            weakSelf.yxpage_pageNum++;
            

        });
                //当加载第一页的时候
    } failure:^(NSString *error) {
        
        yx_dispatch_main_sync_safe(^(){
            if([self page_headerRefreshType]==YXPageViewControllerHeaderRefreshTypeProgress){
                [YXRefresh hideProgress:progress];
            }else{
                if (type==YXPageViewControllerRefreshTypeHeader) {
                    if(weakSelf.yxpage_pageNum==1){
                        //如果是第一页
                        NSArray *cache= [weakSelf page_getFirstPageCache];
                        if(cache.count){
                            [weakSelf.models removeAllObjects];
                            [weakSelf.models addObjectsFromArray:cache];
                        }else{
                            [weakSelf showText:[weakSelf yxpage_noDataText]];
                            [weakSelf.models removeAllObjects];
                        }
                        [weakSelf.tableView reloadData];
                        
                    }
                    [YXRefresh endHeaderRefresh:weakSelf.tableView];
                }else{
                    [YXRefresh endFooterRefresh:weakSelf.tableView];
                }
            }
            [YXRefresh showError:error];

        });
        
    }];
}

- (NSString *)yxpage_cellClassForIndexPath:(NSIndexPath *)indexPath{
    if ([self respondsToSelector:@selector(yxpage_registeCellClass)]) {
        return [self yxpage_registeCellClass];
    }
    return nil;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    //如果tableview是默认的，则需要是uitableview始终充满controller的view
    if(![self respondsToSelector:@selector(yxpage_tableView)]){
        self.tableView.frame=self.view.bounds;
    }
}

- (void)yxpage_setCell:(id)cell indexPath:(NSIndexPath *)indexPath{
    if([self respondsToSelector:@selector(yxpage_registeCellClass)]||[self respondsToSelector:@selector(yxpage_registeCellClasses)]){
        YXTableCell *yxCell = cell;
        yxCell.controller=self;
        YXPageViewControllerType type=[self yxpage_type];
        yxCell.row=indexPath.row;
        yxCell.section=indexPath.section;
        yxCell.indexPath=indexPath;
        if(!yxCell.tableView)
            yxCell.tableView=self.tableView;
        if(type==YXPageViewControllerTypeRow){
            [yxCell setModel:self.models[indexPath.row]];
        }else{
            [yxCell setModel:self.models[indexPath.section]];
        }
        
        
    }
}

- (void)showText:(NSString *)text{
    
    
    
    
    
    if(!_label){
        
        
        UIImageView *imageView = [self nodataImageView];
        if(imageView){
            [self.tableView addSubview:imageView];
            imageView.yxpage_width=59;
            imageView.yxpage_height=79;
            _nodataImageView = imageView;
        }
     
        UILabel *label =[self yxpage_noDataLabel];
        [self.tableView addSubview:label];
        self.label=label;
        imageView.yxpage_y=[self yxpage_noDataTextPadding];
        label.yxpage_y = imageView.yxpage_y+imageView.yxpage_height+10;
    }
    

    
    self.label.text=text;
    
    CGSize size=  [self.label sizeThatFits:CGSizeMake(180, 300)];
    self.label.yxpage_width=size.width;
    self.label.yxpage_height=size.height;
    [self.label yxpage_centerXToSuperView];
    self.label.hidden=NO;
    self.nodataImageView.hidden=NO;
    [self.nodataImageView yxpage_centerXToSuperView];
    
    
}

- (void)hideText{
    self.label.hidden=YES;
    self.nodataImageView.hidden=YES;
}

/** 展示缓存的第一页，需要主动调用 */
- (void)yxpage_showFirstPageCache{
    NSArray *cache = [self page_getFirstPageCache];
    if(cache.count){
        [self.models removeAllObjects];
        [self.models addObjectsFromArray:cache];
        [self.tableView reloadData];
    }
}








#pragma mark- 懒加载

- (NSMutableArray *)models{
    if (!_models) {
        _models=[NSMutableArray array];
    }
    return _models;
}

-(UITableView *)tableView{
    if(!_tableView){
        if([self respondsToSelector:@selector(yxpage_tableView)]){
            _tableView= [self yxpage_tableView];
            
        }else{
            UITableView *tableView= [[UITableView alloc] initWithFrame:self.view.bounds   style:[self yxpage_style]];
            [self.view addSubview:tableView];
            _tableView=tableView;
        }
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}



@end
