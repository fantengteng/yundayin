//
//  TT_CollectionIMGV.m
//  TT_CollectionIMGV
//
//  Created by linlin dang on 2019/4/2.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "TT_CollectionIMGV.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/Photos.h>
#import "TZImagePickerController/TZImagePickerController.h"
@interface TT_CollectionIMGV ()<TZImagePickerControllerDelegate>{
 
}




@property (strong, nonatomic) CLLocation *location;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@property (nonatomic, strong) NSOperationQueue *operationQueue;


@end

@implementation TT_CollectionIMGV


#pragma mark 生命周期
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.maxCount = 9;
        [self tt_setupSubViewS];
        [self configregister];
        [self configLayuotSubviews];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maxCount = 9;
        [self tt_setupSubViewS];
        [self configregister];
        [self configLayuotSubviews];
    }
    return self;
}

#pragma mark 回调协议

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.selectedPhotos.count >= self.maxCount) {
        return self.selectedPhotos.count;
    }
    return self.selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TT_CollectionIMGCell *IMGcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    if (indexPath.row == self.selectedPhotos.count) {
        IMGcell.imageView.image = [UIImage imageNamed:@"update"];
        IMGcell.deleteBtn.hidden = YES;
    }else {
        IMGcell.imageView.image = self.selectedPhotos[indexPath.item];
        IMGcell.deleteBtn.hidden = NO;
    }
    IMGcell.deleteBtn.tag = indexPath.item;
    [IMGcell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return IMGcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.selectedPhotos.count) {
        if (self.showSheet) {
            NSString *takePhotoTitle = @"拍照";
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:takePhotoTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self takePhoto];
            }];
            [alertVc addAction:takePhotoAction];
            UIAlertAction *imagePickerAction = [UIAlertAction actionWithTitle:@"去相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self pushTZImagePickerController];
            }];
            [alertVc addAction:imagePickerAction];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertVc addAction:cancelAction];
            UIPopoverPresentationController *popover = alertVc.popoverPresentationController;
            UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
            if (popover) {
                popover.sourceView = cell;
                popover.sourceRect = cell.bounds;
                popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
            }
            [self.VC presentViewController:alertVc animated:YES completion:nil];
        }else {
            [self pushTZImagePickerController];
        }
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
   return UIEdgeInsetsMake(_margin, _margin, _margin, _margin);
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(PHAsset *asset, NSError *error){
            [tzImagePickerVc hideProgressHUD];
            if (error) {
//                NSLog(@"图片保存失败 %@",error);
            } else {
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
            }
        }];
    } else if ([type isEqualToString:@"public.movie"]) {
        NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
        if (videoUrl) {
            [[TZImageManager manager] saveVideoWithUrl:videoUrl location:self.location completion:^(PHAsset *asset, NSError *error) {
                [tzImagePickerVc hideProgressHUD];
                if (!error) {
                    TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                    [[TZImageManager manager] getPhotoWithAsset:assetModel.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
                        if (!isDegraded && photo) {
                            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:photo];
                        }
                    }];
                }
            }];
        }
    }
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    [_collectionView reloadData];
    [self changeCollectionFrame];
    [self printAssetsName:assets];
    // 2.图片位置信息
//    for (PHAsset *phAsset in assets) {
//        NSLog(@"location:%@",phAsset.location);
//    }
    // 3. 获取原图的示例，用队列限制最大并发为1，避免内存暴增
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.operationQueue.maxConcurrentOperationCount = 1;
}




- (void)refreshCollectionViewWithAddedAsset:(PHAsset *)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    [_selectedPhotos addObject:image];
    [_collectionView reloadData];
//    if ([asset isKindOfClass:[PHAsset class]]) {
//        PHAsset *phAsset = asset;
//        NSLog(@"location:%@",phAsset.location);
//    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark 触发方法

- (void)deleteBtnClick:(UIButton *)btn {
    if ([self collectionView:self.collectionView numberOfItemsInSection:0] <= _selectedPhotos.count) {
        [self.selectedPhotos removeObjectAtIndex:btn.tag];
        [self.collectionView reloadData];
        return;
    }
    
    [self.selectedPhotos removeObjectAtIndex:btn.tag];
    [self.collectionView performBatchUpdates:^{
        NSIndexPath *index = [NSIndexPath indexPathForItem:btn.tag inSection:0];
        [self->_collectionView deleteItemsAtIndexPaths:@[index]];
    } completion:^(BOOL finished) {
        [self->_collectionView reloadData];
        [self changeCollectionFrame];
    }];
}

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        [FTT_Helper CreateTitle:@"无法使用相机"
                        message:@"请在iPhone的""设置-隐私-相机""中允许访问相机"
                   CantionTitle:@"取消"
                           Sure:@"设置"
                 preferredStyle:UIAlertControllerStyleAlert
                         SureAC:^{
                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                         } NoAC:nil
                 ViewController:self.VC];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        [FTT_Helper CreateTitle:@"无法使用相机"
                        message:@"请在iPhone的""设置-隐私-相机""中允许访问相机"
                   CantionTitle:@"取消"
                           Sure:@"设置"
                 preferredStyle:UIAlertControllerStyleAlert
                         SureAC:^{
                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                         } NoAC:nil
                 ViewController:self.VC];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

- (void)changeCollectionFrame {
    NSInteger num =0;
    if (self.maxCount == self.selectedPhotos.count) {
        num =1;
    }
    if (self.selectedPhotos.count > 2 + num && self.selectedPhotos.count < 6 + num) {
        self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, (_itemWH + _margin ) * 2 + 10);
    }else if (self.selectedPhotos.count >= 5 + num ) {
        self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, (_itemWH + _margin ) * 3 + 10);
    }else {
        self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, (_itemWH + _margin ) * 1 + 10);
    }
    if (self.ChangeFrame) {
        self.ChangeFrame(self.collectionView.bounds.size.height);
    }
}

#pragma mark 公开方法

- (void)configLayuotSubviews {
    _margin = 10;
    _itemWH = (self.bounds.size.width - _margin * 4) / 3;
    _layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    _layout.minimumLineSpacing = _margin;
    [self.collectionView setCollectionViewLayout:_layout];
    [self changeCollectionFrame];
}

- (void)configregister {
    [_collectionView registerClass:[TT_CollectionIMGCell class] forCellWithReuseIdentifier:@"CELL"];
}

#pragma mark 私有方法

- (void)tt_setupSubViewS {
    [self addSubview:self.collectionView];
}

- (void)pushTZImagePickerController {
    if (self.maxCount <= 0) {
        return;
    }
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCount columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    if (self.maxCount > 1) {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    }
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    imagePickerVc.showSelectedIndex = YES;
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];
    [self.VC presentViewController:imagePickerVc animated:YES completion:nil];
}

// 调用相机
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        [mediaTypes addObject:(NSString *)kUTTypeMovie];
        [mediaTypes addObject:(NSString *)kUTTypeImage];
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [self.VC presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
       
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}

- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (PHAsset *asset in assets) {
        fileName = [asset valueForKey:@"filename"];
    }
}
#pragma mark 存取方法

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _layout = layout;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.alwaysBounceVertical = YES;
        CGFloat rgb = 244 / 255.0;
        _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
    }
    return _collectionView;
}


- (NSMutableArray *)selectedAssets {
    if (!_selectedAssets) {
        _selectedAssets = [NSMutableArray new];
    }
    return _selectedAssets;
}

- (NSMutableArray *)selectedPhotos {
    if (!_selectedPhotos) {
        _selectedPhotos = [NSMutableArray new];
    }
    return _selectedPhotos;
}
@end
