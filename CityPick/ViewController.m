//
//  ViewController.m
//  CityPick
//
//  Created by login on 16/1/29.
//  Copyright © 2016年 login. All rights reserved.
//

#import "ViewController.h"
#import "CityPickVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Home";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [button setBackgroundColor:[UIColor blackColor]];
    button.center = CGPointMake(self.view.center.x, 200);
    [button addTarget:self action:@selector(jumpToCityPick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)jumpToCityPick {
    CityPickVC *city = [[CityPickVC alloc]init];
    city.locationCity = @"北京";
    city.hotCityArray = @[@"北京市",@"天津市",@"广州市",@"上海市",@"杭州市",@"深圳市",@"武汉市",];
    city.selectCityName = ^(NSString *cityName) {
        NSLog(@"%@",cityName);
    };
    [self.navigationController pushViewController:city animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
