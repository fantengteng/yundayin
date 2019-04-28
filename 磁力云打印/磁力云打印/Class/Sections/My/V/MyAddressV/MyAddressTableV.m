//
//  MyAddressTableV.m
//  捕鱼达人
//
//  Created by linlin dang on 2019/4/3.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "MyAddressTableV.h"
#import "MyAddressCell.h"
@implementation MyAddressTableV

#pragma mark 生命周期

#pragma mark 回调协议

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyAddressCell *cell = [MyAddressCell cellWithTableView:tableView CellClass:[MyAddressCell class]];
    cell.model = self.infodata[indexPath.row];
    cell.currencyClose = ^(NSInteger num) {
        if (self.tapClose) {
            self.tapClose(num, self.infodata[indexPath.row]);
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  [tableView cellHeightForIndexPath:indexPath model:self.infodata[indexPath.row] keyPath:@"model" cellClass:[MyAddressCell class] contentViewWidth:KScreenWidth];
}



#pragma mark 触发方法

#pragma mark 公开方法

- (void)configCellXIB {
    self.backgroundColor = Col_F6F;
}


#pragma mark 私有方法

#pragma mark 存取方法


@end
