//
//  postData.m
//  lq0578
//
//  Created by 汤维炜 on 16/3/28.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import "postData.h"

@implementation postData

+ (NSArray *)defaultPostInfo {
    
    postData *p1 = [postData new];
    p1.icon = @"test";
    p1.title = @"快递查询";
    p1.url = @"http:///www.kuaidi100.com";
    
    postData *p2 = [postData new];
    p2.icon = @"test";
    p2.title = @"水电费";
    p2.url = @"http://www.baidu.com";
    
    postData *p3 = [postData new];
    p3.icon = @"test";
    p3.title = @"火车票";
    p3.url = @"http://kuai.baidu.com/webapp/train/index.html";
    
    postData *p4 = [postData new];
    p4.icon = @"test";
    p4.title = @"汽车票";
    p4.url = @"http://keyun.96520.com/";
    
    postData *p5 = [postData new];
    p5.icon = @"test";
    p5.title = @"飞机票";
    p5.url = @"http://m.ctrip.com/html5/flight";
    
    postData *p6 = [postData new];
    p6.icon = @"test";
    p6.title = @"理财产品";
    p6.url = @"http://www.baidu.com";
    
    postData *p7 = [postData new];
    p7.icon = @"test";
    p7.title = @"公积金查询";
    p7.url = @"http://www.longquan.gov.cn/zhxx/rdzt/zfgjj/gjjtq/lqs";
    
    postData *p8 = [postData new];
    p8.icon = @"test";
    p8.title = @"话费";
    p8.url = @"http://www.10086.cn";
    
    return @[p1,p2,p3,p4,p5,p6,p7,p8];
}

@end
