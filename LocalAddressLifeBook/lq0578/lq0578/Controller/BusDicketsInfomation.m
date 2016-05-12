//
//  BusDicketsInfomation.m
//  lq0578
//
//  Created by 汤维炜 on 16/3/28.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import "BusDicketsInfomation.h"

#define viewwidth self.view.frame.size.width
#define viewheight self.view.frame.size.height

@interface BusDicketsInfomation ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView      *bgview;

@end

@implementation BusDicketsInfomation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavifationUI];
    
    [self configureMainUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)customNavifationUI {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    leftItem.tintColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    self.navigationItem.titleView = titleView;
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    title.text = @"龙泉车站班车信息";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor lightGrayColor];
    [titleView addSubview:title];
}

- (void)configureMainUI {

    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewwidth, viewheight)];
    scrollview.contentSize = CGSizeMake(viewwidth, 4000);
    scrollview.showsVerticalScrollIndicator = YES;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.delegate = self;
    scrollview.maximumZoomScale = 2.0f;
    scrollview.minimumZoomScale = 0.5f;
    
    [self.view addSubview:scrollview];
    
    _bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 28, viewwidth, 4000)];
    [scrollview addSubview:_bgview];
    for (int i = 0; i<14; i++) {
        
        UIImageView *imageview = [self addImageOnBgviewWithHorizenY:i*260 iconName:[NSString stringWithFormat:@"busInfo%d",i+1]];
        
        [_bgview addSubview:imageview];
    }
}

- (UIImageView *)addImageOnBgviewWithHorizenY:(CGFloat)y iconName:(NSString *)icon {

    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(19, y, viewwidth-38, 258)];
    imageview.image = [UIImage imageNamed:icon];
    return imageview;
}

#pragma mark -UIScrollviewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

    return _bgview;
}

- (void)dismiss {
    
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
