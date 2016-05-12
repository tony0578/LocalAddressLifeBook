//
//  WelcomeViewController.m
//  lq0578
//
//  Created by 汤维炜 on 16/2/28.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import "WelcomeViewController.h"
#import "MobClick.h"

#define viewwidth self.view.frame.size.width
#define viewheight self.view.frame.size.height

@interface WelcomeViewController ()

@property (nonatomic, assign)  int buttonTime;
@property (nonatomic, strong) NSTimer *updateTimer;
@property (nonatomic, strong) UIButton *jumpBtn;

@end

static int btntime = 4;

@implementation WelcomeViewController

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"FirstTimeRunningApp"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawButtonOnView];
    [[NSUserDefaults standardUserDefaults] setObject:@"firstTimeRunning" forKey:@"KFirstTimeRunning"];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bgImageview = [[UIImageView alloc] init];
    bgImageview.frame = CGRectMake(0, 0, 320, 224);
    bgImageview.center = self.view.center;
    [bgImageview setImage:[UIImage imageNamed:@"lslq"]];
    bgImageview.userInteractionEnabled = YES;
    [self.view addSubview:bgImageview];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeUI)];
    [bgImageview addGestureRecognizer:tap];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.updateTimer invalidate];
    self.updateTimer = nil;
}

- (void)reduceTime {
    
    if (btntime > 0) {
        btntime -= 1;
        [_jumpBtn setTitle:[NSString stringWithFormat:@"跳过%ds",btntime] forState:UIControlStateNormal];
       
    }else if (btntime == 0) {
        
        [self closeUI];
    }
    
}

- (void)drawButtonOnView {
    
    _jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _jumpBtn.frame = CGRectMake(viewwidth - 86, 60, 66, 30);
    _jumpBtn.backgroundColor = [UIColor orangeColor];
    _jumpBtn.layer.cornerRadius = 15;
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(reduceTime) userInfo:nil repeats:YES];
    [self.updateTimer fire];
    
    _jumpBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [_jumpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_jumpBtn addTarget:self action:@selector(closeUI) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_jumpBtn];
    
}

- (void)closeUI {

    if ([self.delegate respondsToSelector:@selector(closeWelcomeGuiderUI)]) {
        [self.delegate closeWelcomeGuiderUI];
    }
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
