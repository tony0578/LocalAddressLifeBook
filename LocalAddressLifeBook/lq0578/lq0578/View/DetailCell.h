//
//  DetailCell.h
//  lq0578
//
//  Created by 汤维炜 on 16/2/17.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *callBtn;
@property (nonatomic, assign) int selectedTag;
@property (nonatomic, strong) NSString *phoneNum;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UILabel *businessLabel;
- (void)setCellBusiness:(NSString *)business                                phoneNum:(NSString *)phonenum
          addressString:(NSString *)address;

@end
