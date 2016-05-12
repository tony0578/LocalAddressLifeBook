//
//  postData.h
//  lq0578
//
//  Created by 汤维炜 on 16/3/28.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface postData : NSObject
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
+ (NSArray *)defaultPostInfo;
@end
