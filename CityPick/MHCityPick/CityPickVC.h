//
//  CityPickVC.h
//  CityPick
//
//  Created by login on 16/1/29.
//  Copyright © 2016年 login. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SectionNumber) {
    LocationSection,
    HotCitySection,
    CitySection
};

@interface CityPickVC : UIViewController
/**
 *  定位城市名称
 */
@property (nonatomic,copy) NSString *locationCity;
/**
 *  热门城市列表
 */
@property (nonatomic,copy) NSArray<NSString *> *hotCityArray;
/**
 *  选择的城市回调
 */
@property (nonatomic,copy) void (^selectCityName)(NSString *cityName);
@end
