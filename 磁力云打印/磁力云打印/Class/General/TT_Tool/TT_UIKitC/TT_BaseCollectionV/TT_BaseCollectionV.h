//
//  TT_BaseCollectionV.h
//  TT_CollectionV
//
//  Created by linlin dang on 2019/3/28.
//  Copyright © 2019 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TT_BaseCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@protocol TT_BaseCollectionVDelegate<NSObject>

@optional
/// 上下啦刷新触发方法
- (void)refreshDataType:(NSInteger)type;
/// 滚动的距离
- (void)scrollviewoffsetY:(CGFloat)Y;
/// 向上 向下 滑动
- (void)scrollviewSlideupandDown:(BOOL)YorN scrollview:(UIScrollView *)scrollview;
/// 点击cell
- (void)tapcellTriggereventIndex:(NSIndexPath *)index model:(id)model;
/// 点击控件触发方法
- (void)tapviewActiontype:(NSInteger)type model:(id)model;

@end

@interface TT_BaseCollectionV : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>
/// 代理
@property (nonatomic , weak) id<TT_BaseCollectionVDelegate> TT_delegate;
/// 数据源
@property (nonatomic , strong) NSMutableArray *Data;
/// Cell
@property (nonatomic , strong) Class CellClass;
/// Cell 的大小
@property (nonatomic , assign) CGSize CellSize;
/// cell头 Size
@property (nonatomic , assign) CGSize CellHeadSize;
/// cell 尾 Size
@property (nonatomic , assign) CGSize CellFootSize;
/// 页数
@property (nonatomic , assign) NSInteger Page;
/// Cell 之间行间距
@property (nonatomic , assign) CGFloat LineSpace;
/// Cell 之间列间距
@property (nonatomic , assign) CGFloat InteritemSpace;
/// 上啦刷新
@property (nonatomic , assign) BOOL is_refreshHeader;
/// 下拉刷新
@property (nonatomic , assign) BOOL is_refreshfoot;
/// 第一时间响应滑动事件
@property (nonatomic , assign) BOOL Is_firstSlide;
/// 是否是二维数组
@property (nonatomic , assign) BOOL is_two;

+ (instancetype)setupTableVCellClass:(Class)cellClass
                               Frame:(CGRect)Frame
                collectionViewLayout:(UICollectionViewLayout *)layout;

/// 设置CollectionViewCell
- (TT_BaseCollectionViewCell *)setupCollectionView:(UICollectionView *)CollectionView
                                         indexPath:(NSIndexPath *)indexPath
                                          CellName:(NSString *)CellName
                                              data:(id)data;

- (void)tapCollectionCellTriggermethodfortype:(NSInteger)type Data:(id)Data CellName:(NSString *)CellName;

/// 修改属性
- (void)changeDefaultConfigguration;
/// 设置数据源
- (void)configData:(id)Data has_more:(BOOL)has_more;
/// 设置XIB
- (void)configCellXIB;
/// 结束刷新
- (void)endRefresh;

@end

NS_ASSUME_NONNULL_END
