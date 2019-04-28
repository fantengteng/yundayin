//
//  HomeSelectCollectionV.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/18.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "HomeSelectCollectionV.h"
#import "SelectCollectionCell.h"

@implementation HomeSelectCollectionV

- (void)configLayuotSubviews {
    self.margin = 10;
    self.itemWH = (self.bounds.size.width - 100);
    self.layout.itemSize = CGSizeMake(self.itemWH, self.itemWH);
    self.layout.minimumLineSpacing = self.margin;
    [self.collectionView setCollectionViewLayout:self.layout];
    [self changeCollectionFrame];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.row == self.selectedPhotos.count) {
        TT_CollectionIMGCell *IMGcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
        IMGcell.imageView.image = [UIImage imageNamed:@"update"];
        IMGcell.deleteBtn.hidden = YES;
        return IMGcell;
    }else {
         SelectCollectionCell *IMGcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IMG" forIndexPath:indexPath];
        @weakify(self)
        HomeSelectIMGModel *model = [[HomeSelectIMGModel alloc]init];
        model.IMG = self.selectedPhotos[indexPath.row];
        IMGcell.model = model;
        [self.SelectIMGarr addObject:model];
        IMGcell.currencyparameterClose = ^(NSInteger type, id  _Nonnull Data) {
            @strongify(self)
            [self delectIMG:indexPath.item];
        };
        
        return IMGcell;

    }
}

- (void)delectIMG:(NSInteger)index {
    if ([self collectionView:self.collectionView numberOfItemsInSection:0] <= self.selectedPhotos.count) {
        [self.selectedPhotos removeObjectAtIndex:index];
        [self.collectionView reloadData];
        return;
    }
    [self.SelectIMGarr removeObjectAtIndex:index];
    [self.selectedPhotos removeObjectAtIndex:index];
    [self.selectedAssets removeObjectAtIndex:index];
    @weakify(self)
    [self.collectionView performBatchUpdates:^{
        @strongify(self)
        NSIndexPath *index = [NSIndexPath indexPathForItem:index inSection:0];
        [self.collectionView deleteItemsAtIndexPaths:@[index]];
    } completion:^(BOOL finished) {
        @strongify(self)
        [self.collectionView reloadData];
        [self changeCollectionFrame];
    }];
}

- (void)changeCollectionFrame {
    self.collectionView.frame = self.bounds;
    [self.collectionView registerClass:[SelectCollectionCell class] forCellWithReuseIdentifier:@"IMG"];
}


- (NSMutableArray *)SelectIMGarr {
    if (!_SelectIMGarr) {
        _SelectIMGarr = [NSMutableArray new];
    }
    return _SelectIMGarr;
}

@end
