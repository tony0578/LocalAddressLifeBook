//
//  ViewController.m
//  lq0578
//
//  Created by 汤维炜 on 16/2/12.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import "ViewController.h"
#import "FuliShowViewController.h"
#import "SearchViewController.h"
#import "DetailViewController.h"
#import "JobsTableViewController.h"
#import "CallmeViewController.h"
#import "WelcomeViewController.h"

// 网络连接

#import "RealReachability.h"
#import "LocalConnection.h"
#import "SVProgressHUD.h"
#import "MobClick.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface ViewController ()<UIScrollViewDelegate,WelcomeViewControllerDelegate>
@property (nonatomic, strong)   UIScrollView *scrollview;
@property (nonatomic, strong) UIView *bgview_advertise;
@property (nonatomic, strong) UIButton *bgBtn;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *aderLabel;
@property (nonatomic, strong) UIButton *closeAd;
@property (nonatomic, strong) WelcomeViewController *welcomeCtr;

@end

#define viewWidth  self.view.frame.size.width
#define h          self.view.frame.size.height

static CGFloat viewHeight = 44.0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavigation];
    [self initScrollview];
    // 设置标题栏
    [self defaultHeaderviewParagms];
    // 设置Label
    [self initAllLabels];
    [self drawAdvertiseViewOnBottom];
    
    [GLobalRealReachability startNotifier];
    // 接受联网状态通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkChanged:) name:kRealReachabilityChangedNotification object:nil];
}

- (void)getBusinessMessageFromPlistFile {

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"businessMessage" ofType:@"plist"];
    NSMutableArray *aar = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    NSLog(@"====%@",aar);
    NSLog(@"=====");
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    // 判断网络连接
    [self wifiConnectedJudge];
    
    // 判断第一次使用app
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"KFirstTimeRunning"]) {
        [self showWelcomeUI];
    }
    
    [self.navigationController setNavigationBarHidden:NO];
    _bgview_advertise.hidden = NO;
    _scrollview.hidden = NO;
    _titleView.hidden = NO;
    _closeAd.hidden = NO;
    [self scrollLabelContentWithLabel:_aderLabel];
    
}

- (void)wifiConnectedJudge {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillDisappearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidDisappearNotification
                                               object:nil];
}

- (void)handleNotification:(NSNotification *)notification {
    NSLog(@"Notification recieved: %@", notification.name);
    NSLog(@"Status user info key: %@", notification.userInfo[SVProgressHUDStatusUserInfoKey]);
}

- (void)show {
    [SVProgressHUD show];
}

- (void)dismiss {
    [SVProgressHUD dismiss];
}

- (void)showWelcomeUI {

    _welcomeCtr = [WelcomeViewController new];
    _welcomeCtr.delegate = self;
    [self.view addSubview:_welcomeCtr.view];
    
    [UIView animateWithDuration:0.2f animations:^{
        _welcomeCtr.view.alpha = 1.0;
        _welcomeCtr.view.frame = self.view.bounds;
    } completion:^(BOOL finished) {
        self.navigationController.navigationBarHidden = YES;
    }];
}

#pragma mark - WelcomeViewControllerDelegate

- (void)closeWelcomeGuiderUI {
    
    [_welcomeCtr.view removeFromSuperview];
    self.navigationController.navigationBarHidden =NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    _bgview_advertise.hidden = YES;
    _scrollview.hidden = YES;
    _titleView.hidden = YES;
    _closeAd.hidden = YES;

}

// 广告
- (void)drawAdvertiseViewOnBottom {
    
    _bgview_advertise = [[UIView alloc]init];
    _bgview_advertise.frame = CGRectMake(0, h-44, viewWidth, 44);
    _bgview_advertise.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgview_advertise];
    
    _aderLabel = [[UILabel alloc]init];
    _aderLabel.frame = CGRectMake(0, 10, self.view.frame.size.width, 34);
    _aderLabel.numberOfLines = 1;
    [_bgview_advertise addSubview:_aderLabel];
    _aderLabel.textColor = RGBCOLOR(50, 50, 50);
    _aderLabel.text = @"今日头条：广告位招租。联系：QQ278076338 Mr.Tom";
    NSString *string = _aderLabel.text;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = NSMakeRange(0, 4);
    NSDictionary *orangeDic = @{NSForegroundColorAttributeName:RGBCOLOR(255, 86, 40)};
    [attStr addAttributes:orangeDic range:range];
    _aderLabel.attributedText = attStr;
    [self scrollLabelContentWithLabel:_aderLabel];
    
    _titleView = [[UIView alloc]init];
    _titleView.frame = CGRectMake(0, h-44-25, viewWidth, 25);
    _titleView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_titleView];
    
    _closeAd = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeAd.frame = CGRectMake(viewWidth-35, h-44-25, 25, 25);
    [_closeAd setBackgroundImage:[UIImage imageNamed:@"v1_close_name"] forState:UIControlStateNormal];
    [_closeAd addTarget:self action:@selector(closeAdertise:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeAd];
    
    _bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bgBtn.frame = CGRectMake(0, 0, viewWidth, 44);
    [_bgBtn addTarget:self action:@selector(gotoAdertiseCtr) forControlEvents:UIControlEventTouchUpInside];
    [_bgview_advertise addSubview:_bgBtn];
    
}
// 横移动画
- (void)scrollLabelContentWithLabel:(UILabel *)labelShow{
    
    
    [labelShow sizeToFit];
    CGRect frame = labelShow.frame;
    frame.origin.x = self.view.frame.size.width;
    labelShow.frame = frame;
    
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:11.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    
    frame = labelShow.frame;
    frame.origin.x = -frame.size.width;
    labelShow.frame = frame;
    [UIView commitAnimations];
    
}


- (void)gotoAdertiseCtr {    
    CallmeViewController *ctr = [CallmeViewController new];
    [self.navigationController pushViewController:ctr animated:NO];
}

- (void)closeAdertise:(UIButton *)sender {
    [sender removeFromSuperview];
    [_titleView removeFromSuperview];
    [_bgview_advertise removeFromSuperview];
}

// 导航栏
- (void)customNavigation {
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, 44)];
    self.navigationItem.titleView = view;
    
    // 福利按钮
    UIButton *fuliBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,viewWidth/3+20, 44)];
    fuliBtn.layer.cornerRadius = 22;
    fuliBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [fuliBtn setTitle:@"福利秀" forState:UIControlStateNormal];
//    [fuliBtn setBackgroundImage:[UIImage imageNamed:@"headview_bgview"] forState:UIControlStateNormal];
    [fuliBtn setTitleColor:RGBCOLOR(221, 161, 13) forState:UIControlStateNormal];
    [view addSubview:fuliBtn];
    [fuliBtn addTarget:self action:@selector(wellShow) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(gotoSearch)];
    rightItem.tintColor = RGBCOLOR(221, 161, 13);
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"就业季·2016" style:UIBarButtonItemStylePlain target:self action:@selector(gotoJobShow)];
    leftItem.tintColor = RGBCOLOR(221, 161, 13);
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)gotoJobShow {
    
    JobsTableViewController *ctr = [JobsTableViewController new];
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)defaultHeaderviewParagms {
    // 热门分类
    [self drawHeaderViewWithTitle:@"热门分类" andOrigionY:0];
    // 便民家政
    [self drawHeaderViewWithTitle:@"便民家政" andOrigionY:4*viewHeight];
    // 美食
    [self drawHeaderViewWithTitle:@"美食" andOrigionY:6*viewHeight];
    // 汽车服务
    [self drawHeaderViewWithTitle:@"汽车服务" andOrigionY:8*viewHeight];
    // 酒店
    [self drawHeaderViewWithTitle:@"酒店" andOrigionY:10*viewHeight];
    // 美容美体
    [self drawHeaderViewWithTitle:@"美容美体" andOrigionY:13*viewHeight];
    // 生活购物
    [self drawHeaderViewWithTitle:@"健康与花店" andOrigionY:15*viewHeight];
    // 保险
    [self drawHeaderViewWithTitle:@"金融/法律" andOrigionY:17*viewHeight];

}

- (void)initAllLabels {
    // 热门分类
    NSArray *hotCategory = @[@"KTV",@"快餐小炒",@"火锅",@"休闲娱乐",@"快递/托运",@"培训教育",@"搬家",@"婚庆摄影",@"银行"];
    // 便民家政
    NSArray *hotCategory2 = @[@"搬家/保洁",@"洗衣/开锁",@"家电维修"];
    // 美食
    NSArray *hotCategory3 = @[@"快餐小炒",@"火锅",@"蛋糕甜点"];
    // 汽车服务
    NSArray *hotCategory4 = @[@"汽车服务",@"代驾",@""];
    // 酒店
    NSArray *hotCategory5 = @[@"酒店",@"宾馆",@"金狮路宾馆",@"农家乐",@"山庄",@"旅行社"];
    // 美容美体
    NSArray *hotCategory6 = @[@"美发",@"美容美体",@""];
    // 生活购物
    NSArray *hotCategory7 = @[@"药店",@"花店",@"医院通"];
    // 保险
    NSArray *hotCategory8 = @[@"保险",@"银行",@"法律咨询"];
    NSArray *contentArr = @[hotCategory,hotCategory2,hotCategory3,
                            hotCategory4,hotCategory5,hotCategory6,
                            hotCategory7,hotCategory8];
    [self drawAllLabelsOnScrollviewWithArrary:contentArr];

}

// 滚动效果
- (void)initScrollview {
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, self.view.frame.size.height)];
    [self.view addSubview:_scrollview];
    _scrollview.alwaysBounceVertical = YES;
    _scrollview.delegate = self;
    _scrollview.contentSize = CGSizeMake(viewWidth, 900);
    _scrollview.showsVerticalScrollIndicator = NO;
}

// 标题栏
- (void)drawHeaderViewWithTitle:(NSString *)title andOrigionY:(int)origionY {
   
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, origionY, viewWidth, viewHeight)];
    headerView.backgroundColor = RGBCOLOR(214, 214, 214);
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"headview_bgview"]];
    imageview.frame = CGRectMake(0, 0, viewWidth, viewHeight);
    [headerView addSubview:imageview];
    
    [_scrollview addSubview:headerView];
    
    UILabel *titleLab = [[UILabel alloc] init];
//    titleLab.backgroundColor = headerView.backgroundColor;
    titleLab.frame = CGRectMake(20, 0, 150, viewHeight);
    titleLab.text = title;
    titleLab.textColor = RGBCOLOR(72, 72, 77);
    titleLab.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:titleLab];
}

// 初始化UILabel
- (void)drawAllLabelsOnScrollviewWithArrary:(NSArray *)contentArr {
    NSArray *arr ;
    CGFloat  origionY = viewHeight;
    
    for (int i = 0; i < contentArr.count; i++)
    {
        arr = contentArr[i];
        
        for (int j = 0; j < arr.count; j++)
        {
            // 热门分类 9个
            if (0 == i)
            {
                if (j==0||j==1||j==2) {
                    origionY = viewHeight;
                }else if (j==3||j==4||j==5) {
                    origionY = 2*viewHeight;
                }else if (j==6||j==7||j==8) {
                    origionY = 3*viewHeight;
                }
                [self addButtonOnScrollviewWithOrigionY:origionY title:arr[j] vierizeI:i horizeJ:j];            }
            // 便民家政 3个
            if (i == 1)
            {
                if (j==0||j==1||j==2) {
                    origionY = 5*viewHeight;
                }
                [self addButtonOnScrollviewWithOrigionY:origionY title:arr[j] vierizeI:i horizeJ:j];//
            }
            // 美食 3个
            if (i ==2) {
                if (j==0||j==1||j==2) {
                    origionY = 7*viewHeight;
                }
                [self addButtonOnScrollviewWithOrigionY:origionY title:arr[j] vierizeI:i horizeJ:j];//
            }
            //  汽车服务 3个
            if (i ==3) {
                if (j==0||j==1||j==2) {
                    origionY = 9*viewHeight;
                }                [self addButtonOnScrollviewWithOrigionY:origionY title:arr[j] vierizeI:i horizeJ:j];//
            }
            // 酒店 6个
            if (i ==4) {
                if (j==0||j==1||j==2) {
                    origionY = 11*viewHeight;
                }else if (j==3||j==4||j==5) {
                    origionY = 12*viewHeight;
                }
                [self addButtonOnScrollviewWithOrigionY:origionY title:arr[j] vierizeI:i horizeJ:j];//
            }
            // 美容美体 3个
            if (i ==5) {
                if (j==0||j==1||j==2) {
                    origionY = 14*viewHeight;
                }
                [self addButtonOnScrollviewWithOrigionY:origionY title:arr[j] vierizeI:i horizeJ:j];//
            }
            // 生活购物 3个
            if (i ==6) {
                if (j==0||j==1||j==2) {
                    origionY = 16*viewHeight;
                }
                [self addButtonOnScrollviewWithOrigionY:origionY title:arr[j] vierizeI:i horizeJ:j];//
            }
            // 保险 3个
            if (i ==7) {
                if (j==0||j==1||j==2) {
                    origionY = 18*viewHeight;
                }
                [self addButtonOnScrollviewWithOrigionY:origionY title:arr[j] vierizeI:i horizeJ:j];
                
            }
            
        }
        
    }
    
}

- (void)addButtonOnScrollviewWithOrigionY:(int)origionY
                                    title:(NSString *)btnTitle
                                 vierizeI:(int)i
                                  horizeJ:(int)j
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_scrollview addSubview:btn];
    btn.frame = CGRectMake(j%3*viewWidth/3 , origionY, viewWidth/3, viewHeight);
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:RGBCOLOR(72, 72, 77) forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"bgview-btn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtnTag:) forControlEvents:UIControlEventTouchUpInside];
    switch (i) {
        case 0: // 热门分类
            btn.tag = j;
            break;
        case 1: // 便民家政
            btn.tag = 6+3+j;
            break;
        case 2: // 美食
            btn.tag = 2*6+j;
            break;
        case 3: // 汽车服务
            btn.tag = 2*6+3+j;
            break;
        case 4: // 酒店
            btn.tag = 3*6+j;
            break;
        case 5: // 美容美体
            btn.tag = 4*6+j;
            break;
        case 6: // 生活购物
            btn.tag = 4*6+3+j;
            break;
        case 7: // 保险
            btn.tag = 5*6+j;
            break;
            
        default:
            break;
    }
}

#pragma mark - 导航栏事件
// 福利秀
- (void)wellShow {
    NSLog(@"fulishow");
    FuliShowViewController *fuliVC = [FuliShowViewController new];
    [self.navigationController pushViewController:fuliVC animated:YES];
}

// 百事通
- (void)gotoBstVC {
    NSLog(@"gotoBstVC");
    
}

// 搜索
- (void)gotoSearch {
    NSLog(@"gotoSearch");
    SearchViewController *searchCtr = [SearchViewController new];
    [self.navigationController pushViewController:searchCtr animated:YES];
}

#pragma mark - 按钮事件
// 点击按钮事件
- (void)clickBtnTag:(UIButton *)sender {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"businessMessage" ofType:@"plist"];
    NSArray *businessArr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    NSArray *detailArr = businessArr[sender.tag];
    NSLog(@"=========%@",detailArr);
    DetailViewController *contr = [DetailViewController new];
    contr.detailArray = detailArr;
    contr.naviTitle = sender.titleLabel.text;
    [self.navigationController pushViewController:contr animated:YES];
    NSLog(@"%@",sender.titleLabel.text);
    
    [MobClick event:@"buttonCategory" attributes:@{@"buttonTitle":[NSString stringWithFormat:@"%@",sender.titleLabel.text]}];
   
}

- (void)netWorkChanged:(NSNotification *)notification {
    RealReachability *reachability = (RealReachability *)notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    NSLog(@"currentStatus:%@",@(status));
    if (status == RealStatusNotReachable)
    {
        [SVProgressHUD showWithStatus:@"网络不可用！"];
    }
    
    if (status == RealStatusViaWiFi)
    {
        [SVProgressHUD showWithStatus: @"wifi连接了哦~"];
        
    }
    
    if (status == RealStatusViaWWAN)
    {
        [SVProgressHUD showWithStatus:@"手机网络哦~"];
    }
    
    WWANAccessType accessType = [GLobalRealReachability currentWWANtype];
    
    if (status == RealStatusViaWWAN)
    {
        if (accessType == WWANType2G)
        {
            [SVProgressHUD showWithStatus:@"您使用的是2G"];
        }
        else if (accessType == WWANType3G)
        {
            [SVProgressHUD showWithStatus:@"您使用的是3G"];
        }
        else if (accessType == WWANType4G)
        {
            [SVProgressHUD showWithStatus:@"您使用的是4G"];
        }
        else
        {
            [SVProgressHUD showWithStatus:@"Unknown RealReachability WWAN Status, might be iOS6"];
        }
    }
    // 延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
