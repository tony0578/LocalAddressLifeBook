//
//  FuliShowViewController.m
//  lq0578
//
//  Created by 汤维炜 on 16/2/13.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import "FuliShowViewController.h"
#import "DetailViewController.h"
#import "FuliCell.h"
#import "CommonFuliControl/CommonFuliViewController.h"
#import "MobClick.h"

#define viewWidth self.view.frame.size.width

@interface FuliShowViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *fuliArr;
@property (nonatomic, strong) NSString *phonenum;
@end

@implementation FuliShowViewController

- (NSString *)phonenum
{
    if (!_phonenum) {
        self.phonenum = [[NSString alloc]init];
    }
    return _phonenum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initcustomNavigationUI];
    [self drawTableview];
    [self addBackTopView];
    [self defaultCellData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
   
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillDisappear:animated];
    
}

- (void)initcustomNavigationUI {
   
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    self.navigationItem.titleView = titleView;
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 130, 44)];
    title.text = @"搭西能都有福利";
    title.textColor = [UIColor lightGrayColor];
    [titleView addSubview:title];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    leftItem.tintColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor orangeColor];
    
}
#pragma mark - uitableviewDatasource
- (void)drawTableview {
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, self.view.frame.size.height)];
    [self.view addSubview:_tableview];
    _tableview.dataSource = self;
    _tableview.delegate = self;
}

- (void)defaultCellData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fuliDetail" ofType:@"plist"];
   _fuliArr = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"%@",_fuliArr);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _fuliArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"myCell";
    FuliCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FuliCell" owner:nil options:nil]lastObject];
    }
    NSString *imagename = _fuliArr[indexPath.row][@"imageurl"];
    NSString *price = _fuliArr[indexPath.row][@"origionalPrice"];
    _phonenum = _fuliArr[indexPath.row][@"phoneNumber"];
    NSString *detailmes = _fuliArr[indexPath.row][@"detailMessage"];

    
    cell.desLabel.text = detailmes;
    cell.fuliImageview.image = [UIImage imageNamed:imagename];
    cell.currentPriceLabel.text = price;
    
    [cell.callBtn addTarget:self action:@selector(callBusiness) forControlEvents:UIControlEventTouchUpInside];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)callBusiness {
    NSString *phoneNumber = _phonenum;
    NSString *callNum = [NSString stringWithFormat:@"telprompt://%@",phoneNumber];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:callNum]];
}

- (void)dismiss {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 316;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommonFuliViewController *control = [CommonFuliViewController new];
    [self.navigationController pushViewController:control animated:YES];
    
    [MobClick event:@"activity" attributes:@{@"fuliCategory":[NSString stringWithFormat:@"%ld",indexPath.item]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addBackTopView {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(self.view.frame.size.width-50, self.view.frame.size.height-88, 40, 40);
    backBtn.layer.cornerRadius = 20;
    [backBtn setBackgroundImage:[UIImage imageNamed:@"v2_back_top"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}
- (void)backTop {
    [_tableview setContentOffset:CGPointMake(0, -64) animated:YES];
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
