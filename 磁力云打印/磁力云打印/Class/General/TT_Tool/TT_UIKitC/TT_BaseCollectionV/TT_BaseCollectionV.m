//
//  TT_BaseCollectionV.m
//  TT_CollectionV
//
//  Created by linlin dang on 2019/3/28.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TT_BaseCollectionV.h"
#import <MJRefresh/MJRefresh.h>
@interface TT_BaseCollectionV ()

/// 第一次获取
@property (nonatomic , assign) BOOL Is_firstload;

@property (nonatomic , strong) NSString *cellName;
/// 上啦 下啦
@property (nonatomic , assign) NSInteger pushOrpull;
/// 是否有更多的数据
@property (nonatomic , assign) BOOL havemore;

/// 上一次滑动的位置
@property (nonatomic , assign) CGFloat oldcontentOffsetY;

@end
@implementation TT_BaseCollectionV



#pragma mark 生命周期


+ (instancetype)setupTableVCellClass:(Class)cellClass Frame:(CGRect)Frame collectionViewLayout:(UICollectionViewLayout *)layout{
    return [[cellClass alloc]initWithFrame:Frame collectionViewLayout:layout];
}


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self configDefault];
        [self configCellXIB];
        [self changeDefaultConfigguration];
    }
    return self;
}

#pragma mark 回调协议

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.is_two) {
        return self.Data.count;
    }else {
        return 1;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.is_two) {
        NSMutableArray *arr = self.Data[section];
        return arr.count;
    }else {
        return self.Data.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self setupCollectionView:collectionView indexPath:indexPath CellName:self.cellName data:[self GettingdatasourcesIndexPath:indexPath]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.TT_delegate && [self.TT_delegate respondsToSelector:@selector(tapcellTriggereventIndex:model:)]) {
        [self.TT_delegate tapcellTriggereventIndex:indexPath model:[self GettingdatasourcesIndexPath:indexPath]];
    }
}

/** cell之间最小行间距 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.LineSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return self.InteritemSpace;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.CellSize;
}


/// 已经开始滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if (bottomOffset <= height + ([UIScreen mainScreen].bounds.size.height / 2) && !self.Is_firstload && self.is_refreshfoot) {
        if (self.havemore) {
            self.Is_firstload = YES;
            self.Page = self.Page + 1;
            [self setRefreshDataType:2];
        }
    }
    if (self.TT_delegate != nil && [self.TT_delegate respondsToSelector:@selector(scrollviewoffsetY:)]) {
        [self.TT_delegate scrollviewoffsetY:offsetY];
    }
    if (self.Is_firstSlide) {
        [self setUpOrDownForScrollview:scrollView];
    }
}

/// 将要开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.oldcontentOffsetY = scrollView.contentOffset.y;
}

/// 已经开始拖拽
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setUpOrDownForScrollview:scrollView];
}

/// 当滚动视图滚动到最顶端后，执行该方法
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [self setUpOrDownForScrollview:scrollView];
}

/// 滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。
/// decelerate,指代，当我们手指离开那一瞬后，视图是否还将继续向前滚动（一段距离），经过测试，decelerate=YES
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self setUpOrDownForScrollview:scrollView];
    }
}


#pragma mark 触发方法

/// 下啦刷新触发方法
- (void)headerRefresh {
    self.pushOrpull = 1;
    self.Page = 1;
    [self setRefreshDataType:1];
}

/// 上啦刷新触发方法
- (void)footerRefresh {
    self.pushOrpull = 2;
    if (self.havemore) {
        self.Page = self.Page + 1;
        [self setRefreshDataType:2];
    }else {
        self.mj_footer.state = MJRefreshStateNoMoreData;
    }
}

/// 设置上下啦刷新的代理
- (void)setRefreshDataType:(NSInteger)type {
    if (self.TT_delegate != nil && [self.TT_delegate respondsToSelector:@selector(refreshDataType:)]) {
        [self.TT_delegate refreshDataType:type];
    }
}

/// 结束刷新
- (void)endRefresh {
    if (self.pushOrpull == 1) {
        if (self.mj_header != nil) {
            [self.mj_header endRefreshing];
        }
    }else {
        if (self.mj_footer != nil) {
            [self.mj_footer endRefreshing];
        }
    }
    [self reloadData];
}

/// 设置上下 方向代理
- (void)setUpOrDownForScrollview:(UIScrollView *)Scrollview {
    BOOL YorN;
    if (Scrollview.contentOffset.y > self.oldcontentOffsetY) {
        YorN = NO;
    }else {
        YorN = YES;
    }
    if (self.TT_delegate != nil && [self.TT_delegate respondsToSelector:@selector(scrollviewSlideupandDown:scrollview:)]) {
        [self.TT_delegate scrollviewSlideupandDown:YorN scrollview:Scrollview];
    }
}
#pragma mark 公开方法

/// 设置CollectionViewCell
- (TT_BaseCollectionViewCell *)setupCollectionView:(UICollectionView *)CollectionView indexPath:(NSIndexPath *)indexPath CellName:(NSString *)CellName data:(id)data{
    TT_BaseCollectionViewCell *Cell = [CollectionView dequeueReusableCellWithReuseIdentifier:CellName forIndexPath:indexPath];
    Cell.Data = data;
    [Cell configforData:data];
    Cell.CollectionCellBlock = ^(NSInteger num, id  _Nonnull Data) {
        [self tapCollectionCellTriggermethodfortype:num Data:Data CellName:CellName];
    };
    return Cell;
}

- (void)configData:(id)Data has_more:(BOOL)has_more {
    self.havemore = has_more;
    self.Is_firstload = NO;
    if (self.Page == 1) {
        [self.Data removeAllObjects];
    }
    [self.Data addObjectsFromArray:Data];
    [self configIstoweer];
    self.dataSource                     = self;
    self.delegate                       = self;
    [self endRefresh];
    
}
/// 修改属性
- (void)changeDefaultConfigguration {
    
}

/// 设置XIB
- (void)configCellXIB {
    
}

#pragma mark 私有方法

/// 设置默认属性
- (void)configDefault {
    self.backgroundColor                = [UIColor whiteColor];
    self.scrollsToTop                   = NO;
    self.showsVerticalScrollIndicator   = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.userInteractionEnabled         = YES;

    self.decelerationRate               = UIScrollViewDecelerationRateNormal;
    self.LineSpace                      = 0;
    self.InteritemSpace                 = 0;
    self.Page                           = 1;
    self.is_refreshHeader               = NO;
    self.is_refreshfoot                 = NO;
}

/// 分析数据
- (id)GettingdatasourcesIndexPath:(NSIndexPath*)indexPath {
    id Data ;
    if (self.is_two) {
        Data = self.Data[indexPath.section][indexPath.row];
    }else {
        Data = self.Data[indexPath.row];
    }
    return Data;
}

/// 回调触发方法
- (void)tapCollectionCellTriggermethodfortype:(NSInteger)type Data:(id)Data CellName:(NSString *)CellName{
    if (self.TT_delegate && [self.TT_delegate respondsToSelector:@selector(tapviewActiontype:model:)]) {
        [self.TT_delegate tapviewActiontype:type model:Data];
    }
}

/// 设置下啦刷新
- (void)setupPullHeaderRefresh {
   self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
}

/// 设置上啦刷新
- (void)setupPushFootRefresh {
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}

/// 检查数据源墅不是二维数组
- (void)configIstoweer {
    if (self.Data.count != 0) {
        id result = self.Data[0];
        if ([result isKindOfClass:[NSArray class]] || [result isKindOfClass:[NSMutableArray class]]) {
            self.is_two = YES;
        }else {
            self.is_two = NO;
        }
    }else {
        self.is_two = NO;
    }
}
#pragma mark 存取方法

- (void)setHavemore:(BOOL)havemore {
    _havemore = havemore;
    if (self.is_refreshfoot && !havemore) {
        self.mj_footer.state =  MJRefreshStateNoMoreData;
    }
}

/** 设置cell */
- (void)setCellClass:(Class)CellClass {
    _CellClass = CellClass;
    self.cellName = [NSString stringWithFormat:@"%s",object_getClassName(CellClass)];
    [self registerClass:CellClass forCellWithReuseIdentifier:self.cellName];
}

- (void)setIs_refreshHeader:(BOOL)is_refreshHeader {
    _is_refreshHeader = is_refreshHeader;
    if (is_refreshHeader) {
        [self setupPullHeaderRefresh];
    }
}

- (void)setIs_refreshfoot:(BOOL)is_refreshfoot {
    _is_refreshfoot = is_refreshfoot;
    if (is_refreshfoot) {
        [self setupPushFootRefresh];
    }
}

- (NSMutableArray *)Data {
    if (!_Data) {
        _Data = [NSMutableArray new];
    }
    return _Data;
}
@end
