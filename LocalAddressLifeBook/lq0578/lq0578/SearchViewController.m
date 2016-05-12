//
//  SearchViewController.m
//  lq0578
//
//  Created by 汤维炜 on 16/2/13.
//  Copyright © 2016年 汤维炜. All rights reserved.
//

#import "SearchViewController.h"
#import "DetailCell.h"
#import "MobClick.h"

#define viewWidth self.view.frame.size.width

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *filterData;
    NSArray *phoneNumberData;
    NSArray *imageurlsData;
    UISearchDisplayController *_searchDisplayController;
}
@property (nonatomic, strong) UITableView *tableview;
// 地址
@property (nonatomic, strong) NSArray *addressData;
//电话
@property (nonatomic, strong) NSArray *phonenumData;
//图片
@property (nonatomic, strong) NSArray *businessData;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawTableview];
    [self initcustomNavigationUI];
    [self defaultData];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
//    
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [self.navigationController setNavigationBarHidden:YES];
//    [super viewWillDisappear:animated];
//    
//}

// 获取数据 赋值给数组
- (void)defaultData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"businessMessage" ofType:@"plist"];
    NSArray *paramsArr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *allObjects = [[NSMutableArray alloc]init];

    for (int i=0; i<paramsArr.count; i++) {
        [allObjects addObjectsFromArray:paramsArr[i]];
    }
    
    __block NSMutableArray *allAddress;
    __block NSMutableArray *allBusiness;
    __block NSMutableArray *allPhonenum;
    allAddress = [[NSMutableArray alloc]init];
    allBusiness = [[NSMutableArray alloc]init];
    allPhonenum = [[NSMutableArray alloc]init];
    
    [allObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 获取地址
        NSString *addressString = obj[@"adress"];
        [allAddress addObject:addressString];
        // 获取图片
        NSString *business = obj[@"businessName"];
        [allBusiness addObject:business];
        // 获取描述
        NSString *phonenums = obj[@"phoneNumber"];
        [allPhonenum addObject:phonenums];
        
        if (idx > allObjects.count)
        {
            *stop = YES;
        }
    }];

    self.addressData = [allAddress copy];
    self.businessData = [allBusiness copy];
    self.phonenumData = [allPhonenum copy];    
}

- (void)initcustomNavigationUI {

    self.navigationController.navigationBarHidden = YES;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(8, 66, 44, 44);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor greenColor];
    backBtn.layer.cornerRadius = 22;
    [backBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];

}
#pragma mark - uitableviewDatasource
- (void)drawTableview {
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, viewWidth, 44)];
    searchBar.placeholder = @"搜索";
    searchBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:searchBar];
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, viewWidth, self.view.frame.size.height-64)];
    [self.view addSubview:_tableview];
    _tableview.dataSource = self;
    _tableview.delegate = self;
    
    _searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    
    // searchResultsDataSource 就是 UITableViewDataSource
    _searchDisplayController.searchResultsDataSource = self;
    // searchResultsDelegate 就是 UITableViewDelegate
    _searchDisplayController.searchResultsDelegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.tableview) {
        return self.addressData.count;
        
    }else{
        // 谓词搜索
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",_searchDisplayController.searchBar.text];
        filterData =  [[NSArray alloc] initWithArray:[self.businessData filteredArrayUsingPredicate:predicate]];
        
        [MobClick event:@"HotSearching" attributes:@{@"words":[NSString stringWithFormat:@"%@", _searchDisplayController.searchBar.text]}];
        
        return filterData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"Cell";
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DetailCell" owner:nil options:nil]lastObject];
    }
    
    if (tableView == self.tableview) {
        cell.phoneNum = _phonenumData[indexPath.row];
        // 获取business
        NSString *business = self.businessData[indexPath.row];
        // 地址
        NSString *address = self.addressData[indexPath.row];
        // 电话
        NSString *phonenum = _phonenumData[indexPath.row];
        
        [cell setCellBusiness:business phoneNum:phonenum addressString:address];
    }else{
        // 谓词搜索
        NSString *address = filterData[indexPath.row];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"businessMessage" ofType:@"plist"];
        NSArray *paramsArr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *allObjects = [[NSMutableArray alloc]init];
        NSMutableArray *tagNumber = [[NSMutableArray alloc] init];
        for (int i=0; i<paramsArr.count; i++) {
            [allObjects addObjectsFromArray:paramsArr[i]];
        }
        // 获取所有相关下标
        for (int i=0; i<allObjects.count; i++) {
            if ([allObjects[i][@"businessName"] isEqualToString:address]) {
                [tagNumber addObject:[NSString stringWithFormat:@"%d",i]];
            }
        }
        // 获取商户名字和电话 地址
        NSMutableArray *businessArr = [[NSMutableArray alloc]init];
        NSMutableArray *phoneNumArr = [[NSMutableArray alloc]init];
        NSMutableArray *addressArr = [[NSMutableArray alloc]init];
        NSString *business;
        NSString *phonenum;
        NSString *addressStr;
        for (int j=0; j<tagNumber.count; j++) {
            int indexValue = [tagNumber[j] intValue];
            [businessArr addObject:self.businessData[indexValue]];
            [phoneNumArr addObject:self.phonenumData[indexValue]];
            [addressArr  addObject:self.addressData[indexValue]];
            
            business = self.businessData[indexValue];
            phonenum = self.phonenumData[indexValue];
            addressStr = self.addressData[indexValue];
        }
        
        cell.phoneNum = phonenum;
        [cell setCellBusiness:business phoneNum:phonenum addressString:addressStr];
    }
    
    return cell;
}


- (void)dismiss {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 128;
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
