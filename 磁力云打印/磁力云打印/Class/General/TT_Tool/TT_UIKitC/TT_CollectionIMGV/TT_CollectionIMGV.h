//
//  TT_CollectionIMGV.h
//  TT_CollectionIMGV
//
//  Created by linlin dang on 2019/4/2.
//  Copyright © 2019 FTT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TT_CollectionIMGCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface TT_CollectionIMGV : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
/// 最大照片个数
@property (nonatomic , assign) NSInteger maxCount;
/// 是否允许
@property (nonatomic , assign) BOOL allowPickingMuitlpleVideo;
/// 是否显示拍照
@property (nonatomic , assign) BOOL showSheet;

@property (nonatomic , strong) UIViewController *VC;

@property (nonatomic , copy) void(^ChangeFrame)(CGFloat H);

@property (nonatomic , assign) CGFloat itemWH;

@property (nonatomic , assign) CGFloat margin;

@property (strong, nonatomic) UICollectionViewFlowLayout *layout;

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) NSMutableArray *selectedAssets;

/// 照片数组
@property (nonatomic , strong) NSMutableArray *selectedPhotos;

- (void)configLayuotSubviews;
- (void)configregister;
- (void)changeCollectionFrame;
/// 拍照
- (void)takePhoto;
/// 相册
- (void)pushTZImagePickerController ;

- (void)deleteBtnClick:(UIButton *)btn;

@end

NS_ASSUME_NONNULL_END
