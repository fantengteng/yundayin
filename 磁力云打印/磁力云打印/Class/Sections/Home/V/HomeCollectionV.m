//
//  HomeCollectionV.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/16.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "HomeCollectionV.h"
#import "HomeBannerCollectionV.h"
#import "HomeSecondCollectionV.h"
#import "HomeModel.h"
@implementation HomeCollectionV

#pragma mark 生命周期

#pragma mark 回调协议

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 1) {
        return UIEdgeInsetsMake(0, 15, 0, 15);
    }else {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else  {
        return 4;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize Size ;
    if (indexPath.section == 0) {
        Size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 188);
    }else {
        Size =  CGSizeMake(([UIScreen mainScreen].bounds.size.width - 40) / 2,([UIScreen mainScreen].bounds.size.width - 40) / 2 * 1.42);
    }
    return Size;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return CGSizeZero;
    }else{
        return CGSizeMake(KScreenWidth , 40);
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.TT_delegate && [self.TT_delegate respondsToSelector:@selector(tapcellTriggereventIndex:model:)]) {
        [self.TT_delegate tapcellTriggereventIndex:indexPath model:@""];
    }
}

#pragma mark 触发方法

#pragma mark 公开方法

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ClassName;
    id Data ;
    if (indexPath.section == 0) {
        ClassName = @"banner";
        Data = self.Data[0];
    }else{
        ClassName = @"nonr";
        Data = self.Data[indexPath.section][indexPath.row];
    }
    return [self setupCollectionView:collectionView indexPath:indexPath CellName:ClassName data:Data];
}

- (void)configCellXIB {
    self.LineSpace = 10;
    [self registerClass:[HomeBannerCollectionV class] forCellWithReuseIdentifier:@"banner"];
    [self registerClass:[HomeSecondCollectionV class] forCellWithReuseIdentifier:@"nonr"];
}

#pragma mark 私有方法

- (void)changeDefaultConfigguration {
   
    NSMutableArray *data = [NSMutableArray new];
    [data addObject:@""];
    NSMutableArray *arr = [NSMutableArray new];
    [arr addObject:@"mini1"];
    [arr addObject:@"5cun1"];
    [arr addObject:@"6cun1"];
    [arr addObject:@"7cun1"];
    [data addObject:arr];
    [self configData:data has_more:NO];
     self.is_two = YES;
}



#pragma mark 存取方法




@end
