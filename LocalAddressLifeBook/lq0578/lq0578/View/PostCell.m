//
//  PostCell.m
//  lq0578
//
//  Created by 汤维炜 on 16/3/28.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import "PostCell.h"

@interface PostCell()
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UILabel *label;
@end

@implementation PostCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIView *bgview = [[UIView alloc]init];
        bgview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self.contentView addSubview:bgview];
        
       _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-17, self.frame.size.height-17)];
       
        [bgview addSubview:_imageview];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, _imageview.frame.size.height+2, 60,15)];
        [bgview addSubview:_label];
        
        CGPoint center = self.label.center;
        center   = CGPointMake(_imageview.center.x, center.y);
        self.label.center  = center;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:10];
        
    }
    return self;
}

- (void)cellWithInfo:(NSDictionary *)dic {
     _imageview.image = [UIImage imageNamed:dic[@"icon"]];
    _label.text = dic[@"title"];

}
@end
