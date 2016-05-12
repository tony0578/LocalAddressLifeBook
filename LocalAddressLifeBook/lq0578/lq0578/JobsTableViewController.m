//
//  JobsTableViewController.m
//  lq0578
//
//  Created by 汤维炜 on 16/2/26.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import "JobsTableViewController.h"
#import "JobsCell.h"
#import "CallmeViewController.h"
#import "SDCycleScrollView.h"
#import "TAPageControl.h"

#import "PostCell.h"
#import "postData.h"

#import "NativeWebview.h"

#define viewwidth self.view.frame.size.width
#define viewheight self.view.frame.size.height

@interface JobsTableViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UITableView       *tableview;
@property (nonatomic, strong) UIView            *tips;
@property (nonatomic, strong) UILabel           *tipLabel;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollview;
@property (nonatomic, strong) UICollectionView  *collectionview;
@property (nonatomic, strong) UIView            *headview;
@property (nonatomic, strong) NSArray           *postArr;
@end

static NSString *identifier = @"mycell";

@implementation JobsTableViewController

- (NSArray *)postArr
{
    if (!_postArr) {
        self.postArr = [postData defaultPostInfo];
    }

    return _postArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initNavigationUI];
    [self configureHeadviewUI];
    [self drawScrollviewUI];
    
    [self configureCollectionViewUI];
    [self drawTableviewUI];
    [self drawAdvertiseTips];
}

- (void)initNavigationUI {
   
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.navigationItem.titleView = titleView;
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    title.text = @"就业秀·2016";
    title.textColor = [UIColor lightGrayColor];
    [titleView addSubview:title];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    leftItem.tintColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor orangeColor];
}

- (void)configureHeadviewUI {
    self.headview = [[UIView alloc] init];
    _headview.backgroundColor = [UIColor whiteColor];
    self.headview.frame = CGRectMake(0, 0, viewwidth, 180+(viewwidth-11)/4*2+10+30);
    [self.view addSubview:self.headview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [_tips setHidden:NO];
    [self scrollAdvertiseWithLabel:_tipLabel];
    [_tableview setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillDisappear:animated];
    [_tips setHidden:YES];
    [_tableview setHidden:YES];
}

- (void)dismiss {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)drawScrollviewUI {

    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 情景三：图片配文字
    NSArray *titles = @[
                        @"感谢您的支持，小龙泉小黄页",
                        @"如有任何问题联系278076337@qq.com",
                        @"您可以发邮件到278076337@qq.com",
                        @"感谢您的支持"
                        ];
    
    //网络加载 --- 创建带标题的图片轮播器
    CGFloat w = self.view.bounds.size.width;
    _cycleScrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 30, w, 180) imageNamesGroup:nil];
    
    _cycleScrollview.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollview.delegate = self;
    _cycleScrollview.titlesGroup = titles;
    
    _cycleScrollview.pageDotColor = [UIColor lightGrayColor]; // 自定义分页控件小圆标颜色
    
    _cycleScrollview.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.headview addSubview:_cycleScrollview];
    
    if (imagesURLStrings.count>1) {
        _cycleScrollview.autoScrollTimeInterval = 2.3f;
    }else if (imagesURLStrings.count==1){
        _cycleScrollview.autoScrollTimeInterval =100.f;
    }
    //             --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _cycleScrollview.imageURLStringsGroup = imagesURLStrings;
    });

}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}


// 广告
- (void)drawAdvertiseTips {

    _tips = [[UIView alloc]init];
    _tips.backgroundColor = [UIColor blackColor];
    _tips.alpha = 0.5;
    _tips.frame = CGRectMake(0, 64, viewwidth, 30);
    [self.view addSubview:_tips];
    
    _tipLabel = [[UILabel alloc] init];
    _tipLabel.frame = CGRectMake(0, 5, viewwidth, 25);
    _tipLabel.text = @"免费发布就业信息。点击进入！";
    _tipLabel.textColor = [UIColor redColor];
    _tipLabel.font = [UIFont systemFontOfSize:13];
    [_tips addSubview:_tipLabel];
    [self scrollAdvertiseWithLabel:_tipLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoCallmeVC)];
    [_tips addGestureRecognizer:tap];
}

- (void)scrollAdvertiseWithLabel:(UILabel *)adsLabel {
    [adsLabel sizeToFit];
    CGRect rect    = adsLabel.frame;
    rect.origin.x  = adsLabel.frame.size.width;
    adsLabel.frame = rect;
    
    [UIView beginAnimations:@"testanimatioin" context:nil];
    [UIView setAnimationDuration:8.6f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationRepeatCount:9999];
    
    rect = adsLabel.frame;
    rect.origin.x  = -rect.size.width;
    adsLabel.frame = rect;
    
    [UIView commitAnimations];
}

- (void)gotoCallmeVC {
    
    CallmeViewController *ctr = [CallmeViewController new];
    [self.navigationController pushViewController:ctr animated:NO];
}

- (void)configureCollectionViewUI {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake((viewwidth-11-28)/4, (viewwidth-11-28)/4);
    layout.minimumLineSpacing      = 5;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(11, 10, 11, 10);
    
    self.collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 180+30, viewwidth, self.headview.frame.size.height-180-30) collectionViewLayout:layout];
    self.collectionview.backgroundColor = [UIColor whiteColor];
    self.collectionview.dataSource   = self;
    self.collectionview.delegate     = self;
    self.collectionview.showsHorizontalScrollIndicator = NO;
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.pagingEnabled = NO;
    [self.headview addSubview:self.collectionview];
    [self.collectionview registerClass:[PostCell class] forCellWithReuseIdentifier:identifier];
}

#pragma mark - UICollectioviewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.postArr.count;
}

#pragma mark - UICollectioviewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    postData *data = self.postArr[indexPath.row];
    
    NSDictionary *dic = @{@"icon":data.icon,@"title":data.title};
    
    [cell cellWithInfo:dic];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NativeWebview *webview = [NativeWebview new];
    postData *data = self.postArr[indexPath.row];
    webview.url = data.url;
    webview.title = data.title;
    
    [self.navigationController pushViewController:webview animated:NO];
}

- (void)drawTableviewUI {
    _tableview = [[UITableView alloc] init];
    _tableview.frame = CGRectMake(0, 0, viewwidth, viewheight);
    _tableview.dataSource = self;
    _tableview.delegate   = self;
    _tableview.tableHeaderView = self.headview;
    [self.view addSubview:_tableview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

#pragma mark -UITableviewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"mycell";
    JobsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"JobsCell" owner:nil options:nil]lastObject];
    }
    cell.carrerLab.text = @"淘宝店长";
    cell.salaryLab.text = @"工资：面议";
    cell.sendtimeLab.text = @"发布时间：2016-10-16";
    cell.companyLab.text = @"浙江四西未来科技有限公司";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 88;
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
