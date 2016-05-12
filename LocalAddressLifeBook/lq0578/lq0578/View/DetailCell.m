//
//  DetailCell.m
//  lq0578
//
//  Created by 汤维炜 on 16/2/17.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import "DetailCell.h"
#import "SDWebImageManager.h"
#import  "UIImageView+WebCache.h"
//
#import "MobClick.h"

@interface DetailCell()
@property (weak, nonatomic) IBOutlet UIImageView *desc_Image;
@property (weak, nonatomic) IBOutlet UILabel *address;

@end

@implementation DetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setCellBusiness:(NSString *)business
               phoneNum:(NSString *)phonenum
          addressString:(NSString *)address{

    self.addressLabel.text = address;
    self.phoneLabel.text = phonenum;
    self.businessLabel.text = business;
//    self.callBtn.layer.cornerRadius = 20;
    [self.callBtn addTarget:self action:@selector(callService) forControlEvents:UIControlEventTouchUpInside];
}


- (void)callService {
    NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",self.phoneNum]; //而这个方法则打电话前先弹框 是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
    
    [MobClick event:@"connectBusiness" attributes:@{@"businessName":self.businessLabel.text}];
    
}

@end
