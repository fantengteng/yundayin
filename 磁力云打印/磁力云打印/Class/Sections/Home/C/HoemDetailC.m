//
//  HoemDetailC.m
//  磁力云打印
//
//  Created by linlin dang on 2019/4/17.
//  Copyright © 2019 FTT. All rights reserved.
//

#import "HoemDetailC.h"
#import "HomeSelectIMGC.h"
@interface HoemDetailC ()

@end

@implementation HoemDetailC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.size_Str;
  
}
- (IBAction)select_IMG:(id)sender {
    HomeSelectIMGC *select = [[HomeSelectIMGC alloc]init];
    select.money = self.money;
    select.size_Str = self.size_Str;
    [self.navigationController pushViewController:select animated:YES];
}




- (void)tt_changeDefauleConfiguration {
    self.Is_hideJuhuazhuan = NO;
    self.select_phoneBTN.layer.cornerRadius = 5;
    self.select_phoneBTN.layer.borderColor = Col_04D.CGColor;
    self.select_phoneBTN.layer.borderWidth = 1;
    self.title_BG.layer.cornerRadius = 5;
    self.title_BG.backgroundColor = [Col_0A3 colorWithAlphaComponent:0.1];
    self.headerIMG.image = [UIImage imageNamed:self.header_Str];
    self.title_LAB.text = self.size_Str;
    self.size_LAB.text = self.mm_Str;
    self.price_LAB.text = [NSString stringWithFormat:@"¥%.2f/张",self.money];
}

@end
