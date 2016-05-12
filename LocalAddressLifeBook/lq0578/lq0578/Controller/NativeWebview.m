//
//  NativeWebview.m
//  lq0578
//
//  Created by 汤维炜 on 16/3/28.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import "NativeWebview.h"
#import "BusDicketsInfomation.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface NativeWebview ()<UIWebViewDelegate>

@end

@implementation NativeWebview

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNavigaionUI];
    
    [self drawMainUI];
    
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)drawMainUI {
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webview.delegate = self;
    [self.view  addSubview:webview];
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [webview loadRequest:request];

}

- (void)configureNavigaionUI {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewController)];
    leftItem.tintColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.navigationItem.titleView = titleView;
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = self.title;
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor lightGrayColor];
    [titleView addSubview:title];
    
    if ([self.title isEqualToString:@"汽车票"]) {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"车票" style:UIBarButtonItemStylePlain target:self action:@selector(findBusDicketsInfo)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

- (void)findBusDicketsInfo {
    BusDicketsInfomation *ctr = [BusDicketsInfomation new];
    [self.navigationController pushViewController:ctr animated:NO];
}

- (void)dismissViewController {
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD showWithStatus:@"加载失败"];
    
    [SVProgressHUD dismiss];

}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [SVProgressHUD showWithStatus:@"loading..."];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
