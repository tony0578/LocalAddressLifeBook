//
//  DetailViewController.m
//  lq0578
//
//  Created by 汤维炜 on 16/2/17.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCell.h"
#define viewWidth  self.view.frame.size.width

@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIScrollView *scrollview;
@end

@implementation DetailViewController

- (NSArray *)detailArray
{
    if (!_detailArray) {
        self.detailArray = [NSArray array];
    }
    return _detailArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initScrollview];
    [self initcustomNavigationUI];
    [self drawTableviewUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [super viewWillDisappear:animated];
    
}

// 导航栏
- (void)initcustomNavigationUI {
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.title = self.naviTitle;
    self.navigationItem.titleView.tintColor = [UIColor orangeColor];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor orangeColor];
}

// 滚动效果
- (void)initScrollview {
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, self.view.frame.size.height)];
    [self.view addSubview:_scrollview];
    _scrollview.alwaysBounceVertical = YES;
    _scrollview.delegate = self;
    _scrollview.contentSize = CGSizeMake(viewWidth, 1600);
    _scrollview.showsVerticalScrollIndicator = NO;
}

- (void)dismiss {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)drawTableviewUI {
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, viewWidth, self.view.frame.size.height-64)];
    [self.view addSubview:_tableview];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.detailArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Cell";
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:nil options:nil] lastObject];
    }
   
    NSString *phoneNum;
    NSString *businessName;
    NSString *address;
    if (indexPath.row < self.detailArray.count) {
        if (self.detailArray[indexPath.row][@"phoneNumber"]!=nil) {
            phoneNum =  self.detailArray[indexPath.row][@"phoneNumber"];
            businessName = self.detailArray[indexPath.item][@"businessName"];
            address = self.detailArray[indexPath.item][@"adress"];
        }
    }
    
    // cell 赋值电话号码
    cell.phoneNum = phoneNum;
    
    // cell 详细信息
    [cell setCellBusiness:businessName phoneNum:phoneNum addressString:address];
    
    // cell 选中状态
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

//- (void)callAction{
//    NSString *number = @"18768196642";// 此处读入电话号码
//    // NSString *num = [[NSString alloc]initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法结束电话之后会进入联系人列表
//    
//    NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框 是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 93;
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
