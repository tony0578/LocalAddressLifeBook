//
//  FuliCell.h
//  lq0578
//
//  Created by 汤维炜 on 16/2/18.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuliCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fuliImageview;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIButton *callBtn;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;

@property (weak, nonatomic) IBOutlet UIButton *taobaoBtn;
@end
