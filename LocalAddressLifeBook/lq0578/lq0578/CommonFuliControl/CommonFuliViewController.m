//
//  CommonFuliViewController.m
//  lq0578
//
//  Created by 汤维炜 on 16/3/2.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import "CommonFuliViewController.h"

#define viewWidth  self.view.frame.size.width
#define h          self.view.frame.size.height

static CGFloat viewHeight = 44.0;

@interface CommonFuliViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)   UIScrollView *scrollview;
@property (nonatomic, strong) UIView *produceView;
@property (nonatomic, strong) UIView *serviceView;
@property (nonatomic, strong) UIView *detailView;

@end

@implementation CommonFuliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self defaultNavigationUI];
    [self initScrollview];
    [self drawDescriptUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:NO];
}

- (void)defaultNavigationUI {

    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.title = @"详情介绍";
    self.navigationItem.titleView.tintColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor orangeColor];
}

- (void)dismiss {
    
    [self.navigationController popViewControllerAnimated:YES];
}


// 滚动效果
- (void)initScrollview {
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, viewWidth, self.view.frame.size.height)];
    [self.view addSubview:_scrollview];
    _scrollview.alwaysBounceVertical = YES;
    _scrollview.delegate = self;
    _scrollview.contentSize = CGSizeMake(viewWidth, 1320);
    _scrollview.showsVerticalScrollIndicator = NO;
}

- (void)drawDescriptUI {
    NSArray *segmentArr = @[@"商品介绍",@"规格参数",@"包装售后"];
    UISegmentedControl *segementCtr = [[UISegmentedControl alloc]initWithItems:segmentArr];
    
    segementCtr.backgroundColor = [UIColor whiteColor];
    segementCtr.frame = CGRectMake(0, 64, viewWidth, 40);
    [self drawProduceIntroduce];
    [segementCtr addTarget:self action:@selector(changeSegementValue:) forControlEvents:UIControlEventValueChanged];
    segementCtr.selectedSegmentIndex = 0;
    
    [self.view addSubview:segementCtr];
    
}

- (void)changeSegementValue:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self drawProduceIntroduce];
            break;
        case 1:
            [self drawProduceDetailParams];
            break;
        case 2:
            [self drawAfterService];
            break;
            
        default:
            break;
    }
    
}

// 商品介绍
- (void)drawProduceIntroduce {
    
    _produceView.hidden = NO;
    _detailView.hidden = YES;
    _serviceView.hidden = YES;
    
    _produceView = [[UIView alloc] init];
    _produceView.frame = CGRectMake(0, 0, viewWidth, 1900);
    [_scrollview addSubview:_produceView];
    _produceView.backgroundColor = [UIColor whiteColor];
    
    // 图一
    _imageview = [[UIImageView alloc] init];
    _imageview.frame = CGRectMake(0, 40+64, 320, 200);
    
    CGPoint center = CGPointMake(self.view.center.x,40+100);
    _imageview.center = center;
    _imageview.image = [UIImage imageNamed:@"datangChina5"];
    [_imageview sizeToFit];
    [_produceView addSubview:_imageview];
    
    // 图二
    _imageview2  = [[UIImageView alloc] init];
    _imageview2.frame = CGRectMake(0, 40+64+200+140, 320, 200);
    
    CGPoint center2 = CGPointMake(self.view.center.x,300+180);
    _imageview2.center = center2;
    _imageview2.image = [UIImage imageNamed:@"datangChina"];
    [_imageview2 sizeToFit];
    [_produceView addSubview:_imageview2];
    
    // 图三
    _imageview3 = [[UIImageView alloc] init];
    _imageview3.frame = CGRectMake(0, 40+64+200+140, 320, 200);
    
    CGPoint center3 = CGPointMake(self.view.center.x,300+142+230);
    _imageview3.center = center3;
    _imageview3.image = [UIImage imageNamed:@"datangChina1"];
    [_imageview3 sizeToFit];
    [_produceView addSubview:_imageview3];
    
    // 图四
    _imageview4 = [[UIImageView alloc] init];
    _imageview4.frame = CGRectMake(0, 40+64+200+140, 320, 200);
    
    CGPoint center4 = CGPointMake(self.view.center.x,300+142+230+330);
    _imageview4.center = center4;
    _imageview4.image = [UIImage imageNamed:@"datangChina6"];
    [_imageview4 sizeToFit];
    [_produceView addSubview:_imageview4];
    
}

// 规格参数
- (void)drawProduceDetailParams {
    
    _produceView.hidden = YES;
    _detailView.hidden = NO;
    _serviceView.hidden = YES;
    
    _detailView = [[UIView alloc] init];
    _detailView.frame = CGRectMake(0, 0, viewWidth, 700);
    [_scrollview addSubview:_detailView];
    _detailView.backgroundColor = [UIColor whiteColor];
    
    // 产品名称
    _produceNameLab = [[UILabel alloc] init];
    _produceNameLab.backgroundColor = [UIColor lightGrayColor];
    _produceNameLab.frame = CGRectMake(0, 40, viewWidth/3, 25);
    _produceNameLab.text = @"产品名称";
    [_detailView addSubview:_produceNameLab];
    
    _produceNameLab_detail = [[UILabel alloc] init];
    _produceNameLab_detail.backgroundColor = [UIColor lightGrayColor];
    _produceNameLab_detail.frame = CGRectMake( viewWidth/3+1, 40, viewWidth/3*2, 25);
    _produceNameLab_detail.text = @"龙泉青瓷";
    [_detailView addSubview:_produceNameLab_detail];
    
    // 产品型号
    _produceModelLab = [[UILabel alloc] init];
    _produceModelLab.backgroundColor = [UIColor lightGrayColor];
    _produceModelLab.frame = CGRectMake(0, 66, viewWidth/3, 25);
    _produceModelLab.text = @"产品型号";
    [_detailView addSubview:_produceModelLab];
    
    _produceModelLab_detail = [[UILabel alloc] init];
    _produceModelLab_detail.backgroundColor = [UIColor lightGrayColor];
    _produceModelLab_detail.frame = CGRectMake( viewWidth/3+1, 66, viewWidth/3*2, 25);
    _produceModelLab_detail.text = @"MM007";
    [_detailView addSubview:_produceModelLab_detail];
    
    
    // 产品重量
    _produceWeightLab = [[UILabel alloc] init];
    _produceWeightLab.backgroundColor = [UIColor lightGrayColor];
    _produceWeightLab.frame = CGRectMake(0, 92, viewWidth/3, 25);
    _produceWeightLab.text = @"产品重量";
    [_detailView addSubview:_produceWeightLab];
    
    _produceWeightLab_detail = [[UILabel alloc] init];
    _produceWeightLab_detail.backgroundColor = [UIColor lightGrayColor];
    _produceWeightLab_detail.frame = CGRectMake( viewWidth/3+1, 92, viewWidth/3*2, 25);
    _produceWeightLab_detail.text = @"0.66Kg";
    [_detailView addSubview:_produceWeightLab_detail];
    
}

// 包装售后
- (void)drawAfterService {
    
    _produceView.hidden = YES;
    _detailView.hidden = YES;
    _serviceView.hidden = NO;
    
    _serviceView = [[UIView alloc] init];
    _serviceView.frame = CGRectMake(0, 0, viewWidth, 700);
    [_scrollview addSubview:_serviceView];
    _serviceView.backgroundColor = [UIColor whiteColor];

    UILabel *saledLab = [[UILabel alloc] init];
    saledLab.frame = CGRectMake(22, 64, viewWidth-44, 300);
    saledLab.text = @"严格按照国家电子商务规定的物品售后规定，执行商品的售后服务内容。我们也真诚希望客户给予反馈意见，共同完善产品，为您提供更好地服务。";
    saledLab.textAlignment = NSTextAlignmentCenter;
    saledLab.numberOfLines = 0;
    saledLab.textColor = [UIColor lightGrayColor];
    [saledLab sizeToFit];
    [_serviceView addSubview:saledLab];
    
    _callLab = [[UILabel alloc] init];
    _callLab.frame = CGRectMake(0, 320, viewWidth, 50);
    _callLab.text = @"联系方式：888888888";
    _callLab.textColor = [UIColor orangeColor];
    _callLab.textAlignment = NSTextAlignmentCenter;
    [_serviceView addSubview:_callLab];
    
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
