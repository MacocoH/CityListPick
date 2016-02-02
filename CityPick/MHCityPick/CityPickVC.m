//
//  CityPickVC.m
//  CityPick
//
//  Created by login on 16/1/29.
//  Copyright © 2016年 login. All rights reserved.
//

#import "CityPickVC.h"
#import "HotCityTableViewCell.h"
#import "LocationCityTableViewCell.h"
@interface CityPickVC ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,LocationCityTableViewCellDelegate,HotCityTableViewCellDelegate> {
    UILabel *charLabel;
}
@property (nonatomic,copy) NSArray *indexList;
@property (nonatomic,retain) UITextField *searchCity;
@property (nonatomic,retain) UITableView *cityTableView;
@property (nonatomic,copy) NSDictionary *tableViewDic;
@end

@implementation CityPickVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"城市选择";
    [self getData];
    [self initIndexList];
    [self creatView];
}

- (void)getData {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    NSDictionary *cityDict = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    self.tableViewDic = [cityDict copy];
}

#pragma mark - 初始化索引列表
- (void)initIndexList {
    NSMutableArray *list = [[NSMutableArray alloc]init];
    [list addObject:@"定"];
    [list addObject:@"热"];
    for (char c='A'; c<='Z'; c++) {
        if (c != 'O' && c != 'U' && c != 'V' && c != 'I') {
            [list addObject:[NSString stringWithFormat:@"%c",c]];
        }
    }
    self.indexList = [list copy];
}
- (void)creatView {
    UIView *grayBack = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 50)];
    grayBack.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:grayBack];
    
    self.searchCity = [self textFieldForSearch];
    self.searchCity.frame = CGRectMake(15, 5, self.view.frame.size.width - 30, 40);
    self.searchCity.delegate = self;
    [grayBack addSubview:self.searchCity];
    
    self.cityTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(grayBack.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(grayBack.frame))];
    self.cityTableView.delegate = self;
    self.cityTableView.dataSource = self;
//    索引字体颜色
    self.cityTableView.sectionIndexColor = [UIColor redColor];
//    索引背景颜色
    self.cityTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self.view addSubview:self.cityTableView];
    
}
#pragma mark - 自定义搜索框
- (UITextField *)textFieldForSearch {
    UITextField *textField = [[UITextField alloc]init];
    textField.backgroundColor = [UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.clipsToBounds = YES;
    textField.layer.cornerRadius = 5;
    textField.placeholder = @"搜索全国城市";
    
    UIImageView *leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchBarLeftImage"]];
    leftView.contentMode = UIViewContentModeCenter;

    textField.leftView =leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    return textField;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == LocationSection) {
        return 1;
    } else if (section == HotCitySection) {
        return 1;
    } else {
        NSString *chara = self.indexList[section];
        NSArray *charaArray = self.tableViewDic[chara];
        return charaArray.count;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.indexList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == LocationSection) {
        static NSString *locationIdentifier = @"LocationSection";
        LocationCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:locationIdentifier];
        if (!cell) {
            cell = [[LocationCityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:locationIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        [cell.currentCity setTitle:self.locationCity forState:UIControlStateNormal];
        return cell;
    } else if (indexPath.section == HotCitySection) {
        static NSString *hotIdentifier = @"HotCitySection";
        HotCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:hotIdentifier];
        if (!cell) {
            cell = [[HotCityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hotIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        cell.hotCityArray = self.hotCityArray;
        return cell;
    } else {
        static NSString *cellIdentifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSString *chara = self.indexList[indexPath.section];
        NSArray *charaArray = self.tableViewDic[chara];
        cell.textLabel.text = charaArray[indexPath.row];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == HotCitySection) {
        return [HotCityTableViewCell getCellHeight];
    } else {
        return 44;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == LocationSection) {
        return @"定位城市";
    } else if (section == HotCitySection) {
        return @"热门城市";
    } else {
        NSString *chara = self.indexList[section];
        return chara;
    }
}
#pragma mark - 索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    }
    return self.indexList;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [self showBigSelectedCharacter:title];
    if ([title isEqual:@"定"]) {
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        return 0;
    }else if([title isEqual:@"热"])
    {
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        return 1;
    }
    else{
        NSInteger selectSection = 0;
        for (int i = 0; i<self.indexList.count; i++) {
            if ([self.indexList[i] isEqual:title]) {
                selectSection = i;
                break;
            }
            selectSection = 0;
        }
        if (self.tableViewDic != nil) {
            [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:selectSection] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            return selectSection;
            
        }else
        {
            return 0;
        }
    }
}

- (void)showBigSelectedCharacter:(NSString *)title
{
    if (charLabel) {
        [charLabel removeFromSuperview];
    }
    
    charLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    charLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    charLabel.backgroundColor = [UIColor redColor];
    charLabel.text = title;
    charLabel.textAlignment = NSTextAlignmentCenter;
    charLabel.font = [UIFont boldSystemFontOfSize:35];
    charLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:charLabel];
    
    [UIView animateWithDuration:1 animations:^{
        charLabel.alpha = 0;
    }];
}
#pragma mark - 点击返回
//点击定位城市
- (void)clickLocationCityTableViewCell:(UIButton *)button
{
    if (button.titleLabel.text.length != 0 && ![self.locationCity isEqualToString:@"正在定位"]) {
        self.selectCityName(self.locationCity);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//点击热门城市
- (void)clickHotCityTableViewCell:(UIButton *)button
{
    self.selectCityName(button.titleLabel.text);
    if (button.titleLabel.text.length != 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//点击tableViewCell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >= 2) {
        NSString *chara = self.indexList[indexPath.section];
        NSArray *charaArray = self.tableViewDic[chara];
        self.selectCityName(charaArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
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
