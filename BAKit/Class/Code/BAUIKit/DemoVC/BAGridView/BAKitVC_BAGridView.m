//
//  BAKitVC_BAGridView.m
//  BAKit
//
//  Created by boai on 2017/6/12.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_BAGridView.h"

#import "BAKit_BAGridView.h"
#import "BAKit_Color.h"

static NSString * const kCellID = @"BAKitVC_BAGridViewCell";

#define kGridView_rowCount   4
#define kGridView_itemHeight 100
#define kGridView_H          BAKit_getColumnCountWithArrayAndRowCount(self.gridDataArray, kGridView_rowCount) * kGridView_itemHeight

#define kGridView_rowCount2   2
#define kGridView_itemHeight2 80
#define kGridView_H2          BAKit_getColumnCountWithArrayAndRowCount(self.gridDataArray2, kGridView_rowCount2) * kGridView_itemHeight2

@interface BAKitVC_BAGridView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;

@property(nonatomic, strong) UIViewController *vc1;
@property(nonatomic, strong) UIViewController *vc2;

@property(nonatomic, strong) BAGridView *gridView;
@property(nonatomic, strong) BAGridView *gridView2;

@property(nonatomic, strong) NSMutableArray  <BAGridItemModel *> *gridDataArray;
@property(nonatomic, strong) NSMutableArray  <BAGridItemModel *> *gridDataArray2;


@end

@implementation BAKitVC_BAGridView


- (void)ba_base_viewWillAppear
{
    NSLog(@"BAKitVC_BAGridView：%s", __func__);
}

- (void)ba_base_viewDidDAppear
{
    NSLog(@"BAKitVC_BAGridView：%s", __func__);
}

- (void)ba_base_viewWillDisappear
{
    NSLog(@"BAKitVC_BAGridView：%s", __func__);
}

- (void)ba_base_viewDidDisappear
{
    NSLog(@"BAKitVC_BAGridView：%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)ba_base_setupUI
{
    self.title = @"BAGridView";
    self.view.backgroundColor = BAKit_Color_White;
    
}

- (void)test
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellID];
    }
    
    NSString *msg = [@(indexPath.row + 1).stringValue stringByAppendingString:@"、"];
    cell.textLabel.text = [msg stringByAppendingString:self.dataArray[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            self.gridView.hidden = NO;
            
            UIView *footView = [self.view viewWithTag:100];
            
            if (!footView)
            {
                footView = [UIView new];
                footView.backgroundColor = [UIColor redColor];
                footView.frame = CGRectMake(0, 0, BAKit_SCREEN_WIDTH, kGridView_H);
                footView.tag = 100;
                self.gridView.frame = footView.bounds;
                [footView addSubview:self.gridView];
            }
            
            self.tableView.tableFooterView = footView;
        }
            break;
        case 1:
        {
            UIView *footView = [self.view viewWithTag:101];
            
            if (!footView)
            {
                footView = [UIView new];
                footView.backgroundColor = [UIColor redColor];
                footView.frame = CGRectMake(0, 0, BAKit_SCREEN_WIDTH, kGridView_H2);
                footView.tag = 101;
                self.gridView2.frame = footView.bounds;
                [footView addSubview:self.gridView2];
            }
            
            self.tableView.tableFooterView = footView;
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FLT_MIN;
}



- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
}

#pragma mark - setter / getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = BAKit_Color_Gray_11;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.estimatedRowHeight = 44;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (NSArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[@"图上文下", @"两行文字"];
    }
    return _dataArray;
}

- (BAGridView *)gridView
{
    if (!_gridView)
    {
        _gridView = [BAGridView ba_creatGridViewWithGridViewType:BAGridViewTypeImageTitle dataArray:self.gridDataArray configurationBlock:^(BAGridView *tempView) {
            
            // 是否显示分割线
            //            tempView.showLineView = NO;
            // item：分割线颜色，默认：BAKit_Color_Gray_11【BAKit_Color_RGB(248, 248, 248)】
            //            tempView.ba_gridView_lineColor = BAKit_Color_Red;
            // item：每行 item 的个数，默认为4个
            tempView.ba_gridView_rowCount = kGridView_rowCount;
            // item：高度
            tempView.ba_gridView_itemHeight = kGridView_itemHeight;
            // item：图片与文字间距（或者两行文字类型的间距），默认：0
            //            tempView.ba_gridView_itemImageInset = 10;
            //  item：title 颜色，默认：BAKit_Color_Black【[UIColor blackColor]】
            //            tempView.ba_gridView_titleColor = BAKit_Color_Black;
            // item：title Font，默认：图文样式下 16，两行文字下（上25，下12）
            tempView.ba_gridView_titleFont = [UIFont boldSystemFontOfSize:15];
            // item：背景颜色，默认：BAKit_Color_White
            tempView.ba_gridView_backgroundColor = BAKit_Color_White;
            // item：背景选中颜色，默认：无色
            tempView.ba_gridView_selectedBackgroundColor = BAKit_Color_Red;
            
            self.gridView = tempView;
            
        } block:^(BAGridItemModel *model, NSIndexPath *indexPath) {
            
            BAKit_ShowAlertWithMsg_ios8(model.titleString);
        }];
    }
    return _gridView;
}

- (BAGridView *)gridView2
{
    if (!_gridView2)
    {
        _gridView2 = [BAGridView ba_creatGridViewWithGridViewType:BAGridViewTypeTitleDesc dataArray:self.gridDataArray2 configurationBlock:^(BAGridView *tempView) {
            
            // item：分割线颜色，默认：BAKit_Color_Gray_11【BAKit_Color_RGB(248, 248, 248)】
            tempView.ba_gridView_lineColor = BAKit_Color_Red;
            // item：每行 item 的个数，默认为4个
            tempView.ba_gridView_rowCount = kGridView_rowCount2;
            // item：高度
            tempView.ba_gridView_itemHeight = kGridView_itemHeight2;
            // item：图片与文字间距（或者两行文字类型的间距），默认：0
            //            tempView.ba_gridView_itemImageInset = 10;
            //  item：title 颜色，默认：BAKit_Color_Black【[UIColor blackColor]】
            tempView.ba_gridView_titleColor = BAKit_Color_Black;
            //  item：Desc 颜色，默认：BAKit_Color_Gray_9【BAKit_Color_RGB(216, 220, 228)】
            tempView.ba_gridView_titleDescColor = BAKit_Color_Gray_7;
            // item：title Font，默认：图文样式下 16，两行文字下（上25，下12）
            tempView.ba_gridView_titleFont = [UIFont boldSystemFontOfSize:25];
            // item：Desc Font，默认：两行文字下 12
            tempView.ba_gridView_titleDescFont = [UIFont boldSystemFontOfSize:15];
            // item：背景颜色，默认：BAKit_Color_White
            //            tempView.ba_gridView_backgroundColor = [UIColor yellowColor];
            //            // item：背景选中颜色，默认：无色
            //            tempView.ba_gridView_selectedBackgroundColor = [UIColor greenColor];
            
            self.gridView2 = tempView;
            
        } block:^(BAGridItemModel *model, NSIndexPath *indexPath) {
            
            //            BAKit_ShowAlertWithMsg_ios8(model.titleString);
        }];
    }
    return _gridView2;
}

- (NSMutableArray <BAGridItemModel *> *)gridDataArray
{
    if (!_gridDataArray)
    {
        _gridDataArray = @[].mutableCopy;
        
        NSArray *imageNameArray = @[@"tabbar_mainframeHL", @"tabbar_mainframeHL", @"tabbar_mainframeHL", @"tabbar_mainframeHL", @"tabbar_mainframeHL"];
        NSArray *titleArray = @[@"扫一扫", @"付钱", @"卡包", @"收银", @"卡包"];
        
        for (NSInteger i = 0; i < titleArray.count; i++)
        {
            BAGridItemModel *model = [BAGridItemModel new];
            model.imageName = imageNameArray[i];
            model.titleString = titleArray[i];
            
            [self.gridDataArray addObject:model];
        }
    }
    return _gridDataArray;
}

- (NSMutableArray <BAGridItemModel *> *)gridDataArray2
{
    if (!_gridDataArray2)
    {
        _gridDataArray2 = @[].mutableCopy;
        
        NSArray *titleArray = @[@"200", @"20", @"200", @"10", ];
        NSArray *descArray = @[@"新增积分总量", @"返还积分总量", @"全返单元总量", @"每单元返还积分"];
        
        for (NSInteger i = 0; i < titleArray.count; i++)
        {
            BAGridItemModel *model = [BAGridItemModel new];
            model.desc = descArray[i];
            model.titleString = titleArray[i];
            
            [_gridDataArray2 addObject:model];
        }
    }
    return _gridDataArray2;
}


@end
